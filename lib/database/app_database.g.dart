// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startTime,
    endTime,
    durationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationSeconds;
  const Session({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.durationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['duration_seconds'] = Variable<int>(durationSeconds);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationSeconds: Value(durationSeconds),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
    };
  }

  Session copyWith({
    int? id,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    int? durationSeconds,
  }) => Session(
    id: id ?? this.id,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    durationSeconds: durationSeconds ?? this.durationSeconds,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startTime, endTime, durationSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationSeconds == this.durationSeconds);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int> durationSeconds;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  }) : startTime = Value(startTime);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<int>? durationSeconds,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }
}

class $SensorReadingsTable extends SensorReadings
    with TableInfo<$SensorReadingsTable, SensorReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensorReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leftPressureMeta = const VerificationMeta(
    'leftPressure',
  );
  @override
  late final GeneratedColumn<int> leftPressure = GeneratedColumn<int>(
    'left_pressure',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rightPressureMeta = const VerificationMeta(
    'rightPressure',
  );
  @override
  late final GeneratedColumn<int> rightPressure = GeneratedColumn<int>(
    'right_pressure',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backPressureMeta = const VerificationMeta(
    'backPressure',
  );
  @override
  late final GeneratedColumn<int> backPressure = GeneratedColumn<int>(
    'back_pressure',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _neckPressureMeta = const VerificationMeta(
    'neckPressure',
  );
  @override
  late final GeneratedColumn<int> neckPressure = GeneratedColumn<int>(
    'neck_pressure',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _postureLabelMeta = const VerificationMeta(
    'postureLabel',
  );
  @override
  late final GeneratedColumn<String> postureLabel = GeneratedColumn<String>(
    'posture_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    timestamp,
    leftPressure,
    rightPressure,
    backPressure,
    neckPressure,
    postureLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sensor_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SensorReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('left_pressure')) {
      context.handle(
        _leftPressureMeta,
        leftPressure.isAcceptableOrUnknown(
          data['left_pressure']!,
          _leftPressureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_leftPressureMeta);
    }
    if (data.containsKey('right_pressure')) {
      context.handle(
        _rightPressureMeta,
        rightPressure.isAcceptableOrUnknown(
          data['right_pressure']!,
          _rightPressureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rightPressureMeta);
    }
    if (data.containsKey('back_pressure')) {
      context.handle(
        _backPressureMeta,
        backPressure.isAcceptableOrUnknown(
          data['back_pressure']!,
          _backPressureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_backPressureMeta);
    }
    if (data.containsKey('neck_pressure')) {
      context.handle(
        _neckPressureMeta,
        neckPressure.isAcceptableOrUnknown(
          data['neck_pressure']!,
          _neckPressureMeta,
        ),
      );
    }
    if (data.containsKey('posture_label')) {
      context.handle(
        _postureLabelMeta,
        postureLabel.isAcceptableOrUnknown(
          data['posture_label']!,
          _postureLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_postureLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SensorReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensorReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      leftPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}left_pressure'],
      )!,
      rightPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}right_pressure'],
      )!,
      backPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}back_pressure'],
      )!,
      neckPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}neck_pressure'],
      )!,
      postureLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}posture_label'],
      )!,
    );
  }

  @override
  $SensorReadingsTable createAlias(String alias) {
    return $SensorReadingsTable(attachedDatabase, alias);
  }
}

class SensorReading extends DataClass implements Insertable<SensorReading> {
  final int id;
  final int sessionId;
  final DateTime timestamp;
  final int leftPressure;
  final int rightPressure;
  final int backPressure;
  final int neckPressure;
  final String postureLabel;
  const SensorReading({
    required this.id,
    required this.sessionId,
    required this.timestamp,
    required this.leftPressure,
    required this.rightPressure,
    required this.backPressure,
    required this.neckPressure,
    required this.postureLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['left_pressure'] = Variable<int>(leftPressure);
    map['right_pressure'] = Variable<int>(rightPressure);
    map['back_pressure'] = Variable<int>(backPressure);
    map['neck_pressure'] = Variable<int>(neckPressure);
    map['posture_label'] = Variable<String>(postureLabel);
    return map;
  }

  SensorReadingsCompanion toCompanion(bool nullToAbsent) {
    return SensorReadingsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      timestamp: Value(timestamp),
      leftPressure: Value(leftPressure),
      rightPressure: Value(rightPressure),
      backPressure: Value(backPressure),
      neckPressure: Value(neckPressure),
      postureLabel: Value(postureLabel),
    );
  }

