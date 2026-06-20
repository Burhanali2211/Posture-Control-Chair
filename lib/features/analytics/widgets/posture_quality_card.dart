import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/app_card.dart';
import '../providers/analytics_providers.dart';

class PostureQualityCard extends ConsumerWidget {
  const PostureQualityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(overallPostureSummaryProvider);

    return AppCard(
      child: summaryAsync.when(
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CircularProgressIndicator(),
          ),
        ),
        error: (e, _) => Text('Error: $e'),
        data: (summary) {
          final good  = summary['good'] ?? 0;
          final bad   = summary['bad'] ?? 0;
          final total = good + bad;

          if (total == 0) {
            return Text(
              'No data for the last 7 days.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
            );
          }

          final goodPct = (good / total * 100).round();
          final badPct  = 100 - goodPct;

          return Column(
            children: [
              _QualityRow(
                label: AppStrings.goodPostureTime,
                pct:   goodPct,
                color: AppColors.good,
              ),
              const SizedBox(height: 14),
              _QualityRow(
                label: AppStrings.badPostureTime,
                pct:   badPct,
                color: AppColors.bad,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QualityRow extends StatelessWidget {
  const _QualityRow({
    required this.label,
    required this.pct,
    required this.color,
  });

  final String label;
  final int pct;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:      color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '$pct%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:      color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value:      pct / 100,
            minHeight:  8,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
