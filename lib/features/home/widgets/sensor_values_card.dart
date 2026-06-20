import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/sensor_count_provider.dart';
import '../../../widgets/app_card.dart';
import '../providers/sensor_provider.dart';

const int _kMaxSensorValue = 1023;

class SensorValuesCard extends ConsumerWidget {
  const SensorValuesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packet = ref.watch(latestPacketProvider);
    final count  = ref.watch(sensorCountProvider);

    final all = [
      (AppStrings.leftPressure,  packet?.left),
      (AppStrings.rightPressure, packet?.right),
      (AppStrings.backPressure,  packet?.back),
      (AppStrings.neckPressure,  packet?.neck),
    ];
    final sensors = all.take(count).toList();

    Row buildRow(List<(String, int?)> items) => Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          _SensorTile(label: items[i].$1, value: items[i].$2),
        ],
      ],
    );

    return AppCard(
      child: count == 4
          ? Column(
              children: [
                buildRow(sensors.sublist(0, 2)),
                const SizedBox(height: 16),
                buildRow(sensors.sublist(2, 4)),
              ],
            )
          : buildRow(sensors),
    );
  }
}

class _SensorTile extends StatelessWidget {
  const _SensorTile({required this.label, required this.value});

  final String label;
  final int? value;

  @override
  Widget build(BuildContext context) {
    final displayValue = value ?? 0;
    final progress     = displayValue / _kMaxSensorValue;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color:      AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value != null ? '$displayValue' : '--',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value:      progress,
              minHeight:  6,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