  factory SensorReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensorReading(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      leftPressure: serializer.fromJson<int>(json['leftPressure']),
      rightPressure: serializer.fromJson<int>(json['rightPressure']),
      backPressure: serializer.fromJson<int>(json['backPressure']),
      neckPressure: serializer.fromJson<int>(json['neckPressure']),
      postureLabel: serializer.fromJson<String>(json['postureLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'leftPressure': serializer.toJson<int>(leftPressure),
      'rightPressure': serializer.toJson<int>(rightPressure),
      'backPressure': serializer.toJson<int>(backPressure),
      'neckPressure': serializer.toJson<int>(neckPressure),
      'postureLabel': serializer.toJson<String>(postureLabel),
    };
  }

  SensorReading copyWith({
    int? id,
    int? sessionId,
    DateTime? timestamp,
    int? leftPressure,
    int? rightPressure,
    int? backPressure,
    int? neckPressure,
    String? postureLabel,
  }) => SensorReading(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    timestamp: timestamp ?? this.timestamp,
    leftPressure: leftPressure ?? this.leftPressure,
    rightPressure: rightPressure ?? this.rightPressure,
    backPressure: backPressure ?? this.backPressure,
    neckPressure: neckPressure ?? this.neckPressure,
    postureLabel: postureLabel ?? this.postureLabel,
  );
  SensorReading copyWithCompanion(SensorReadingsCompanion data) {
    return SensorReading(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      leftPressure: data.leftPressure.present
          ? data.leftPressure.value
          : this.leftPressure,
      rightPressure: data.rightPressure.present
          ? data.rightPressure.value
          : this.rightPressure,
      backPressure: data.backPressure.present
          ? data.backPressure.value
          : this.backPressure,
      neckPressure: data.neckPressure.present
          ? data.neckPressure.value
          : this.neckPressure,
      postureLabel: data.postureLabel.present
          ? data.postureLabel.value
          : this.postureLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SensorReading(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('leftPressure: $leftPressure, ')
          ..write('rightPressure: $rightPressure, ')
          ..write('backPressure: $backPressure, ')
          ..write('neckPressure: $neckPressure, ')
          ..write('postureLabel: $postureLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    timestamp,
    leftPressure,
    rightPressure,
    backPressure,
    neckPressure,
    postureLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorReading &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.timestamp == this.timestamp &&
          other.leftPressure == this.leftPressure &&
          other.rightPressure == this.rightPressure &&
          other.backPressure == this.backPressure &&
          other.neckPressure == this.neckPressure &&
          other.postureLabel == this.postureLabel);
}

class SensorReadingsCompanion extends UpdateCompanion<SensorReading> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<DateTime> timestamp;
  final Value<int> leftPressure;
  final Value<int> rightPressure;
  final Value<int> backPressure;
  final Value<int> neckPressure;
  final Value<String> postureLabel;
  const SensorReadingsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.leftPressure = const Value.absent(),
    this.rightPressure = const Value.absent(),
    this.backPressure = const Value.absent(),
    this.neckPressure = const Value.absent(),
    this.postureLabel = const Value.absent(),
  });
  SensorReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required DateTime timestamp,
    required int leftPressure,
    required int rightPressure,
    required int backPressure,
    this.neckPressure = const Value.absent(),
    required String postureLabel,
  }) : sessionId = Value(sessionId),
       timestamp = Value(timestamp),
       leftPressure = Value(leftPressure),
       rightPressure = Value(rightPressure),
       backPressure = Value(backPressure),
       postureLabel = Value(postureLabel);
  static Insertable<SensorReading> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<DateTime>? timestamp,
    Expression<int>? leftPressure,
    Expression<int>? rightPressure,
    Expression<int>? backPressure,
    Expression<int>? neckPressure,
    Expression<String>? postureLabel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (timestamp != null) 'timestamp': timestamp,
      if (leftPressure != null) 'left_pressure': leftPressure,
      if (rightPressure != null) 'right_pressure': rightPressure,
      if (backPressure != null) 'back_pressure': backPressure,
      if (neckPressure != null) 'neck_pressure': neckPressure,
      if (postureLabel != null) 'posture_label': postureLabel,
    });
  }

  SensorReadingsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<DateTime>? timestamp,
    Value<int>? leftPressure,
    Value<int>? rightPressure,
    Value<int>? backPressure,
    Value<int>? neckPressure,
    Value<String>? postureLabel,
  }) {
    return SensorReadingsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      leftPressure: leftPressure ?? this.leftPressure,
      rightPressure: rightPressure ?? this.rightPressure,
      backPressure: backPressure ?? this.backPressure,
      neckPressure: neckPressure ?? this.neckPressure,
      postureLabel: postureLabel ?? this.postureLabel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (leftPressure.present) {
      map['left_pressure'] = Variable<int>(leftPressure.value);
    }
    if (rightPressure.present) {
      map['right_pressure'] = Variable<int>(rightPressure.value);
    }
    if (backPressure.present) {
      map['back_pressure'] = Variable<int>(backPressure.value);
    }
    if (neckPressure.present) {
      map['neck_pressure'] = Variable<int>(neckPressure.value);
    }
    if (postureLabel.present) {
      map['posture_label'] = Variable<String>(postureLabel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensorReadingsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('leftPressure: $leftPressure, ')
          ..write('rightPressure: $rightPressure, ')
          ..write('backPressure: $backPressure, ')
          ..write('neckPressure: $neckPressure, ')
          ..write('postureLabel: $postureLabel')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SensorReadingsTable sensorReadings = $SensorReadingsTable(this);
  late final SessionsDao sessionsDao = SessionsDao(this as AppDatabase);
  late final SensorReadingsDao sensorReadingsDao = SensorReadingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessions,
    sensorReadings,
  ];
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<int> durationSeconds,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<int> durationSeconds,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SensorReadingsTable, List<SensorReading>>
  _sensorReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sensorReadings,
    aliasName: $_aliasNameGenerator(
      db.sessions.id,
      db.sensorReadings.sessionId,
    ),
  );

  $$SensorReadingsTableProcessedTableManager get sensorReadingsRefs {
    final manager = $$SensorReadingsTableTableManager(
      $_db,
      $_db.sensorReadings,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sensorReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sensorReadingsRefs(
    Expression<bool> Function($$SensorReadingsTableFilterComposer f) f,
  ) {
    final $$SensorReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sensorReadings,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensorReadingsTableFilterComposer(
            $db: $db,
            $table: $db.sensorReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  Expression<T> sensorReadingsRefs<T extends Object>(
    Expression<T> Function($$SensorReadingsTableAnnotationComposer a) f,
  ) {
    final $$SensorReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sensorReadings,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensorReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.sensorReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool sensorReadingsRefs})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                startTime: startTime,
                endTime: endTime,
                durationSeconds: durationSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                startTime: startTime,
                endTime: endTime,
                durationSeconds: durationSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sensorReadingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sensorReadingsRefs) db.sensorReadings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sensorReadingsRefs)
                    await $_getPrefetchedData<
                      Session,
                      $SessionsTable,
                      SensorReading
                    >(
                      currentTable: table,
                      referencedTable: $$SessionsTableReferences
                          ._sensorReadingsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SessionsTableReferences(
                        db,
                        table,
                        p0,
                      ).sensorReadingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool sensorReadingsRefs})
    >;
typedef $$SensorReadingsTableCreateCompanionBuilder =
    SensorReadingsCompanion Function({
      Value<int> id,
      required int sessionId,
      required DateTime timestamp,
      required int leftPressure,
      required int rightPressure,
      required int backPressure,
      Value<int> neckPressure,
      required String postureLabel,
    });
typedef $$SensorReadingsTableUpdateCompanionBuilder =
    SensorReadingsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<DateTime> timestamp,
      Value<int> leftPressure,
      Value<int> rightPressure,
      Value<int> backPressure,
      Value<int> neckPressure,
      Value<String> postureLabel,
    });

