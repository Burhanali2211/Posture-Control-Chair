import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/duration_formatter.dart';
import '../../../database/app_database.dart';
import '../providers/history_providers.dart';

class SessionDetailSheet extends ConsumerWidget {
  const SessionDetailSheet({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(sessionSummaryProvider(session.id));

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            DateFormatter.dateTime(session.startTime),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Duration: ${DurationFormatter.format(Duration(seconds: session.durationSeconds))}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            'Posture Summary',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          summaryAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => const Text('Could not load summary.'),
            data: (summary) => _PostureSummary(summary: summary),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _PostureSummary extends StatelessWidget {
  const _PostureSummary({required this.summary});

  final Map<String, int> summary;

  @override
  Widget build(BuildContext context) {
    final good  = summary['good'] ?? 0;
    final bad   = summary['bad'] ?? 0;
    final total = good + bad;

    if (total == 0) {
      return Text(
        'No sensor readings recorded.',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.textMuted),
      );
    }

    final goodPct = (good / total * 100).round();
    final badPct  = 100 - goodPct;

    return Column(
      children: [
        _SummaryRow(
          label: 'Good',
          count: good,
          pct: goodPct,
          color: AppColors.good,
        ),
        const SizedBox(height: 10),
        _SummaryRow(
          label: 'Poor',
          count: bad,
          pct: badPct,
          color: AppColors.bad,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.count,
    required this.pct,
    required this.color,
  });

  final String label;
  final int count;
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
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              '$count readings · $pct%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
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
