import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/posture_classifier.dart';
import '../../../widgets/app_card.dart';
import '../providers/sensor_provider.dart';

class PostureStatusCard extends ConsumerWidget {
  const PostureStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posture = ref.watch(currentPostureProvider);

    final (icon, label, color, bgAlpha) = switch (posture) {
      PostureLabel.good    => (Icons.check_circle_rounded, AppStrings.goodPosture, AppColors.good,     26),
      PostureLabel.bad     => (Icons.warning_rounded,      AppStrings.badPosture,  AppColors.bad,      26),
      PostureLabel.unknown => (Icons.sensors_off_rounded,  AppStrings.noData,      AppColors.textMuted, 0),
    };

    return AppCard(
      color: posture == PostureLabel.unknown
          ? null
          : color.withAlpha(bgAlpha),
      child: Column(
        children: [
          Icon(icon, size: 64, color: color),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color:      color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
