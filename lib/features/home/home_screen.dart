import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import 'providers/bluetooth_provider.dart';
import 'providers/session_provider.dart';
import 'widgets/connection_card.dart';
import 'widgets/posture_status_card.dart';
import 'widgets/sensor_values_card.dart';
import 'widgets/session_timer_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ble             = ref.watch(bluetoothProvider);
    final session         = ref.watch(sessionProvider);
    final sessionNotifier = ref.read(sessionProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ConnectionCard(),
            const SizedBox(height: 16),
            const PostureStatusCard(),
            const SizedBox(height: 16),
            const SensorValuesCard(),
            if (session.isActive) ...[
              const SizedBox(height: 16),
              const SessionTimerWidget(),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: session.isActive
                  ? FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.bad.withAlpha(26),
                        foregroundColor: AppColors.bad,
                      ),
                      onPressed: sessionNotifier.stopSession,
                      child: const Text(AppStrings.stopSession),
                    )
                  : FilledButton(
                      onPressed:
                          ble.isConnected ? sessionNotifier.startSession : null,
                      child: const Text(AppStrings.startSession),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
