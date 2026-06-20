import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../widgets/section_header.dart';
import 'widgets/posture_quality_card.dart';
import 'widgets/weekly_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.navAnalytics)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: AppStrings.dailySitting),
            const SizedBox(height: 12),
            const WeeklyChart(),
            const SizedBox(height: 28),
            const SectionHeader(title: 'Posture Quality — Last 7 Days'),
            const SizedBox(height: 12),
            const PostureQualityCard(),
          ],
        ),
      ),
    );
  }
}
