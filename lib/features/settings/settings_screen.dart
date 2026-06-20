import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/providers/posture_thresholds_provider.dart';
import '../../core/providers/sensor_count_provider.dart';
import '../../core/utils/date_formatter.dart';
import '../../database/database_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/section_header.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _exporting = false;

  Future<void> _exportCsv() async {
    if (_exporting) return;
    setState(() => _exporting = true);

    try {
      final db       = ref.read(databaseProvider);
      final sessions = await db.sessionsDao.getAllSessions();

      final rows = <List<dynamic>>[
        [
          'Session ID', 'Date', 'Start Time', 'Duration (s)',
          'Left Pressure', 'Right Pressure', 'Back Pressure',
          'Neck Pressure', 'Posture', 'Reading Timestamp',
        ],
      ];

      for (final session in sessions) {
        final readings =
            await db.sensorReadingsDao.getReadingsForSession(session.id);
        if (readings.isEmpty) {
          rows.add([
            session.id, DateFormatter.date(session.startTime),
            DateFormatter.time(session.startTime), session.durationSeconds,
            '', '', '', '', '', '',
          ]);
        } else {
          for (final r in readings) {
            rows.add([
              session.id, DateFormatter.date(session.startTime),
              DateFormatter.time(session.startTime), session.durationSeconds,
              r.leftPressure, r.rightPressure, r.backPressure,
              r.neckPressure, r.postureLabel, r.timestamp.toIso8601String(),
            ]);
          }
        }
      }

      final csv  = const ListToCsvConverter().convert(rows);
      final dir  = await getTemporaryDirectory();
      final ts   = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/posture_data_$ts.csv');
      await file.writeAsString(csv);

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'text/csv')],
        subject: 'Posture Chair Data Export',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sensorCount = ref.watch(sensorCountProvider);
    final thresholds  = ref.watch(postureThresholdsProvider);
    final thresh      = ref.read(postureThresholdsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.navSettings)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Sensors ──────────────────────────────────────────
            const SectionHeader(title: AppStrings.sensors),
            const SizedBox(height: 12),
            AppCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.sensorCount,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Number of active pressure sensors',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 2, label: Text('2')),
                      ButtonSegment(value: 3, label: Text('3')),
                      ButtonSegment(value: 4, label: Text('4')),
                    ],
                    selected: {sensorCount},
                    onSelectionChanged: (s) =>
                        ref.read(sensorCountProvider.notifier).setCount(s.first),
                    showSelectedIcon: false,
                  ),
                ],
              ),
            ),

            // ── Posture Thresholds ────────────────────────────────
            const SizedBox(height: 24),
            const SectionHeader(title: AppStrings.postureThresholds),
            const SizedBox(height: 12),
            AppCard(
              child: Column(
                children: [
                  _ThresholdRow(
                    label:    AppStrings.backPressureThreshold,
                    subtitle: 'Min back pressure for good posture',
                    value:    thresholds.backPressureMin,
                    min:      100,
                    max:      700,
                    onChanged: thresh.setBackPressureMin,
                  ),
                  const Divider(height: 1),
                  _ThresholdRow(
                    label:    AppStrings.balanceTolerance,
                    subtitle: 'Max left/right pressure difference',
                    value:    thresholds.sideImbalanceMax,
                    min:      50,
                    max:      400,
                    onChanged: thresh.setSideImbalanceMax,
                  ),
                  const Divider(height: 1),
                  _ThresholdRow(
                    label:    AppStrings.neckPressureThreshold,
                    subtitle: 'Max neck pressure before warning',
                    value:    thresholds.neckPressureMax,
                    min:      200,
                    max:      900,
                    onChanged: thresh.setNeckPressureMax,
                  ),
                ],
              ),
            ),

            // ── Export ────────────────────────────────────────────
            const SizedBox(height: 24),
            const SectionHeader(title: AppStrings.exportData),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: _exporting ? null : _exportCsv,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width:  40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:        AppColors.primary.withAlpha(26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.file_download_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.exportCsv,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Share all sessions as a spreadsheet',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _exporting
                          ? const SizedBox(
                              width:  20,
                              height: 20,
                              child:  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textMuted,
                            ),
                    ],
                  ),
                ),
              ),
            ),

            // ── About ─────────────────────────────────────────────
            const SizedBox(height: 24),
            const SectionHeader(title: AppStrings.about),
            const SizedBox(height: 12),
            AppCard(
              child: Row(
                children: [
                  Container(
                    width:  48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:        AppColors.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.chair_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.appName,
                        style: Theme.of(context).textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${AppStrings.version} 1.0.0',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                      Text(
                        AppStrings.madeBy,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ThresholdRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _ThresholdRow({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              Text(
                '$value',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:      AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          Slider(
            value:       value.toDouble(),
            min:         min.toDouble(),
            max:         max.toDouble(),
            divisions:   (max - min) ~/ 10,
            label:       '$value',
            onChanged:   (v) => onChanged(v.round()),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
