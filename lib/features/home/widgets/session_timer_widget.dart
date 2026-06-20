import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/duration_formatter.dart';
import '../../../widgets/app_card.dart';
import '../providers/session_provider.dart';

class SessionTimerWidget extends ConsumerWidget {
  const SessionTimerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapsed = ref.watch(sessionProvider.select((s) => s.elapsed));

    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Session',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
          Text(
            DurationFormatter.format(elapsed),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
          ),
        ],
      ),
    );
  }
}
