import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/empty_state_view.dart';
import '../providers/analytics_providers.dart';

const _kDayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class WeeklyChart extends ConsumerWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(weeklyDurationProvider);

    return AppCard(
      padding: const EdgeInsets.fromLTRB(12, 20, 20, 12),
      child: SizedBox(
        height: 200,
        child: dataAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => const EmptyStateView(
            icon:    Icons.error_outline_rounded,
            message: 'Could not load chart data',
          ),
          data: (data) {
            final hasData = data.any((d) => d.minutes > 0);
            if (!hasData) {
              return const EmptyStateView(
                icon:     Icons.bar_chart_rounded,
                message:  'No sessions this week',
                subtitle: 'Start a session to see your sitting data here',
              );
            }
            return _Chart(data: data);
          },
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.data});

  final List<DailyDuration> data;

  double get _maxY {
    final max = data.fold(0.0, (prev, e) => e.minutes > prev ? e.minutes : prev);
    if (max == 0) return 60;
    return ((max / 10).ceil() * 10).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: _maxY,
        barGroups: data.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY:          e.value.minutes,
                color:        AppColors.primary,
                width:        24,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles:   true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= data.length) return const SizedBox.shrink();
                final label = _kDayLabels[data[idx].date.weekday - 1];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles:   true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0 || value == _maxY) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}m',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => const FlLine(
            color:       AppColors.border,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
