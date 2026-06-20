import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/posture_thresholds.dart';
import '../../../core/providers/posture_thresholds_provider.dart';
import '../../../core/utils/posture_classifier.dart';
import '../../../database/app_database.dart';
import '../../../database/database_provider.dart';
import '../../../services/bluetooth/ble_packet.dart';
import '../../../services/bluetooth/bluetooth_service.dart';
import '../../../services/bluetooth/bluetooth_service_provider.dart';

class SessionState {
  final bool isActive;
  final int? sessionId;
  final DateTime? startTime;
  final Duration elapsed;

  const SessionState({
    required this.isActive,
    this.sessionId,
    this.startTime,
    this.elapsed = Duration.zero,
  });

  SessionState copyWith({
    bool? isActive,
    int? sessionId,
    DateTime? startTime,
    Duration? elapsed,
  }) =>
      SessionState(
        isActive:  isActive  ?? this.isActive,
        sessionId: sessionId ?? this.sessionId,
        startTime: startTime ?? this.startTime,
        elapsed:   elapsed   ?? this.elapsed,
      );
}

class SessionNotifier extends StateNotifier<SessionState> {
  final AppDatabase _db;
  final BluetoothService _bleService;
  final PostureThresholdsNotifier _thresholds;

  Timer? _clockTimer;
  Timer? _flushTimer;
  StreamSubscription<BlePacket>? _packetSub;
  final List<SensorReadingsCompanion> _buffer = [];

  SessionNotifier(this._db, this._bleService, this._thresholds)
      : super(const SessionState(isActive: false, elapsed: Duration.zero));

  Future<void> startSession() async {
    if (state.isActive) return;
    final now = DateTime.now();
    final id = await _db.sessionsDao.insertSession(
      SessionsCompanion(startTime: Value(now)),
    );
    state = SessionState(isActive: true, sessionId: id, startTime: now);

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsed: DateTime.now().difference(state.startTime!));
    });

    _packetSub = _bleService.packets.listen(_onPacket);

    _flushTimer = Timer.periodic(
      const Duration(seconds: PostureThresholds.writeIntervalSeconds),
      (_) => _flush(),
    );
  }

  void _onPacket(BlePacket packet) {
    if (!state.isActive || state.sessionId == null) return;
    final t     = _thresholds.state;
    final label = PostureClassifier.classify(
      packet.left,
      packet.right,
      packet.back,
      neck:         packet.neck,
      backMin:      t.backPressureMin,
      imbalanceMax: t.sideImbalanceMax,
      neckMax:      t.neckPressureMax,
    );
    _buffer.add(SensorReadingsCompanion(
      sessionId:     Value(state.sessionId!),
      timestamp:     Value(packet.receivedAt),
      leftPressure:  Value(packet.left),
      rightPressure: Value(packet.right),
      backPressure:  Value(packet.back),
      neckPressure:  Value(packet.neck),
      postureLabel:  Value(PostureClassifier.toLabel(label)),
    ));
  }

  Future<void> _flush() async {
    if (_buffer.isEmpty) return;
    final toWrite = List<SensorReadingsCompanion>.from(_buffer);
    _buffer.clear();
    await _db.sensorReadingsDao.insertBatch(toWrite);
  }

  Future<void> stopSession() async {
    if (!state.isActive || state.sessionId == null) return;
    _clockTimer?.cancel();
    _flushTimer?.cancel();
    _packetSub?.cancel();
    await _flush();
    await _db.sessionsDao.closeSession(
      state.sessionId!,
      DateTime.now(),
      state.elapsed.inSeconds,
    );
    state = const SessionState(isActive: false, elapsed: Duration.zero);
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _flushTimer?.cancel();
    _packetSub?.cancel();
    super.dispose();
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  final db         = ref.watch(databaseProvider);
  final service    = ref.watch(bluetoothServiceProvider);
  // ref.read so threshold changes don't destroy an active session.
  final thresholds = ref.read(postureThresholdsProvider.notifier);
  return SessionNotifier(db, service, thresholds);
});