final class $$SensorReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $SensorReadingsTable, SensorReading> {
  $$SensorReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.sensorReadings.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SensorReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $SensorReadingsTable> {
  $$SensorReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leftPressure => $composableBuilder(
    column: $table.leftPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rightPressure => $composableBuilder(
    column: $table.rightPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get backPressure => $composableBuilder(
    column: $table.backPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get neckPressure => $composableBuilder(
    column: $table.neckPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postureLabel => $composableBuilder(
    column: $table.postureLabel,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SensorReadingsTable> {
  $$SensorReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leftPressure => $composableBuilder(
    column: $table.leftPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rightPressure => $composableBuilder(
    column: $table.rightPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backPressure => $composableBuilder(
    column: $table.backPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get neckPressure => $composableBuilder(
    column: $table.neckPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postureLabel => $composableBuilder(
    column: $table.postureLabel,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SensorReadingsTable> {
  $$SensorReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get leftPressure => $composableBuilder(
    column: $table.leftPressure,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rightPressure => $composableBuilder(
    column: $table.rightPressure,
    builder: (column) => column,
  );

  GeneratedColumn<int> get backPressure => $composableBuilder(
    column: $table.backPressure,
    builder: (column) => column,
  );

  GeneratedColumn<int> get neckPressure => $composableBuilder(
    column: $table.neckPressure,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postureLabel => $composableBuilder(
    column: $table.postureLabel,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SensorReadingsTable,
          SensorReading,
          $$SensorReadingsTableFilterComposer,
          $$SensorReadingsTableOrderingComposer,
          $$SensorReadingsTableAnnotationComposer,
          $$SensorReadingsTableCreateCompanionBuilder,
          $$SensorReadingsTableUpdateCompanionBuilder,
          (SensorReading, $$SensorReadingsTableReferences),
          SensorReading,
          PrefetchHooks Function({bool sessionId})
        > {
  $$SensorReadingsTableTableManager(
    _$AppDatabase db,
    $SensorReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SensorReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SensorReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SensorReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> leftPressure = const Value.absent(),
                Value<int> rightPressure = const Value.absent(),
                Value<int> backPressure = const Value.absent(),
                Value<int> neckPressure = const Value.absent(),
                Value<String> postureLabel = const Value.absent(),
              }) => SensorReadingsCompanion(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                leftPressure: leftPressure,
                rightPressure: rightPressure,
                backPressure: backPressure,
                neckPressure: neckPressure,
                postureLabel: postureLabel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required DateTime timestamp,
                required int leftPressure,
                required int rightPressure,
                required int backPressure,
                Value<int> neckPressure = const Value.absent(),
                required String postureLabel,
              }) => SensorReadingsCompanion.insert(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                leftPressure: leftPressure,
                rightPressure: rightPressure,
                backPressure: backPressure,
                neckPressure: neckPressure,
                postureLabel: postureLabel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SensorReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$SensorReadingsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn:
                                    $$SensorReadingsTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SensorReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SensorReadingsTable,
      SensorReading,
      $$SensorReadingsTableFilterComposer,
      $$SensorReadingsTableOrderingComposer,
      $$SensorReadingsTableAnnotationComposer,
      $$SensorReadingsTableCreateCompanionBuilder,
      $$SensorReadingsTableUpdateCompanionBuilder,
      (SensorReading, $$SensorReadingsTableReferences),
      SensorReading,
      PrefetchHooks Function({bool sessionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SensorReadingsTableTableManager get sensorReadings =>
      $$SensorReadingsTableTableManager(_db, _db.sensorReadings);
}
