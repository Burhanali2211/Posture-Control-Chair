import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../services/bluetooth/bluetooth_service.dart';
import '../../../widgets/app_card.dart';
import '../providers/bluetooth_provider.dart';

class ConnectionCard extends ConsumerWidget {
  const ConnectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ble      = ref.watch(bluetoothProvider);
    final notifier = ref.read(bluetoothProvider.notifier);

    final (dotColor, label) = switch (ble.connectionState) {
      BleConnectionState.connected    => (AppColors.good,      AppStrings.connected),
      BleConnectionState.scanning     => (AppColors.primary,   AppStrings.scanning),
      BleConnectionState.connecting   => (AppColors.primary,   AppStrings.connecting),
      BleConnectionState.disconnected => (AppColors.textMuted, AppStrings.disconnected),
      BleConnectionState.error        => (AppColors.bad,       'Scan Failed'),
      BleConnectionState.idle         => (AppColors.textMuted, AppStrings.disconnected),
    };

    return AppCard(
      child: Row(
        children: [
          Container(
            width:  10,
            height: 10,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (ble.hasError && ble.errorMessage != null)
                  Text(
                    ble.errorMessage!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  )
                else if (ble.deviceName != null)
                  Text(
                    ble.deviceName!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (ble.isConnected)
            TextButton(
              onPressed: notifier.disconnect,
              child: const Text('Disconnect'),
            )
          else if (ble.isScanning || ble.isConnecting)
            const SizedBox(
              width:  20,
              height: 20,
              child:  CircularProgressIndicator(strokeWidth: 2),
            )
          else
            FilledButton(
              onPressed: notifier.scan,
              child: const Text('Scan'),
            ),
        ],
      ),
    );
  }
}
