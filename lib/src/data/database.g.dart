// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WorksTable extends Works with TableInfo<$WorksTable, Work> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverPathMeta =
      const VerificationMeta('coverPath');
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
      'cover_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, coverPath, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'works';
  @override
  VerificationContext validateIntegrity(Insertable<Work> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cover_path')) {
      context.handle(_coverPathMeta,
          coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Work(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coverPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorksTable createAlias(String alias) {
    return $WorksTable(attachedDatabase, alias);
  }
}

class Work extends DataClass implements Insertable<Work> {
  final String id;
  final String name;
  final String? coverPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Work(
      {required this.id,
      required this.name,
      this.coverPath,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorksCompanion toCompanion(bool nullToAbsent) {
    return WorksCompanion(
      id: Value(id),
      name: Value(name),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Work.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'coverPath': serializer.toJson<String?>(coverPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Work copyWith(
          {String? id,
          String? name,
          Value<String?> coverPath = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Work(
        id: id ?? this.id,
        name: name ?? this.name,
        coverPath: coverPath.present ? coverPath.value : this.coverPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Work copyWithCompanion(WorksCompanion data) {
    return Work(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Work(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverPath: $coverPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, coverPath, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Work &&
          other.id == this.id &&
          other.name == this.name &&
          other.coverPath == this.coverPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorksCompanion extends UpdateCompanion<Work> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> coverPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    required String name,
    this.coverPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Work> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? coverPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coverPath != null) 'cover_path': coverPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorksCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? coverPath,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return WorksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coverPath: coverPath ?? this.coverPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coverPath: $coverPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, workId, name, colorValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String workId;
  final String name;
  final int colorValue;
  const Tag(
      {required this.id,
      required this.workId,
      required this.name,
      required this.colorValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      workId: Value(workId),
      name: Value(name),
      colorValue: Value(colorValue),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
    };
  }

  Tag copyWith({String? id, String? workId, String? name, int? colorValue}) =>
      Tag(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        name: name ?? this.name,
        colorValue: colorValue ?? this.colorValue,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      name: data.name.present ? data.name.value : this.name,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, name, colorValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.name == this.name &&
          other.colorValue == this.colorValue);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> name;
  final Value<int> colorValue;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String workId,
    required String name,
    required int colorValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        name = Value(name),
        colorValue = Value(colorValue);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? name,
      Value<int>? colorValue,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DimensionTemplatesTable extends DimensionTemplates
    with TableInfo<$DimensionTemplatesTable, DimensionTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DimensionTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, workId, name, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dimension_templates';
  @override
  VerificationContext validateIntegrity(Insertable<DimensionTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DimensionTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DimensionTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $DimensionTemplatesTable createAlias(String alias) {
    return $DimensionTemplatesTable(attachedDatabase, alias);
  }
}

class DimensionTemplate extends DataClass
    implements Insertable<DimensionTemplate> {
  final String id;
  final String workId;
  final String name;
  final int sort;
  const DimensionTemplate(
      {required this.id,
      required this.workId,
      required this.name,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['name'] = Variable<String>(name);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  DimensionTemplatesCompanion toCompanion(bool nullToAbsent) {
    return DimensionTemplatesCompanion(
      id: Value(id),
      workId: Value(workId),
      name: Value(name),
      sort: Value(sort),
    );
  }

  factory DimensionTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DimensionTemplate(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      name: serializer.fromJson<String>(json['name']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'name': serializer.toJson<String>(name),
      'sort': serializer.toJson<int>(sort),
    };
  }

  DimensionTemplate copyWith(
          {String? id, String? workId, String? name, int? sort}) =>
      DimensionTemplate(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        name: name ?? this.name,
        sort: sort ?? this.sort,
      );
  DimensionTemplate copyWithCompanion(DimensionTemplatesCompanion data) {
    return DimensionTemplate(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      name: data.name.present ? data.name.value : this.name,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DimensionTemplate(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, name, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DimensionTemplate &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.name == this.name &&
          other.sort == this.sort);
}

class DimensionTemplatesCompanion extends UpdateCompanion<DimensionTemplate> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> name;
  final Value<int> sort;
  final Value<int> rowid;
  const DimensionTemplatesCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.name = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DimensionTemplatesCompanion.insert({
    required String id,
    required String workId,
    required String name,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        name = Value(name),
        sort = Value(sort);
  static Insertable<DimensionTemplate> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? name,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (name != null) 'name': name,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DimensionTemplatesCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? name,
      Value<int>? sort,
      Value<int>? rowid}) {
    return DimensionTemplatesCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      name: name ?? this.name,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DimensionTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OcsTable extends Ocs with TableInfo<$OcsTable, Oc> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OcsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<String> age = GeneratedColumn<String>(
      'age', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _constellationMeta =
      const VerificationMeta('constellation');
  @override
  late final GeneratedColumn<String> constellation = GeneratedColumn<String>(
      'constellation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarPathMeta =
      const VerificationMeta('avatarPath');
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
      'avatar_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mbtiMeta = const VerificationMeta('mbti');
  @override
  late final GeneratedColumn<String> mbti = GeneratedColumn<String>(
      'mbti', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _familyBackgroundMeta =
      const VerificationMeta('familyBackground');
  @override
  late final GeneratedColumn<String> familyBackground = GeneratedColumn<String>(
      'family_background', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _coreDriveMeta =
      const VerificationMeta('coreDrive');
  @override
  late final GeneratedColumn<String> coreDrive = GeneratedColumn<String>(
      'core_drive', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _goalMotivationMeta =
      const VerificationMeta('goalMotivation');
  @override
  late final GeneratedColumn<String> goalMotivation = GeneratedColumn<String>(
      'goal_motivation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _posXMeta = const VerificationMeta('posX');
  @override
  late final GeneratedColumn<double> posX = GeneratedColumn<double>(
      'pos_x', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _posYMeta = const VerificationMeta('posY');
  @override
  late final GeneratedColumn<double> posY = GeneratedColumn<double>(
      'pos_y', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workId,
        name,
        age,
        gender,
        birthday,
        constellation,
        avatarPath,
        mbti,
        familyBackground,
        coreDrive,
        goalMotivation,
        posX,
        posY,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ocs';
  @override
  VerificationContext validateIntegrity(Insertable<Oc> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('constellation')) {
      context.handle(
          _constellationMeta,
          constellation.isAcceptableOrUnknown(
              data['constellation']!, _constellationMeta));
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
          _avatarPathMeta,
          avatarPath.isAcceptableOrUnknown(
              data['avatar_path']!, _avatarPathMeta));
    }
    if (data.containsKey('mbti')) {
      context.handle(
          _mbtiMeta, mbti.isAcceptableOrUnknown(data['mbti']!, _mbtiMeta));
    }
    if (data.containsKey('family_background')) {
      context.handle(
          _familyBackgroundMeta,
          familyBackground.isAcceptableOrUnknown(
              data['family_background']!, _familyBackgroundMeta));
    }
    if (data.containsKey('core_drive')) {
      context.handle(_coreDriveMeta,
          coreDrive.isAcceptableOrUnknown(data['core_drive']!, _coreDriveMeta));
    }
    if (data.containsKey('goal_motivation')) {
      context.handle(
          _goalMotivationMeta,
          goalMotivation.isAcceptableOrUnknown(
              data['goal_motivation']!, _goalMotivationMeta));
    }
    if (data.containsKey('pos_x')) {
      context.handle(
          _posXMeta, posX.isAcceptableOrUnknown(data['pos_x']!, _posXMeta));
    }
    if (data.containsKey('pos_y')) {
      context.handle(
          _posYMeta, posY.isAcceptableOrUnknown(data['pos_y']!, _posYMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Oc map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Oc(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday']),
      constellation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}constellation']),
      avatarPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_path']),
      mbti: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mbti']),
      familyBackground: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}family_background'])!,
      coreDrive: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}core_drive'])!,
      goalMotivation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}goal_motivation'])!,
      posX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pos_x']),
      posY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pos_y']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OcsTable createAlias(String alias) {
    return $OcsTable(attachedDatabase, alias);
  }
}

class Oc extends DataClass implements Insertable<Oc> {
  final String id;
  final String workId;
  final String name;
  final String? age;
  final String? gender;
  final DateTime? birthday;
  final String? constellation;
  final String? avatarPath;
  final String? mbti;
  final String familyBackground;
  final String coreDrive;
  final String goalMotivation;
  final double? posX;
  final double? posY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Oc(
      {required this.id,
      required this.workId,
      required this.name,
      this.age,
      this.gender,
      this.birthday,
      this.constellation,
      this.avatarPath,
      this.mbti,
      required this.familyBackground,
      required this.coreDrive,
      required this.goalMotivation,
      this.posX,
      this.posY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<String>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    if (!nullToAbsent || constellation != null) {
      map['constellation'] = Variable<String>(constellation);
    }
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    if (!nullToAbsent || mbti != null) {
      map['mbti'] = Variable<String>(mbti);
    }
    map['family_background'] = Variable<String>(familyBackground);
    map['core_drive'] = Variable<String>(coreDrive);
    map['goal_motivation'] = Variable<String>(goalMotivation);
    if (!nullToAbsent || posX != null) {
      map['pos_x'] = Variable<double>(posX);
    }
    if (!nullToAbsent || posY != null) {
      map['pos_y'] = Variable<double>(posY);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OcsCompanion toCompanion(bool nullToAbsent) {
    return OcsCompanion(
      id: Value(id),
      workId: Value(workId),
      name: Value(name),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      constellation: constellation == null && nullToAbsent
          ? const Value.absent()
          : Value(constellation),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      mbti: mbti == null && nullToAbsent ? const Value.absent() : Value(mbti),
      familyBackground: Value(familyBackground),
      coreDrive: Value(coreDrive),
      goalMotivation: Value(goalMotivation),
      posX: posX == null && nullToAbsent ? const Value.absent() : Value(posX),
      posY: posY == null && nullToAbsent ? const Value.absent() : Value(posY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Oc.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Oc(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<String?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      constellation: serializer.fromJson<String?>(json['constellation']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      mbti: serializer.fromJson<String?>(json['mbti']),
      familyBackground: serializer.fromJson<String>(json['familyBackground']),
      coreDrive: serializer.fromJson<String>(json['coreDrive']),
      goalMotivation: serializer.fromJson<String>(json['goalMotivation']),
      posX: serializer.fromJson<double?>(json['posX']),
      posY: serializer.fromJson<double?>(json['posY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<String?>(age),
      'gender': serializer.toJson<String?>(gender),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'constellation': serializer.toJson<String?>(constellation),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'mbti': serializer.toJson<String?>(mbti),
      'familyBackground': serializer.toJson<String>(familyBackground),
      'coreDrive': serializer.toJson<String>(coreDrive),
      'goalMotivation': serializer.toJson<String>(goalMotivation),
      'posX': serializer.toJson<double?>(posX),
      'posY': serializer.toJson<double?>(posY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Oc copyWith(
          {String? id,
          String? workId,
          String? name,
          Value<String?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<DateTime?> birthday = const Value.absent(),
          Value<String?> constellation = const Value.absent(),
          Value<String?> avatarPath = const Value.absent(),
          Value<String?> mbti = const Value.absent(),
          String? familyBackground,
          String? coreDrive,
          String? goalMotivation,
          Value<double?> posX = const Value.absent(),
          Value<double?> posY = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Oc(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        name: name ?? this.name,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        birthday: birthday.present ? birthday.value : this.birthday,
        constellation:
            constellation.present ? constellation.value : this.constellation,
        avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
        mbti: mbti.present ? mbti.value : this.mbti,
        familyBackground: familyBackground ?? this.familyBackground,
        coreDrive: coreDrive ?? this.coreDrive,
        goalMotivation: goalMotivation ?? this.goalMotivation,
        posX: posX.present ? posX.value : this.posX,
        posY: posY.present ? posY.value : this.posY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Oc copyWithCompanion(OcsCompanion data) {
    return Oc(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      constellation: data.constellation.present
          ? data.constellation.value
          : this.constellation,
      avatarPath:
          data.avatarPath.present ? data.avatarPath.value : this.avatarPath,
      mbti: data.mbti.present ? data.mbti.value : this.mbti,
      familyBackground: data.familyBackground.present
          ? data.familyBackground.value
          : this.familyBackground,
      coreDrive: data.coreDrive.present ? data.coreDrive.value : this.coreDrive,
      goalMotivation: data.goalMotivation.present
          ? data.goalMotivation.value
          : this.goalMotivation,
      posX: data.posX.present ? data.posX.value : this.posX,
      posY: data.posY.present ? data.posY.value : this.posY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Oc(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('constellation: $constellation, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('mbti: $mbti, ')
          ..write('familyBackground: $familyBackground, ')
          ..write('coreDrive: $coreDrive, ')
          ..write('goalMotivation: $goalMotivation, ')
          ..write('posX: $posX, ')
          ..write('posY: $posY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workId,
      name,
      age,
      gender,
      birthday,
      constellation,
      avatarPath,
      mbti,
      familyBackground,
      coreDrive,
      goalMotivation,
      posX,
      posY,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Oc &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.name == this.name &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.birthday == this.birthday &&
          other.constellation == this.constellation &&
          other.avatarPath == this.avatarPath &&
          other.mbti == this.mbti &&
          other.familyBackground == this.familyBackground &&
          other.coreDrive == this.coreDrive &&
          other.goalMotivation == this.goalMotivation &&
          other.posX == this.posX &&
          other.posY == this.posY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OcsCompanion extends UpdateCompanion<Oc> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> name;
  final Value<String?> age;
  final Value<String?> gender;
  final Value<DateTime?> birthday;
  final Value<String?> constellation;
  final Value<String?> avatarPath;
  final Value<String?> mbti;
  final Value<String> familyBackground;
  final Value<String> coreDrive;
  final Value<String> goalMotivation;
  final Value<double?> posX;
  final Value<double?> posY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OcsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.constellation = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.mbti = const Value.absent(),
    this.familyBackground = const Value.absent(),
    this.coreDrive = const Value.absent(),
    this.goalMotivation = const Value.absent(),
    this.posX = const Value.absent(),
    this.posY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OcsCompanion.insert({
    required String id,
    required String workId,
    required String name,
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.constellation = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.mbti = const Value.absent(),
    this.familyBackground = const Value.absent(),
    this.coreDrive = const Value.absent(),
    this.goalMotivation = const Value.absent(),
    this.posX = const Value.absent(),
    this.posY = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Oc> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? name,
    Expression<String>? age,
    Expression<String>? gender,
    Expression<DateTime>? birthday,
    Expression<String>? constellation,
    Expression<String>? avatarPath,
    Expression<String>? mbti,
    Expression<String>? familyBackground,
    Expression<String>? coreDrive,
    Expression<String>? goalMotivation,
    Expression<double>? posX,
    Expression<double>? posY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (birthday != null) 'birthday': birthday,
      if (constellation != null) 'constellation': constellation,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (mbti != null) 'mbti': mbti,
      if (familyBackground != null) 'family_background': familyBackground,
      if (coreDrive != null) 'core_drive': coreDrive,
      if (goalMotivation != null) 'goal_motivation': goalMotivation,
      if (posX != null) 'pos_x': posX,
      if (posY != null) 'pos_y': posY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OcsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? name,
      Value<String?>? age,
      Value<String?>? gender,
      Value<DateTime?>? birthday,
      Value<String?>? constellation,
      Value<String?>? avatarPath,
      Value<String?>? mbti,
      Value<String>? familyBackground,
      Value<String>? coreDrive,
      Value<String>? goalMotivation,
      Value<double?>? posX,
      Value<double?>? posY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return OcsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      constellation: constellation ?? this.constellation,
      avatarPath: avatarPath ?? this.avatarPath,
      mbti: mbti ?? this.mbti,
      familyBackground: familyBackground ?? this.familyBackground,
      coreDrive: coreDrive ?? this.coreDrive,
      goalMotivation: goalMotivation ?? this.goalMotivation,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<String>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (constellation.present) {
      map['constellation'] = Variable<String>(constellation.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (mbti.present) {
      map['mbti'] = Variable<String>(mbti.value);
    }
    if (familyBackground.present) {
      map['family_background'] = Variable<String>(familyBackground.value);
    }
    if (coreDrive.present) {
      map['core_drive'] = Variable<String>(coreDrive.value);
    }
    if (goalMotivation.present) {
      map['goal_motivation'] = Variable<String>(goalMotivation.value);
    }
    if (posX.present) {
      map['pos_x'] = Variable<double>(posX.value);
    }
    if (posY.present) {
      map['pos_y'] = Variable<double>(posY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OcsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('constellation: $constellation, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('mbti: $mbti, ')
          ..write('familyBackground: $familyBackground, ')
          ..write('coreDrive: $coreDrive, ')
          ..write('goalMotivation: $goalMotivation, ')
          ..write('posX: $posX, ')
          ..write('posY: $posY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OcTagsTable extends OcTags with TableInfo<$OcTagsTable, OcTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OcTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [ocId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'oc_tags';
  @override
  VerificationContext validateIntegrity(Insertable<OcTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ocId, tagId};
  @override
  OcTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OcTag(
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $OcTagsTable createAlias(String alias) {
    return $OcTagsTable(attachedDatabase, alias);
  }
}

class OcTag extends DataClass implements Insertable<OcTag> {
  final String ocId;
  final String tagId;
  const OcTag({required this.ocId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['oc_id'] = Variable<String>(ocId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  OcTagsCompanion toCompanion(bool nullToAbsent) {
    return OcTagsCompanion(
      ocId: Value(ocId),
      tagId: Value(tagId),
    );
  }

  factory OcTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OcTag(
      ocId: serializer.fromJson<String>(json['ocId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ocId': serializer.toJson<String>(ocId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  OcTag copyWith({String? ocId, String? tagId}) => OcTag(
        ocId: ocId ?? this.ocId,
        tagId: tagId ?? this.tagId,
      );
  OcTag copyWithCompanion(OcTagsCompanion data) {
    return OcTag(
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OcTag(')
          ..write('ocId: $ocId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ocId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OcTag && other.ocId == this.ocId && other.tagId == this.tagId);
}

class OcTagsCompanion extends UpdateCompanion<OcTag> {
  final Value<String> ocId;
  final Value<String> tagId;
  final Value<int> rowid;
  const OcTagsCompanion({
    this.ocId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OcTagsCompanion.insert({
    required String ocId,
    required String tagId,
    this.rowid = const Value.absent(),
  })  : ocId = Value(ocId),
        tagId = Value(tagId);
  static Insertable<OcTag> custom({
    Expression<String>? ocId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ocId != null) 'oc_id': ocId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OcTagsCompanion copyWith(
      {Value<String>? ocId, Value<String>? tagId, Value<int>? rowid}) {
    return OcTagsCompanion(
      ocId: ocId ?? this.ocId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OcTagsCompanion(')
          ..write('ocId: $ocId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppearanceItemsTable extends AppearanceItems
    with TableInfo<$AppearanceItemsTable, AppearanceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppearanceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _richTextMeta =
      const VerificationMeta('richText');
  @override
  late final GeneratedColumn<String> richText = GeneratedColumn<String>(
      'rich_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesJsonMeta =
      const VerificationMeta('imagesJson');
  @override
  late final GeneratedColumn<String> imagesJson = GeneratedColumn<String>(
      'images_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ocId, section, richText, imagesJson, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appearance_items';
  @override
  VerificationContext validateIntegrity(Insertable<AppearanceItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('rich_text')) {
      context.handle(_richTextMeta,
          richText.isAcceptableOrUnknown(data['rich_text']!, _richTextMeta));
    } else if (isInserting) {
      context.missing(_richTextMeta);
    }
    if (data.containsKey('images_json')) {
      context.handle(
          _imagesJsonMeta,
          imagesJson.isAcceptableOrUnknown(
              data['images_json']!, _imagesJsonMeta));
    } else if (isInserting) {
      context.missing(_imagesJsonMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppearanceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppearanceItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      richText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rich_text'])!,
      imagesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images_json'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $AppearanceItemsTable createAlias(String alias) {
    return $AppearanceItemsTable(attachedDatabase, alias);
  }
}

class AppearanceItem extends DataClass implements Insertable<AppearanceItem> {
  final String id;
  final String ocId;
  final String section;
  final String richText;

  /// JSON 数组：[{path, caption}]
  final String imagesJson;
  final int sort;
  const AppearanceItem(
      {required this.id,
      required this.ocId,
      required this.section,
      required this.richText,
      required this.imagesJson,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['section'] = Variable<String>(section);
    map['rich_text'] = Variable<String>(richText);
    map['images_json'] = Variable<String>(imagesJson);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  AppearanceItemsCompanion toCompanion(bool nullToAbsent) {
    return AppearanceItemsCompanion(
      id: Value(id),
      ocId: Value(ocId),
      section: Value(section),
      richText: Value(richText),
      imagesJson: Value(imagesJson),
      sort: Value(sort),
    );
  }

  factory AppearanceItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppearanceItem(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      section: serializer.fromJson<String>(json['section']),
      richText: serializer.fromJson<String>(json['richText']),
      imagesJson: serializer.fromJson<String>(json['imagesJson']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'section': serializer.toJson<String>(section),
      'richText': serializer.toJson<String>(richText),
      'imagesJson': serializer.toJson<String>(imagesJson),
      'sort': serializer.toJson<int>(sort),
    };
  }

  AppearanceItem copyWith(
          {String? id,
          String? ocId,
          String? section,
          String? richText,
          String? imagesJson,
          int? sort}) =>
      AppearanceItem(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        section: section ?? this.section,
        richText: richText ?? this.richText,
        imagesJson: imagesJson ?? this.imagesJson,
        sort: sort ?? this.sort,
      );
  AppearanceItem copyWithCompanion(AppearanceItemsCompanion data) {
    return AppearanceItem(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      section: data.section.present ? data.section.value : this.section,
      richText: data.richText.present ? data.richText.value : this.richText,
      imagesJson:
          data.imagesJson.present ? data.imagesJson.value : this.imagesJson,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceItem(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('section: $section, ')
          ..write('richText: $richText, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ocId, section, richText, imagesJson, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppearanceItem &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.section == this.section &&
          other.richText == this.richText &&
          other.imagesJson == this.imagesJson &&
          other.sort == this.sort);
}

class AppearanceItemsCompanion extends UpdateCompanion<AppearanceItem> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> section;
  final Value<String> richText;
  final Value<String> imagesJson;
  final Value<int> sort;
  final Value<int> rowid;
  const AppearanceItemsCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.section = const Value.absent(),
    this.richText = const Value.absent(),
    this.imagesJson = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppearanceItemsCompanion.insert({
    required String id,
    required String ocId,
    required String section,
    required String richText,
    required String imagesJson,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        section = Value(section),
        richText = Value(richText),
        imagesJson = Value(imagesJson),
        sort = Value(sort);
  static Insertable<AppearanceItem> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? section,
    Expression<String>? richText,
    Expression<String>? imagesJson,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (section != null) 'section': section,
      if (richText != null) 'rich_text': richText,
      if (imagesJson != null) 'images_json': imagesJson,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppearanceItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? section,
      Value<String>? richText,
      Value<String>? imagesJson,
      Value<int>? sort,
      Value<int>? rowid}) {
    return AppearanceItemsCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      section: section ?? this.section,
      richText: richText ?? this.richText,
      imagesJson: imagesJson ?? this.imagesJson,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (richText.present) {
      map['rich_text'] = Variable<String>(richText.value);
    }
    if (imagesJson.present) {
      map['images_json'] = Variable<String>(imagesJson.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceItemsCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('section: $section, ')
          ..write('richText: $richText, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AbilityValuesTable extends AbilityValues
    with TableInfo<$AbilityValuesTable, AbilityValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbilityValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dimensionNameMeta =
      const VerificationMeta('dimensionName');
  @override
  late final GeneratedColumn<String> dimensionName = GeneratedColumn<String>(
      'dimension_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ocId, dimensionName, score, remark];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ability_values';
  @override
  VerificationContext validateIntegrity(Insertable<AbilityValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('dimension_name')) {
      context.handle(
          _dimensionNameMeta,
          dimensionName.isAcceptableOrUnknown(
              data['dimension_name']!, _dimensionNameMeta));
    } else if (isInserting) {
      context.missing(_dimensionNameMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbilityValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbilityValue(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      dimensionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dimension_name'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
    );
  }

  @override
  $AbilityValuesTable createAlias(String alias) {
    return $AbilityValuesTable(attachedDatabase, alias);
  }
}

class AbilityValue extends DataClass implements Insertable<AbilityValue> {
  final String id;
  final String ocId;
  final String dimensionName;
  final int score;
  final String? remark;
  const AbilityValue(
      {required this.id,
      required this.ocId,
      required this.dimensionName,
      required this.score,
      this.remark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['dimension_name'] = Variable<String>(dimensionName);
    map['score'] = Variable<int>(score);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    return map;
  }

  AbilityValuesCompanion toCompanion(bool nullToAbsent) {
    return AbilityValuesCompanion(
      id: Value(id),
      ocId: Value(ocId),
      dimensionName: Value(dimensionName),
      score: Value(score),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
    );
  }

  factory AbilityValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbilityValue(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      dimensionName: serializer.fromJson<String>(json['dimensionName']),
      score: serializer.fromJson<int>(json['score']),
      remark: serializer.fromJson<String?>(json['remark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'dimensionName': serializer.toJson<String>(dimensionName),
      'score': serializer.toJson<int>(score),
      'remark': serializer.toJson<String?>(remark),
    };
  }

  AbilityValue copyWith(
          {String? id,
          String? ocId,
          String? dimensionName,
          int? score,
          Value<String?> remark = const Value.absent()}) =>
      AbilityValue(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        dimensionName: dimensionName ?? this.dimensionName,
        score: score ?? this.score,
        remark: remark.present ? remark.value : this.remark,
      );
  AbilityValue copyWithCompanion(AbilityValuesCompanion data) {
    return AbilityValue(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      dimensionName: data.dimensionName.present
          ? data.dimensionName.value
          : this.dimensionName,
      score: data.score.present ? data.score.value : this.score,
      remark: data.remark.present ? data.remark.value : this.remark,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbilityValue(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('dimensionName: $dimensionName, ')
          ..write('score: $score, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ocId, dimensionName, score, remark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbilityValue &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.dimensionName == this.dimensionName &&
          other.score == this.score &&
          other.remark == this.remark);
}

class AbilityValuesCompanion extends UpdateCompanion<AbilityValue> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> dimensionName;
  final Value<int> score;
  final Value<String?> remark;
  final Value<int> rowid;
  const AbilityValuesCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.dimensionName = const Value.absent(),
    this.score = const Value.absent(),
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AbilityValuesCompanion.insert({
    required String id,
    required String ocId,
    required String dimensionName,
    required int score,
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        dimensionName = Value(dimensionName),
        score = Value(score);
  static Insertable<AbilityValue> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? dimensionName,
    Expression<int>? score,
    Expression<String>? remark,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (dimensionName != null) 'dimension_name': dimensionName,
      if (score != null) 'score': score,
      if (remark != null) 'remark': remark,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AbilityValuesCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? dimensionName,
      Value<int>? score,
      Value<String?>? remark,
      Value<int>? rowid}) {
    return AbilityValuesCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      dimensionName: dimensionName ?? this.dimensionName,
      score: score ?? this.score,
      remark: remark ?? this.remark,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (dimensionName.present) {
      map['dimension_name'] = Variable<String>(dimensionName.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbilityValuesCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('dimensionName: $dimensionName, ')
          ..write('score: $score, ')
          ..write('remark: $remark, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoreValuesTable extends CoreValues
    with TableInfo<$CoreValuesTable, CoreValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoreValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ocId, value, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'core_values';
  @override
  VerificationContext validateIntegrity(Insertable<CoreValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoreValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoreValue(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $CoreValuesTable createAlias(String alias) {
    return $CoreValuesTable(attachedDatabase, alias);
  }
}

class CoreValue extends DataClass implements Insertable<CoreValue> {
  final String id;
  final String ocId;
  final String value;
  final int sort;
  const CoreValue(
      {required this.id,
      required this.ocId,
      required this.value,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['value'] = Variable<String>(value);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  CoreValuesCompanion toCompanion(bool nullToAbsent) {
    return CoreValuesCompanion(
      id: Value(id),
      ocId: Value(ocId),
      value: Value(value),
      sort: Value(sort),
    );
  }

  factory CoreValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoreValue(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      value: serializer.fromJson<String>(json['value']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'value': serializer.toJson<String>(value),
      'sort': serializer.toJson<int>(sort),
    };
  }

  CoreValue copyWith({String? id, String? ocId, String? value, int? sort}) =>
      CoreValue(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        value: value ?? this.value,
        sort: sort ?? this.sort,
      );
  CoreValue copyWithCompanion(CoreValuesCompanion data) {
    return CoreValue(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      value: data.value.present ? data.value.value : this.value,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoreValue(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('value: $value, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ocId, value, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoreValue &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.value == this.value &&
          other.sort == this.sort);
}

class CoreValuesCompanion extends UpdateCompanion<CoreValue> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> value;
  final Value<int> sort;
  final Value<int> rowid;
  const CoreValuesCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.value = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoreValuesCompanion.insert({
    required String id,
    required String ocId,
    required String value,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        value = Value(value),
        sort = Value(sort);
  static Insertable<CoreValue> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? value,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (value != null) 'value': value,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoreValuesCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? value,
      Value<int>? sort,
      Value<int>? rowid}) {
    return CoreValuesCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      value: value ?? this.value,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoreValuesCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('value: $value, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TraitsTable extends Traits with TableInfo<$TraitsTable, Trait> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TraitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ocId, kind, value, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'traits';
  @override
  VerificationContext validateIntegrity(Insertable<Trait> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trait map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trait(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $TraitsTable createAlias(String alias) {
    return $TraitsTable(attachedDatabase, alias);
  }
}

class Trait extends DataClass implements Insertable<Trait> {
  final String id;
  final String ocId;
  final String kind;
  final String value;
  final int sort;
  const Trait(
      {required this.id,
      required this.ocId,
      required this.kind,
      required this.value,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['kind'] = Variable<String>(kind);
    map['value'] = Variable<String>(value);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  TraitsCompanion toCompanion(bool nullToAbsent) {
    return TraitsCompanion(
      id: Value(id),
      ocId: Value(ocId),
      kind: Value(kind),
      value: Value(value),
      sort: Value(sort),
    );
  }

  factory Trait.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trait(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      kind: serializer.fromJson<String>(json['kind']),
      value: serializer.fromJson<String>(json['value']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'kind': serializer.toJson<String>(kind),
      'value': serializer.toJson<String>(value),
      'sort': serializer.toJson<int>(sort),
    };
  }

  Trait copyWith(
          {String? id, String? ocId, String? kind, String? value, int? sort}) =>
      Trait(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        kind: kind ?? this.kind,
        value: value ?? this.value,
        sort: sort ?? this.sort,
      );
  Trait copyWithCompanion(TraitsCompanion data) {
    return Trait(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      kind: data.kind.present ? data.kind.value : this.kind,
      value: data.value.present ? data.value.value : this.value,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trait(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ocId, kind, value, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trait &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.kind == this.kind &&
          other.value == this.value &&
          other.sort == this.sort);
}

class TraitsCompanion extends UpdateCompanion<Trait> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> kind;
  final Value<String> value;
  final Value<int> sort;
  final Value<int> rowid;
  const TraitsCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.kind = const Value.absent(),
    this.value = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TraitsCompanion.insert({
    required String id,
    required String ocId,
    required String kind,
    required String value,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        kind = Value(kind),
        value = Value(value),
        sort = Value(sort);
  static Insertable<Trait> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? kind,
    Expression<String>? value,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (kind != null) 'kind': kind,
      if (value != null) 'value': value,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TraitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? kind,
      Value<String>? value,
      Value<int>? sort,
      Value<int>? rowid}) {
    return TraitsCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      kind: kind ?? this.kind,
      value: value ?? this.value,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TraitsCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CatchphrasesTable extends Catchphrases
    with TableInfo<$CatchphrasesTable, Catchphrase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatchphrasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phraseMeta = const VerificationMeta('phrase');
  @override
  late final GeneratedColumn<String> phrase = GeneratedColumn<String>(
      'phrase', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ocId, phrase, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catchphrases';
  @override
  VerificationContext validateIntegrity(Insertable<Catchphrase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('phrase')) {
      context.handle(_phraseMeta,
          phrase.isAcceptableOrUnknown(data['phrase']!, _phraseMeta));
    } else if (isInserting) {
      context.missing(_phraseMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Catchphrase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Catchphrase(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      phrase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phrase'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $CatchphrasesTable createAlias(String alias) {
    return $CatchphrasesTable(attachedDatabase, alias);
  }
}

class Catchphrase extends DataClass implements Insertable<Catchphrase> {
  final String id;
  final String ocId;
  final String phrase;
  final int sort;
  const Catchphrase(
      {required this.id,
      required this.ocId,
      required this.phrase,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['phrase'] = Variable<String>(phrase);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  CatchphrasesCompanion toCompanion(bool nullToAbsent) {
    return CatchphrasesCompanion(
      id: Value(id),
      ocId: Value(ocId),
      phrase: Value(phrase),
      sort: Value(sort),
    );
  }

  factory Catchphrase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Catchphrase(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      phrase: serializer.fromJson<String>(json['phrase']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'phrase': serializer.toJson<String>(phrase),
      'sort': serializer.toJson<int>(sort),
    };
  }

  Catchphrase copyWith({String? id, String? ocId, String? phrase, int? sort}) =>
      Catchphrase(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        phrase: phrase ?? this.phrase,
        sort: sort ?? this.sort,
      );
  Catchphrase copyWithCompanion(CatchphrasesCompanion data) {
    return Catchphrase(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      phrase: data.phrase.present ? data.phrase.value : this.phrase,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Catchphrase(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('phrase: $phrase, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ocId, phrase, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Catchphrase &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.phrase == this.phrase &&
          other.sort == this.sort);
}

class CatchphrasesCompanion extends UpdateCompanion<Catchphrase> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> phrase;
  final Value<int> sort;
  final Value<int> rowid;
  const CatchphrasesCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.phrase = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatchphrasesCompanion.insert({
    required String id,
    required String ocId,
    required String phrase,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        phrase = Value(phrase),
        sort = Value(sort);
  static Insertable<Catchphrase> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? phrase,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (phrase != null) 'phrase': phrase,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatchphrasesCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? phrase,
      Value<int>? sort,
      Value<int>? rowid}) {
    return CatchphrasesCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      phrase: phrase ?? this.phrase,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (phrase.present) {
      map['phrase'] = Variable<String>(phrase.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatchphrasesCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('phrase: $phrase, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExtensionFieldsTable extends ExtensionFields
    with TableInfo<$ExtensionFieldsTable, ExtensionField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExtensionFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ocId, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'extension_fields';
  @override
  VerificationContext validateIntegrity(Insertable<ExtensionField> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExtensionField map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExtensionField(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $ExtensionFieldsTable createAlias(String alias) {
    return $ExtensionFieldsTable(attachedDatabase, alias);
  }
}

class ExtensionField extends DataClass implements Insertable<ExtensionField> {
  final String id;
  final String ocId;
  final String key;
  final String value;
  const ExtensionField(
      {required this.id,
      required this.ocId,
      required this.key,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  ExtensionFieldsCompanion toCompanion(bool nullToAbsent) {
    return ExtensionFieldsCompanion(
      id: Value(id),
      ocId: Value(ocId),
      key: Value(key),
      value: Value(value),
    );
  }

  factory ExtensionField.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExtensionField(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  ExtensionField copyWith(
          {String? id, String? ocId, String? key, String? value}) =>
      ExtensionField(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  ExtensionField copyWithCompanion(ExtensionFieldsCompanion data) {
    return ExtensionField(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExtensionField(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ocId, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExtensionField &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.key == this.key &&
          other.value == this.value);
}

class ExtensionFieldsCompanion extends UpdateCompanion<ExtensionField> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const ExtensionFieldsCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExtensionFieldsCompanion.insert({
    required String id,
    required String ocId,
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        key = Value(key),
        value = Value(value);
  static Insertable<ExtensionField> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExtensionFieldsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? key,
      Value<String>? value,
      Value<int>? rowid}) {
    return ExtensionFieldsCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExtensionFieldsCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimelineEventsTable extends TimelineEvents
    with TableInfo<$TimelineEventsTable, TimelineEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimelineEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ocIdMeta = const VerificationMeta('ocId');
  @override
  late final GeneratedColumn<String> ocId = GeneratedColumn<String>(
      'oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeTextMeta =
      const VerificationMeta('timeText');
  @override
  late final GeneratedColumn<String> timeText = GeneratedColumn<String>(
      'time_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesJsonMeta =
      const VerificationMeta('imagesJson');
  @override
  late final GeneratedColumn<String> imagesJson = GeneratedColumn<String>(
      'images_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _starredMeta =
      const VerificationMeta('starred');
  @override
  late final GeneratedColumn<bool> starred = GeneratedColumn<bool>(
      'starred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("starred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ocId, timeText, title, description, imagesJson, starred, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timeline_events';
  @override
  VerificationContext validateIntegrity(Insertable<TimelineEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oc_id')) {
      context.handle(
          _ocIdMeta, ocId.isAcceptableOrUnknown(data['oc_id']!, _ocIdMeta));
    } else if (isInserting) {
      context.missing(_ocIdMeta);
    }
    if (data.containsKey('time_text')) {
      context.handle(_timeTextMeta,
          timeText.isAcceptableOrUnknown(data['time_text']!, _timeTextMeta));
    } else if (isInserting) {
      context.missing(_timeTextMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('images_json')) {
      context.handle(
          _imagesJsonMeta,
          imagesJson.isAcceptableOrUnknown(
              data['images_json']!, _imagesJsonMeta));
    } else if (isInserting) {
      context.missing(_imagesJsonMeta);
    }
    if (data.containsKey('starred')) {
      context.handle(_starredMeta,
          starred.isAcceptableOrUnknown(data['starred']!, _starredMeta));
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimelineEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimelineEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ocId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}oc_id'])!,
      timeText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_text'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imagesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images_json'])!,
      starred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}starred'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $TimelineEventsTable createAlias(String alias) {
    return $TimelineEventsTable(attachedDatabase, alias);
  }
}

class TimelineEvent extends DataClass implements Insertable<TimelineEvent> {
  final String id;
  final String ocId;
  final String timeText;
  final String title;
  final String description;
  final String imagesJson;
  final bool starred;
  final int sort;
  const TimelineEvent(
      {required this.id,
      required this.ocId,
      required this.timeText,
      required this.title,
      required this.description,
      required this.imagesJson,
      required this.starred,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oc_id'] = Variable<String>(ocId);
    map['time_text'] = Variable<String>(timeText);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['images_json'] = Variable<String>(imagesJson);
    map['starred'] = Variable<bool>(starred);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  TimelineEventsCompanion toCompanion(bool nullToAbsent) {
    return TimelineEventsCompanion(
      id: Value(id),
      ocId: Value(ocId),
      timeText: Value(timeText),
      title: Value(title),
      description: Value(description),
      imagesJson: Value(imagesJson),
      starred: Value(starred),
      sort: Value(sort),
    );
  }

  factory TimelineEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimelineEvent(
      id: serializer.fromJson<String>(json['id']),
      ocId: serializer.fromJson<String>(json['ocId']),
      timeText: serializer.fromJson<String>(json['timeText']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      imagesJson: serializer.fromJson<String>(json['imagesJson']),
      starred: serializer.fromJson<bool>(json['starred']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ocId': serializer.toJson<String>(ocId),
      'timeText': serializer.toJson<String>(timeText),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'imagesJson': serializer.toJson<String>(imagesJson),
      'starred': serializer.toJson<bool>(starred),
      'sort': serializer.toJson<int>(sort),
    };
  }

  TimelineEvent copyWith(
          {String? id,
          String? ocId,
          String? timeText,
          String? title,
          String? description,
          String? imagesJson,
          bool? starred,
          int? sort}) =>
      TimelineEvent(
        id: id ?? this.id,
        ocId: ocId ?? this.ocId,
        timeText: timeText ?? this.timeText,
        title: title ?? this.title,
        description: description ?? this.description,
        imagesJson: imagesJson ?? this.imagesJson,
        starred: starred ?? this.starred,
        sort: sort ?? this.sort,
      );
  TimelineEvent copyWithCompanion(TimelineEventsCompanion data) {
    return TimelineEvent(
      id: data.id.present ? data.id.value : this.id,
      ocId: data.ocId.present ? data.ocId.value : this.ocId,
      timeText: data.timeText.present ? data.timeText.value : this.timeText,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      imagesJson:
          data.imagesJson.present ? data.imagesJson.value : this.imagesJson,
      starred: data.starred.present ? data.starred.value : this.starred,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEvent(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('timeText: $timeText, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('starred: $starred, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ocId, timeText, title, description, imagesJson, starred, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimelineEvent &&
          other.id == this.id &&
          other.ocId == this.ocId &&
          other.timeText == this.timeText &&
          other.title == this.title &&
          other.description == this.description &&
          other.imagesJson == this.imagesJson &&
          other.starred == this.starred &&
          other.sort == this.sort);
}

class TimelineEventsCompanion extends UpdateCompanion<TimelineEvent> {
  final Value<String> id;
  final Value<String> ocId;
  final Value<String> timeText;
  final Value<String> title;
  final Value<String> description;
  final Value<String> imagesJson;
  final Value<bool> starred;
  final Value<int> sort;
  final Value<int> rowid;
  const TimelineEventsCompanion({
    this.id = const Value.absent(),
    this.ocId = const Value.absent(),
    this.timeText = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.imagesJson = const Value.absent(),
    this.starred = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimelineEventsCompanion.insert({
    required String id,
    required String ocId,
    required String timeText,
    required String title,
    required String description,
    required String imagesJson,
    this.starred = const Value.absent(),
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ocId = Value(ocId),
        timeText = Value(timeText),
        title = Value(title),
        description = Value(description),
        imagesJson = Value(imagesJson),
        sort = Value(sort);
  static Insertable<TimelineEvent> custom({
    Expression<String>? id,
    Expression<String>? ocId,
    Expression<String>? timeText,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? imagesJson,
    Expression<bool>? starred,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ocId != null) 'oc_id': ocId,
      if (timeText != null) 'time_text': timeText,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imagesJson != null) 'images_json': imagesJson,
      if (starred != null) 'starred': starred,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimelineEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ocId,
      Value<String>? timeText,
      Value<String>? title,
      Value<String>? description,
      Value<String>? imagesJson,
      Value<bool>? starred,
      Value<int>? sort,
      Value<int>? rowid}) {
    return TimelineEventsCompanion(
      id: id ?? this.id,
      ocId: ocId ?? this.ocId,
      timeText: timeText ?? this.timeText,
      title: title ?? this.title,
      description: description ?? this.description,
      imagesJson: imagesJson ?? this.imagesJson,
      starred: starred ?? this.starred,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ocId.present) {
      map['oc_id'] = Variable<String>(ocId.value);
    }
    if (timeText.present) {
      map['time_text'] = Variable<String>(timeText.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imagesJson.present) {
      map['images_json'] = Variable<String>(imagesJson.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEventsCompanion(')
          ..write('id: $id, ')
          ..write('ocId: $ocId, ')
          ..write('timeText: $timeText, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('starred: $starred, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationshipsTable extends Relationships
    with TableInfo<$RelationshipsTable, Relationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceOcIdMeta =
      const VerificationMeta('sourceOcId');
  @override
  late final GeneratedColumn<String> sourceOcId = GeneratedColumn<String>(
      'source_oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetOcIdMeta =
      const VerificationMeta('targetOcId');
  @override
  late final GeneratedColumn<String> targetOcId = GeneratedColumn<String>(
      'target_oc_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strengthMeta =
      const VerificationMeta('strength');
  @override
  late final GeneratedColumn<String> strength = GeneratedColumn<String>(
      'strength', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<int> direction = GeneratedColumn<int>(
      'direction', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workId,
        sourceOcId,
        targetOcId,
        label,
        strength,
        direction,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(Insertable<Relationship> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('source_oc_id')) {
      context.handle(
          _sourceOcIdMeta,
          sourceOcId.isAcceptableOrUnknown(
              data['source_oc_id']!, _sourceOcIdMeta));
    } else if (isInserting) {
      context.missing(_sourceOcIdMeta);
    }
    if (data.containsKey('target_oc_id')) {
      context.handle(
          _targetOcIdMeta,
          targetOcId.isAcceptableOrUnknown(
              data['target_oc_id']!, _targetOcIdMeta));
    } else if (isInserting) {
      context.missing(_targetOcIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('strength')) {
      context.handle(_strengthMeta,
          strength.isAcceptableOrUnknown(data['strength']!, _strengthMeta));
    } else if (isInserting) {
      context.missing(_strengthMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Relationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Relationship(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      sourceOcId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_oc_id'])!,
      targetOcId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_oc_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      strength: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strength'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}direction'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $RelationshipsTable createAlias(String alias) {
    return $RelationshipsTable(attachedDatabase, alias);
  }
}

class Relationship extends DataClass implements Insertable<Relationship> {
  final String id;
  final String workId;
  final String sourceOcId;
  final String targetOcId;
  final String label;
  final String strength;
  final int direction;
  final String description;
  const Relationship(
      {required this.id,
      required this.workId,
      required this.sourceOcId,
      required this.targetOcId,
      required this.label,
      required this.strength,
      required this.direction,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['source_oc_id'] = Variable<String>(sourceOcId);
    map['target_oc_id'] = Variable<String>(targetOcId);
    map['label'] = Variable<String>(label);
    map['strength'] = Variable<String>(strength);
    map['direction'] = Variable<int>(direction);
    map['description'] = Variable<String>(description);
    return map;
  }

  RelationshipsCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsCompanion(
      id: Value(id),
      workId: Value(workId),
      sourceOcId: Value(sourceOcId),
      targetOcId: Value(targetOcId),
      label: Value(label),
      strength: Value(strength),
      direction: Value(direction),
      description: Value(description),
    );
  }

  factory Relationship.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relationship(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      sourceOcId: serializer.fromJson<String>(json['sourceOcId']),
      targetOcId: serializer.fromJson<String>(json['targetOcId']),
      label: serializer.fromJson<String>(json['label']),
      strength: serializer.fromJson<String>(json['strength']),
      direction: serializer.fromJson<int>(json['direction']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'sourceOcId': serializer.toJson<String>(sourceOcId),
      'targetOcId': serializer.toJson<String>(targetOcId),
      'label': serializer.toJson<String>(label),
      'strength': serializer.toJson<String>(strength),
      'direction': serializer.toJson<int>(direction),
      'description': serializer.toJson<String>(description),
    };
  }

  Relationship copyWith(
          {String? id,
          String? workId,
          String? sourceOcId,
          String? targetOcId,
          String? label,
          String? strength,
          int? direction,
          String? description}) =>
      Relationship(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        sourceOcId: sourceOcId ?? this.sourceOcId,
        targetOcId: targetOcId ?? this.targetOcId,
        label: label ?? this.label,
        strength: strength ?? this.strength,
        direction: direction ?? this.direction,
        description: description ?? this.description,
      );
  Relationship copyWithCompanion(RelationshipsCompanion data) {
    return Relationship(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      sourceOcId:
          data.sourceOcId.present ? data.sourceOcId.value : this.sourceOcId,
      targetOcId:
          data.targetOcId.present ? data.targetOcId.value : this.targetOcId,
      label: data.label.present ? data.label.value : this.label,
      strength: data.strength.present ? data.strength.value : this.strength,
      direction: data.direction.present ? data.direction.value : this.direction,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Relationship(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('sourceOcId: $sourceOcId, ')
          ..write('targetOcId: $targetOcId, ')
          ..write('label: $label, ')
          ..write('strength: $strength, ')
          ..write('direction: $direction, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, sourceOcId, targetOcId, label,
      strength, direction, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relationship &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.sourceOcId == this.sourceOcId &&
          other.targetOcId == this.targetOcId &&
          other.label == this.label &&
          other.strength == this.strength &&
          other.direction == this.direction &&
          other.description == this.description);
}

class RelationshipsCompanion extends UpdateCompanion<Relationship> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> sourceOcId;
  final Value<String> targetOcId;
  final Value<String> label;
  final Value<String> strength;
  final Value<int> direction;
  final Value<String> description;
  final Value<int> rowid;
  const RelationshipsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.sourceOcId = const Value.absent(),
    this.targetOcId = const Value.absent(),
    this.label = const Value.absent(),
    this.strength = const Value.absent(),
    this.direction = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipsCompanion.insert({
    required String id,
    required String workId,
    required String sourceOcId,
    required String targetOcId,
    required String label,
    required String strength,
    required int direction,
    required String description,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        sourceOcId = Value(sourceOcId),
        targetOcId = Value(targetOcId),
        label = Value(label),
        strength = Value(strength),
        direction = Value(direction),
        description = Value(description);
  static Insertable<Relationship> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? sourceOcId,
    Expression<String>? targetOcId,
    Expression<String>? label,
    Expression<String>? strength,
    Expression<int>? direction,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (sourceOcId != null) 'source_oc_id': sourceOcId,
      if (targetOcId != null) 'target_oc_id': targetOcId,
      if (label != null) 'label': label,
      if (strength != null) 'strength': strength,
      if (direction != null) 'direction': direction,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? sourceOcId,
      Value<String>? targetOcId,
      Value<String>? label,
      Value<String>? strength,
      Value<int>? direction,
      Value<String>? description,
      Value<int>? rowid}) {
    return RelationshipsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      sourceOcId: sourceOcId ?? this.sourceOcId,
      targetOcId: targetOcId ?? this.targetOcId,
      label: label ?? this.label,
      strength: strength ?? this.strength,
      direction: direction ?? this.direction,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (sourceOcId.present) {
      map['source_oc_id'] = Variable<String>(sourceOcId.value);
    }
    if (targetOcId.present) {
      map['target_oc_id'] = Variable<String>(targetOcId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (strength.present) {
      map['strength'] = Variable<String>(strength.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(direction.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('sourceOcId: $sourceOcId, ')
          ..write('targetOcId: $targetOcId, ')
          ..write('label: $label, ')
          ..write('strength: $strength, ')
          ..write('direction: $direction, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationStagesTable extends RelationStages
    with TableInfo<$RelationStagesTable, RelationStage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationStagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationshipIdMeta =
      const VerificationMeta('relationshipId');
  @override
  late final GeneratedColumn<String> relationshipId = GeneratedColumn<String>(
      'relationship_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stageNameMeta =
      const VerificationMeta('stageName');
  @override
  late final GeneratedColumn<String> stageName = GeneratedColumn<String>(
      'stage_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeTextMeta =
      const VerificationMeta('timeText');
  @override
  late final GeneratedColumn<String> timeText = GeneratedColumn<String>(
      'time_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesJsonMeta =
      const VerificationMeta('imagesJson');
  @override
  late final GeneratedColumn<String> imagesJson = GeneratedColumn<String>(
      'images_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, relationshipId, stageName, timeText, description, imagesJson, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relation_stages';
  @override
  VerificationContext validateIntegrity(Insertable<RelationStage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('relationship_id')) {
      context.handle(
          _relationshipIdMeta,
          relationshipId.isAcceptableOrUnknown(
              data['relationship_id']!, _relationshipIdMeta));
    } else if (isInserting) {
      context.missing(_relationshipIdMeta);
    }
    if (data.containsKey('stage_name')) {
      context.handle(_stageNameMeta,
          stageName.isAcceptableOrUnknown(data['stage_name']!, _stageNameMeta));
    } else if (isInserting) {
      context.missing(_stageNameMeta);
    }
    if (data.containsKey('time_text')) {
      context.handle(_timeTextMeta,
          timeText.isAcceptableOrUnknown(data['time_text']!, _timeTextMeta));
    } else if (isInserting) {
      context.missing(_timeTextMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('images_json')) {
      context.handle(
          _imagesJsonMeta,
          imagesJson.isAcceptableOrUnknown(
              data['images_json']!, _imagesJsonMeta));
    } else if (isInserting) {
      context.missing(_imagesJsonMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelationStage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationStage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      relationshipId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_id'])!,
      stageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stage_name'])!,
      timeText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_text'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imagesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images_json'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $RelationStagesTable createAlias(String alias) {
    return $RelationStagesTable(attachedDatabase, alias);
  }
}

class RelationStage extends DataClass implements Insertable<RelationStage> {
  final String id;
  final String relationshipId;
  final String stageName;
  final String timeText;
  final String description;
  final String imagesJson;
  final int sort;
  const RelationStage(
      {required this.id,
      required this.relationshipId,
      required this.stageName,
      required this.timeText,
      required this.description,
      required this.imagesJson,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['relationship_id'] = Variable<String>(relationshipId);
    map['stage_name'] = Variable<String>(stageName);
    map['time_text'] = Variable<String>(timeText);
    map['description'] = Variable<String>(description);
    map['images_json'] = Variable<String>(imagesJson);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  RelationStagesCompanion toCompanion(bool nullToAbsent) {
    return RelationStagesCompanion(
      id: Value(id),
      relationshipId: Value(relationshipId),
      stageName: Value(stageName),
      timeText: Value(timeText),
      description: Value(description),
      imagesJson: Value(imagesJson),
      sort: Value(sort),
    );
  }

  factory RelationStage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationStage(
      id: serializer.fromJson<String>(json['id']),
      relationshipId: serializer.fromJson<String>(json['relationshipId']),
      stageName: serializer.fromJson<String>(json['stageName']),
      timeText: serializer.fromJson<String>(json['timeText']),
      description: serializer.fromJson<String>(json['description']),
      imagesJson: serializer.fromJson<String>(json['imagesJson']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'relationshipId': serializer.toJson<String>(relationshipId),
      'stageName': serializer.toJson<String>(stageName),
      'timeText': serializer.toJson<String>(timeText),
      'description': serializer.toJson<String>(description),
      'imagesJson': serializer.toJson<String>(imagesJson),
      'sort': serializer.toJson<int>(sort),
    };
  }

  RelationStage copyWith(
          {String? id,
          String? relationshipId,
          String? stageName,
          String? timeText,
          String? description,
          String? imagesJson,
          int? sort}) =>
      RelationStage(
        id: id ?? this.id,
        relationshipId: relationshipId ?? this.relationshipId,
        stageName: stageName ?? this.stageName,
        timeText: timeText ?? this.timeText,
        description: description ?? this.description,
        imagesJson: imagesJson ?? this.imagesJson,
        sort: sort ?? this.sort,
      );
  RelationStage copyWithCompanion(RelationStagesCompanion data) {
    return RelationStage(
      id: data.id.present ? data.id.value : this.id,
      relationshipId: data.relationshipId.present
          ? data.relationshipId.value
          : this.relationshipId,
      stageName: data.stageName.present ? data.stageName.value : this.stageName,
      timeText: data.timeText.present ? data.timeText.value : this.timeText,
      description:
          data.description.present ? data.description.value : this.description,
      imagesJson:
          data.imagesJson.present ? data.imagesJson.value : this.imagesJson,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelationStage(')
          ..write('id: $id, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('stageName: $stageName, ')
          ..write('timeText: $timeText, ')
          ..write('description: $description, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, relationshipId, stageName, timeText, description, imagesJson, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationStage &&
          other.id == this.id &&
          other.relationshipId == this.relationshipId &&
          other.stageName == this.stageName &&
          other.timeText == this.timeText &&
          other.description == this.description &&
          other.imagesJson == this.imagesJson &&
          other.sort == this.sort);
}

class RelationStagesCompanion extends UpdateCompanion<RelationStage> {
  final Value<String> id;
  final Value<String> relationshipId;
  final Value<String> stageName;
  final Value<String> timeText;
  final Value<String> description;
  final Value<String> imagesJson;
  final Value<int> sort;
  final Value<int> rowid;
  const RelationStagesCompanion({
    this.id = const Value.absent(),
    this.relationshipId = const Value.absent(),
    this.stageName = const Value.absent(),
    this.timeText = const Value.absent(),
    this.description = const Value.absent(),
    this.imagesJson = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationStagesCompanion.insert({
    required String id,
    required String relationshipId,
    required String stageName,
    required String timeText,
    required String description,
    required String imagesJson,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        relationshipId = Value(relationshipId),
        stageName = Value(stageName),
        timeText = Value(timeText),
        description = Value(description),
        imagesJson = Value(imagesJson),
        sort = Value(sort);
  static Insertable<RelationStage> custom({
    Expression<String>? id,
    Expression<String>? relationshipId,
    Expression<String>? stageName,
    Expression<String>? timeText,
    Expression<String>? description,
    Expression<String>? imagesJson,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (relationshipId != null) 'relationship_id': relationshipId,
      if (stageName != null) 'stage_name': stageName,
      if (timeText != null) 'time_text': timeText,
      if (description != null) 'description': description,
      if (imagesJson != null) 'images_json': imagesJson,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationStagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? relationshipId,
      Value<String>? stageName,
      Value<String>? timeText,
      Value<String>? description,
      Value<String>? imagesJson,
      Value<int>? sort,
      Value<int>? rowid}) {
    return RelationStagesCompanion(
      id: id ?? this.id,
      relationshipId: relationshipId ?? this.relationshipId,
      stageName: stageName ?? this.stageName,
      timeText: timeText ?? this.timeText,
      description: description ?? this.description,
      imagesJson: imagesJson ?? this.imagesJson,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (relationshipId.present) {
      map['relationship_id'] = Variable<String>(relationshipId.value);
    }
    if (stageName.present) {
      map['stage_name'] = Variable<String>(stageName.value);
    }
    if (timeText.present) {
      map['time_text'] = Variable<String>(timeText.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imagesJson.present) {
      map['images_json'] = Variable<String>(imagesJson.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationStagesCompanion(')
          ..write('id: $id, ')
          ..write('relationshipId: $relationshipId, ')
          ..write('stageName: $stageName, ')
          ..write('timeText: $timeText, ')
          ..write('description: $description, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorldMapsTable extends WorldMaps
    with TableInfo<$WorldMapsTable, WorldMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorldMapsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, workId, name, imagePath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'world_maps';
  @override
  VerificationContext validateIntegrity(Insertable<WorldMap> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorldMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorldMap(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
    );
  }

  @override
  $WorldMapsTable createAlias(String alias) {
    return $WorldMapsTable(attachedDatabase, alias);
  }
}

class WorldMap extends DataClass implements Insertable<WorldMap> {
  final String id;
  final String workId;
  final String name;
  final String imagePath;
  const WorldMap(
      {required this.id,
      required this.workId,
      required this.name,
      required this.imagePath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['name'] = Variable<String>(name);
    map['image_path'] = Variable<String>(imagePath);
    return map;
  }

  WorldMapsCompanion toCompanion(bool nullToAbsent) {
    return WorldMapsCompanion(
      id: Value(id),
      workId: Value(workId),
      name: Value(name),
      imagePath: Value(imagePath),
    );
  }

  factory WorldMap.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorldMap(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  WorldMap copyWith(
          {String? id, String? workId, String? name, String? imagePath}) =>
      WorldMap(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
      );
  WorldMap copyWithCompanion(WorldMapsCompanion data) {
    return WorldMap(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      name: data.name.present ? data.name.value : this.name,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorldMap(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, name, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorldMap &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.name == this.name &&
          other.imagePath == this.imagePath);
}

class WorldMapsCompanion extends UpdateCompanion<WorldMap> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> name;
  final Value<String> imagePath;
  final Value<int> rowid;
  const WorldMapsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorldMapsCompanion.insert({
    required String id,
    required String workId,
    required String name,
    required String imagePath,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        name = Value(name),
        imagePath = Value(imagePath);
  static Insertable<WorldMap> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? name,
    Expression<String>? imagePath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorldMapsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? name,
      Value<String>? imagePath,
      Value<int>? rowid}) {
    return WorldMapsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorldMapsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesJsonMeta =
      const VerificationMeta('imagesJson');
  @override
  late final GeneratedColumn<String> imagesJson = GeneratedColumn<String>(
      'images_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mapIdMeta = const VerificationMeta('mapId');
  @override
  late final GeneratedColumn<String> mapId = GeneratedColumn<String>(
      'map_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workId, parentId, name, description, type, imagesJson, mapId, x, y];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('images_json')) {
      context.handle(
          _imagesJsonMeta,
          imagesJson.isAcceptableOrUnknown(
              data['images_json']!, _imagesJsonMeta));
    } else if (isInserting) {
      context.missing(_imagesJsonMeta);
    }
    if (data.containsKey('map_id')) {
      context.handle(
          _mapIdMeta, mapId.isAcceptableOrUnknown(data['map_id']!, _mapIdMeta));
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      imagesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images_json'])!,
      mapId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}map_id']),
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x']),
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y']),
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final String id;
  final String workId;
  final String? parentId;
  final String name;
  final String description;
  final String type;
  final String imagesJson;
  final String? mapId;
  final double? x;
  final double? y;
  const Location(
      {required this.id,
      required this.workId,
      this.parentId,
      required this.name,
      required this.description,
      required this.type,
      required this.imagesJson,
      this.mapId,
      this.x,
      this.y});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['type'] = Variable<String>(type);
    map['images_json'] = Variable<String>(imagesJson);
    if (!nullToAbsent || mapId != null) {
      map['map_id'] = Variable<String>(mapId);
    }
    if (!nullToAbsent || x != null) {
      map['x'] = Variable<double>(x);
    }
    if (!nullToAbsent || y != null) {
      map['y'] = Variable<double>(y);
    }
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      workId: Value(workId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      description: Value(description),
      type: Value(type),
      imagesJson: Value(imagesJson),
      mapId:
          mapId == null && nullToAbsent ? const Value.absent() : Value(mapId),
      x: x == null && nullToAbsent ? const Value.absent() : Value(x),
      y: y == null && nullToAbsent ? const Value.absent() : Value(y),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      imagesJson: serializer.fromJson<String>(json['imagesJson']),
      mapId: serializer.fromJson<String?>(json['mapId']),
      x: serializer.fromJson<double?>(json['x']),
      y: serializer.fromJson<double?>(json['y']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'parentId': serializer.toJson<String?>(parentId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
      'imagesJson': serializer.toJson<String>(imagesJson),
      'mapId': serializer.toJson<String?>(mapId),
      'x': serializer.toJson<double?>(x),
      'y': serializer.toJson<double?>(y),
    };
  }

  Location copyWith(
          {String? id,
          String? workId,
          Value<String?> parentId = const Value.absent(),
          String? name,
          String? description,
          String? type,
          String? imagesJson,
          Value<String?> mapId = const Value.absent(),
          Value<double?> x = const Value.absent(),
          Value<double?> y = const Value.absent()}) =>
      Location(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        parentId: parentId.present ? parentId.value : this.parentId,
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        imagesJson: imagesJson ?? this.imagesJson,
        mapId: mapId.present ? mapId.value : this.mapId,
        x: x.present ? x.value : this.x,
        y: y.present ? y.value : this.y,
      );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      imagesJson:
          data.imagesJson.present ? data.imagesJson.value : this.imagesJson,
      mapId: data.mapId.present ? data.mapId.value : this.mapId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('mapId: $mapId, ')
          ..write('x: $x, ')
          ..write('y: $y')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workId, parentId, name, description, type, imagesJson, mapId, x, y);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.imagesJson == this.imagesJson &&
          other.mapId == this.mapId &&
          other.x == this.x &&
          other.y == this.y);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String?> parentId;
  final Value<String> name;
  final Value<String> description;
  final Value<String> type;
  final Value<String> imagesJson;
  final Value<String?> mapId;
  final Value<double?> x;
  final Value<double?> y;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.imagesJson = const Value.absent(),
    this.mapId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    required String workId,
    this.parentId = const Value.absent(),
    required String name,
    required String description,
    required String type,
    required String imagesJson,
    this.mapId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        name = Value(name),
        description = Value(description),
        type = Value(type),
        imagesJson = Value(imagesJson);
  static Insertable<Location> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? parentId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? imagesJson,
    Expression<String>? mapId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (imagesJson != null) 'images_json': imagesJson,
      if (mapId != null) 'map_id': mapId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String?>? parentId,
      Value<String>? name,
      Value<String>? description,
      Value<String>? type,
      Value<String>? imagesJson,
      Value<String?>? mapId,
      Value<double?>? x,
      Value<double?>? y,
      Value<int>? rowid}) {
    return LocationsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      imagesJson: imagesJson ?? this.imagesJson,
      mapId: mapId ?? this.mapId,
      x: x ?? this.x,
      y: y ?? this.y,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (imagesJson.present) {
      map['images_json'] = Variable<String>(imagesJson.value);
    }
    if (mapId.present) {
      map['map_id'] = Variable<String>(mapId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('imagesJson: $imagesJson, ')
          ..write('mapId: $mapId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RuleEntriesTable extends RuleEntries
    with TableInfo<$RuleEntriesTable, RuleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, workId, section, title, body];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_entries';
  @override
  VerificationContext validateIntegrity(Insertable<RuleEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
    );
  }

  @override
  $RuleEntriesTable createAlias(String alias) {
    return $RuleEntriesTable(attachedDatabase, alias);
  }
}

class RuleEntry extends DataClass implements Insertable<RuleEntry> {
  final String id;
  final String workId;
  final String section;
  final String title;
  final String body;
  const RuleEntry(
      {required this.id,
      required this.workId,
      required this.section,
      required this.title,
      required this.body});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['section'] = Variable<String>(section);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    return map;
  }

  RuleEntriesCompanion toCompanion(bool nullToAbsent) {
    return RuleEntriesCompanion(
      id: Value(id),
      workId: Value(workId),
      section: Value(section),
      title: Value(title),
      body: Value(body),
    );
  }

  factory RuleEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleEntry(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      section: serializer.fromJson<String>(json['section']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'section': serializer.toJson<String>(section),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
    };
  }

  RuleEntry copyWith(
          {String? id,
          String? workId,
          String? section,
          String? title,
          String? body}) =>
      RuleEntry(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        section: section ?? this.section,
        title: title ?? this.title,
        body: body ?? this.body,
      );
  RuleEntry copyWithCompanion(RuleEntriesCompanion data) {
    return RuleEntry(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      section: data.section.present ? data.section.value : this.section,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleEntry(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('section: $section, ')
          ..write('title: $title, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, section, title, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleEntry &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.section == this.section &&
          other.title == this.title &&
          other.body == this.body);
}

class RuleEntriesCompanion extends UpdateCompanion<RuleEntry> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> section;
  final Value<String> title;
  final Value<String> body;
  final Value<int> rowid;
  const RuleEntriesCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.section = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RuleEntriesCompanion.insert({
    required String id,
    required String workId,
    required String section,
    required String title,
    required String body,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        section = Value(section),
        title = Value(title),
        body = Value(body);
  static Insertable<RuleEntry> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? section,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (section != null) 'section': section,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RuleEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? section,
      Value<String>? title,
      Value<String>? body,
      Value<int>? rowid}) {
    return RuleEntriesCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      section: section ?? this.section,
      title: title ?? this.title,
      body: body ?? this.body,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('section: $section, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RuleTagsTable extends RuleTags with TableInfo<$RuleTagsTable, RuleTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
      'rule_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [ruleId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_tags';
  @override
  VerificationContext validateIntegrity(Insertable<RuleTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('rule_id')) {
      context.handle(_ruleIdMeta,
          ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta));
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ruleId, tagId};
  @override
  RuleTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleTag(
      ruleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rule_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $RuleTagsTable createAlias(String alias) {
    return $RuleTagsTable(attachedDatabase, alias);
  }
}

class RuleTag extends DataClass implements Insertable<RuleTag> {
  final String ruleId;
  final String tagId;
  const RuleTag({required this.ruleId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['rule_id'] = Variable<String>(ruleId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  RuleTagsCompanion toCompanion(bool nullToAbsent) {
    return RuleTagsCompanion(
      ruleId: Value(ruleId),
      tagId: Value(tagId),
    );
  }

  factory RuleTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleTag(
      ruleId: serializer.fromJson<String>(json['ruleId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ruleId': serializer.toJson<String>(ruleId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  RuleTag copyWith({String? ruleId, String? tagId}) => RuleTag(
        ruleId: ruleId ?? this.ruleId,
        tagId: tagId ?? this.tagId,
      );
  RuleTag copyWithCompanion(RuleTagsCompanion data) {
    return RuleTag(
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleTag(')
          ..write('ruleId: $ruleId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ruleId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleTag &&
          other.ruleId == this.ruleId &&
          other.tagId == this.tagId);
}

class RuleTagsCompanion extends UpdateCompanion<RuleTag> {
  final Value<String> ruleId;
  final Value<String> tagId;
  final Value<int> rowid;
  const RuleTagsCompanion({
    this.ruleId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RuleTagsCompanion.insert({
    required String ruleId,
    required String tagId,
    this.rowid = const Value.absent(),
  })  : ruleId = Value(ruleId),
        tagId = Value(tagId);
  static Insertable<RuleTag> custom({
    Expression<String>? ruleId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ruleId != null) 'rule_id': ruleId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RuleTagsCompanion copyWith(
      {Value<String>? ruleId, Value<String>? tagId, Value<int>? rowid}) {
    return RuleTagsCompanion(
      ruleId: ruleId ?? this.ruleId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleTagsCompanion(')
          ..write('ruleId: $ruleId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistItemsTable extends ChecklistItems
    with TableInfo<$ChecklistItemsTable, ChecklistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<int> sort = GeneratedColumn<int>(
      'sort', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workId, category, content, status, remark, sort];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_items';
  @override
  VerificationContext validateIntegrity(Insertable<ChecklistItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    } else if (isInserting) {
      context.missing(_remarkMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark'])!,
      sort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort'])!,
    );
  }

  @override
  $ChecklistItemsTable createAlias(String alias) {
    return $ChecklistItemsTable(attachedDatabase, alias);
  }
}

class ChecklistItem extends DataClass implements Insertable<ChecklistItem> {
  final String id;
  final String workId;
  final String category;
  final String content;

  /// 通过 / 存疑 / 不适用
  final String status;
  final String remark;
  final int sort;
  const ChecklistItem(
      {required this.id,
      required this.workId,
      required this.category,
      required this.content,
      required this.status,
      required this.remark,
      required this.sort});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['category'] = Variable<String>(category);
    map['content'] = Variable<String>(content);
    map['status'] = Variable<String>(status);
    map['remark'] = Variable<String>(remark);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistItemsCompanion(
      id: Value(id),
      workId: Value(workId),
      category: Value(category),
      content: Value(content),
      status: Value(status),
      remark: Value(remark),
      sort: Value(sort),
    );
  }

  factory ChecklistItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistItem(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      category: serializer.fromJson<String>(json['category']),
      content: serializer.fromJson<String>(json['content']),
      status: serializer.fromJson<String>(json['status']),
      remark: serializer.fromJson<String>(json['remark']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'category': serializer.toJson<String>(category),
      'content': serializer.toJson<String>(content),
      'status': serializer.toJson<String>(status),
      'remark': serializer.toJson<String>(remark),
      'sort': serializer.toJson<int>(sort),
    };
  }

  ChecklistItem copyWith(
          {String? id,
          String? workId,
          String? category,
          String? content,
          String? status,
          String? remark,
          int? sort}) =>
      ChecklistItem(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        category: category ?? this.category,
        content: content ?? this.content,
        status: status ?? this.status,
        remark: remark ?? this.remark,
        sort: sort ?? this.sort,
      );
  ChecklistItem copyWithCompanion(ChecklistItemsCompanion data) {
    return ChecklistItem(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      category: data.category.present ? data.category.value : this.category,
      content: data.content.present ? data.content.value : this.content,
      status: data.status.present ? data.status.value : this.status,
      remark: data.remark.present ? data.remark.value : this.remark,
      sort: data.sort.present ? data.sort.value : this.sort,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItem(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('category: $category, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('remark: $remark, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workId, category, content, status, remark, sort);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistItem &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.category == this.category &&
          other.content == this.content &&
          other.status == this.status &&
          other.remark == this.remark &&
          other.sort == this.sort);
}

class ChecklistItemsCompanion extends UpdateCompanion<ChecklistItem> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> category;
  final Value<String> content;
  final Value<String> status;
  final Value<String> remark;
  final Value<int> sort;
  final Value<int> rowid;
  const ChecklistItemsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.category = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.remark = const Value.absent(),
    this.sort = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistItemsCompanion.insert({
    required String id,
    required String workId,
    required String category,
    required String content,
    required String status,
    required String remark,
    required int sort,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        category = Value(category),
        content = Value(content),
        status = Value(status),
        remark = Value(remark),
        sort = Value(sort);
  static Insertable<ChecklistItem> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? category,
    Expression<String>? content,
    Expression<String>? status,
    Expression<String>? remark,
    Expression<int>? sort,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (category != null) 'category': category,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
      if (remark != null) 'remark': remark,
      if (sort != null) 'sort': sort,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? category,
      Value<String>? content,
      Value<String>? status,
      Value<String>? remark,
      Value<int>? sort,
      Value<int>? rowid}) {
    return ChecklistItemsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      category: category ?? this.category,
      content: content ?? this.content,
      status: status ?? this.status,
      remark: remark ?? this.remark,
      sort: sort ?? this.sort,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('category: $category, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('remark: $remark, ')
          ..write('sort: $sort, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspirationsTable extends Inspirations
    with TableInfo<$InspirationsTable, Inspiration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspirationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workIdMeta = const VerificationMeta('workId');
  @override
  late final GeneratedColumn<String> workId = GeneratedColumn<String>(
      'work_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transcriptMeta =
      const VerificationMeta('transcript');
  @override
  late final GeneratedColumn<String> transcript = GeneratedColumn<String>(
      'transcript', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refsJsonMeta =
      const VerificationMeta('refsJson');
  @override
  late final GeneratedColumn<String> refsJson = GeneratedColumn<String>(
      'refs_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workId,
        type,
        content,
        transcript,
        audioPath,
        tagsJson,
        status,
        refsJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspirations';
  @override
  VerificationContext validateIntegrity(Insertable<Inspiration> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('work_id')) {
      context.handle(_workIdMeta,
          workId.isAcceptableOrUnknown(data['work_id']!, _workIdMeta));
    } else if (isInserting) {
      context.missing(_workIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('transcript')) {
      context.handle(
          _transcriptMeta,
          transcript.isAcceptableOrUnknown(
              data['transcript']!, _transcriptMeta));
    } else if (isInserting) {
      context.missing(_transcriptMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    } else if (isInserting) {
      context.missing(_tagsJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('refs_json')) {
      context.handle(_refsJsonMeta,
          refsJson.isAcceptableOrUnknown(data['refs_json']!, _refsJsonMeta));
    } else if (isInserting) {
      context.missing(_refsJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inspiration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inspiration(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}work_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      transcript: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transcript'])!,
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      refsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refs_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $InspirationsTable createAlias(String alias) {
    return $InspirationsTable(attachedDatabase, alias);
  }
}

class Inspiration extends DataClass implements Insertable<Inspiration> {
  final String id;
  final String workId;

  /// text | voice
  final String type;
  final String content;
  final String transcript;
  final String audioPath;
  final String tagsJson;

  /// unused | used | archived
  final String status;
  final String refsJson;
  final DateTime createdAt;
  const Inspiration(
      {required this.id,
      required this.workId,
      required this.type,
      required this.content,
      required this.transcript,
      required this.audioPath,
      required this.tagsJson,
      required this.status,
      required this.refsJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['work_id'] = Variable<String>(workId);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['transcript'] = Variable<String>(transcript);
    map['audio_path'] = Variable<String>(audioPath);
    map['tags_json'] = Variable<String>(tagsJson);
    map['status'] = Variable<String>(status);
    map['refs_json'] = Variable<String>(refsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InspirationsCompanion toCompanion(bool nullToAbsent) {
    return InspirationsCompanion(
      id: Value(id),
      workId: Value(workId),
      type: Value(type),
      content: Value(content),
      transcript: Value(transcript),
      audioPath: Value(audioPath),
      tagsJson: Value(tagsJson),
      status: Value(status),
      refsJson: Value(refsJson),
      createdAt: Value(createdAt),
    );
  }

  factory Inspiration.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inspiration(
      id: serializer.fromJson<String>(json['id']),
      workId: serializer.fromJson<String>(json['workId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      transcript: serializer.fromJson<String>(json['transcript']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      status: serializer.fromJson<String>(json['status']),
      refsJson: serializer.fromJson<String>(json['refsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workId': serializer.toJson<String>(workId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'transcript': serializer.toJson<String>(transcript),
      'audioPath': serializer.toJson<String>(audioPath),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'status': serializer.toJson<String>(status),
      'refsJson': serializer.toJson<String>(refsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Inspiration copyWith(
          {String? id,
          String? workId,
          String? type,
          String? content,
          String? transcript,
          String? audioPath,
          String? tagsJson,
          String? status,
          String? refsJson,
          DateTime? createdAt}) =>
      Inspiration(
        id: id ?? this.id,
        workId: workId ?? this.workId,
        type: type ?? this.type,
        content: content ?? this.content,
        transcript: transcript ?? this.transcript,
        audioPath: audioPath ?? this.audioPath,
        tagsJson: tagsJson ?? this.tagsJson,
        status: status ?? this.status,
        refsJson: refsJson ?? this.refsJson,
        createdAt: createdAt ?? this.createdAt,
      );
  Inspiration copyWithCompanion(InspirationsCompanion data) {
    return Inspiration(
      id: data.id.present ? data.id.value : this.id,
      workId: data.workId.present ? data.workId.value : this.workId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      transcript:
          data.transcript.present ? data.transcript.value : this.transcript,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      status: data.status.present ? data.status.value : this.status,
      refsJson: data.refsJson.present ? data.refsJson.value : this.refsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inspiration(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('transcript: $transcript, ')
          ..write('audioPath: $audioPath, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('status: $status, ')
          ..write('refsJson: $refsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workId, type, content, transcript,
      audioPath, tagsJson, status, refsJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inspiration &&
          other.id == this.id &&
          other.workId == this.workId &&
          other.type == this.type &&
          other.content == this.content &&
          other.transcript == this.transcript &&
          other.audioPath == this.audioPath &&
          other.tagsJson == this.tagsJson &&
          other.status == this.status &&
          other.refsJson == this.refsJson &&
          other.createdAt == this.createdAt);
}

class InspirationsCompanion extends UpdateCompanion<Inspiration> {
  final Value<String> id;
  final Value<String> workId;
  final Value<String> type;
  final Value<String> content;
  final Value<String> transcript;
  final Value<String> audioPath;
  final Value<String> tagsJson;
  final Value<String> status;
  final Value<String> refsJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InspirationsCompanion({
    this.id = const Value.absent(),
    this.workId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.transcript = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.status = const Value.absent(),
    this.refsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspirationsCompanion.insert({
    required String id,
    required String workId,
    required String type,
    required String content,
    required String transcript,
    required String audioPath,
    required String tagsJson,
    required String status,
    required String refsJson,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workId = Value(workId),
        type = Value(type),
        content = Value(content),
        transcript = Value(transcript),
        audioPath = Value(audioPath),
        tagsJson = Value(tagsJson),
        status = Value(status),
        refsJson = Value(refsJson),
        createdAt = Value(createdAt);
  static Insertable<Inspiration> custom({
    Expression<String>? id,
    Expression<String>? workId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? transcript,
    Expression<String>? audioPath,
    Expression<String>? tagsJson,
    Expression<String>? status,
    Expression<String>? refsJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workId != null) 'work_id': workId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (transcript != null) 'transcript': transcript,
      if (audioPath != null) 'audio_path': audioPath,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (status != null) 'status': status,
      if (refsJson != null) 'refs_json': refsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspirationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workId,
      Value<String>? type,
      Value<String>? content,
      Value<String>? transcript,
      Value<String>? audioPath,
      Value<String>? tagsJson,
      Value<String>? status,
      Value<String>? refsJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return InspirationsCompanion(
      id: id ?? this.id,
      workId: workId ?? this.workId,
      type: type ?? this.type,
      content: content ?? this.content,
      transcript: transcript ?? this.transcript,
      audioPath: audioPath ?? this.audioPath,
      tagsJson: tagsJson ?? this.tagsJson,
      status: status ?? this.status,
      refsJson: refsJson ?? this.refsJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workId.present) {
      map['work_id'] = Variable<String>(workId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (transcript.present) {
      map['transcript'] = Variable<String>(transcript.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (refsJson.present) {
      map['refs_json'] = Variable<String>(refsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspirationsCompanion(')
          ..write('id: $id, ')
          ..write('workId: $workId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('transcript: $transcript, ')
          ..write('audioPath: $audioPath, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('status: $status, ')
          ..write('refsJson: $refsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorksTable works = $WorksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $DimensionTemplatesTable dimensionTemplates =
      $DimensionTemplatesTable(this);
  late final $OcsTable ocs = $OcsTable(this);
  late final $OcTagsTable ocTags = $OcTagsTable(this);
  late final $AppearanceItemsTable appearanceItems =
      $AppearanceItemsTable(this);
  late final $AbilityValuesTable abilityValues = $AbilityValuesTable(this);
  late final $CoreValuesTable coreValues = $CoreValuesTable(this);
  late final $TraitsTable traits = $TraitsTable(this);
  late final $CatchphrasesTable catchphrases = $CatchphrasesTable(this);
  late final $ExtensionFieldsTable extensionFields =
      $ExtensionFieldsTable(this);
  late final $TimelineEventsTable timelineEvents = $TimelineEventsTable(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $RelationStagesTable relationStages = $RelationStagesTable(this);
  late final $WorldMapsTable worldMaps = $WorldMapsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $RuleEntriesTable ruleEntries = $RuleEntriesTable(this);
  late final $RuleTagsTable ruleTags = $RuleTagsTable(this);
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  late final $InspirationsTable inspirations = $InspirationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        works,
        tags,
        dimensionTemplates,
        ocs,
        ocTags,
        appearanceItems,
        abilityValues,
        coreValues,
        traits,
        catchphrases,
        extensionFields,
        timelineEvents,
        relationships,
        relationStages,
        worldMaps,
        locations,
        ruleEntries,
        ruleTags,
        checklistItems,
        inspirations
      ];
}

typedef $$WorksTableCreateCompanionBuilder = WorksCompanion Function({
  required String id,
  required String name,
  Value<String?> coverPath,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$WorksTableUpdateCompanionBuilder = WorksCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> coverPath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$WorksTableFilterComposer extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverPath => $composableBuilder(
      column: $table.coverPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WorksTableOrderingComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverPath => $composableBuilder(
      column: $table.coverPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorksTable> {
  $$WorksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorksTable,
    Work,
    $$WorksTableFilterComposer,
    $$WorksTableOrderingComposer,
    $$WorksTableAnnotationComposer,
    $$WorksTableCreateCompanionBuilder,
    $$WorksTableUpdateCompanionBuilder,
    (Work, BaseReferences<_$AppDatabase, $WorksTable, Work>),
    Work,
    PrefetchHooks Function()> {
  $$WorksTableTableManager(_$AppDatabase db, $WorksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> coverPath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion(
            id: id,
            name: name,
            coverPath: coverPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> coverPath = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorksCompanion.insert(
            id: id,
            name: name,
            coverPath: coverPath,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorksTable,
    Work,
    $$WorksTableFilterComposer,
    $$WorksTableOrderingComposer,
    $$WorksTableAnnotationComposer,
    $$WorksTableCreateCompanionBuilder,
    $$WorksTableUpdateCompanionBuilder,
    (Work, BaseReferences<_$AppDatabase, $WorksTable, Work>),
    Work,
    PrefetchHooks Function()>;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  required String id,
  required String workId,
  required String name,
  required int colorValue,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String> name,
  Value<int> colorValue,
  Value<int> rowid,
});

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);
}

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
    Tag,
    PrefetchHooks Function()> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            workId: workId,
            name: name,
            colorValue: colorValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String name,
            required int colorValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            workId: workId,
            name: name,
            colorValue: colorValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, BaseReferences<_$AppDatabase, $TagsTable, Tag>),
    Tag,
    PrefetchHooks Function()>;
typedef $$DimensionTemplatesTableCreateCompanionBuilder
    = DimensionTemplatesCompanion Function({
  required String id,
  required String workId,
  required String name,
  required int sort,
  Value<int> rowid,
});
typedef $$DimensionTemplatesTableUpdateCompanionBuilder
    = DimensionTemplatesCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String> name,
  Value<int> sort,
  Value<int> rowid,
});

class $$DimensionTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $DimensionTemplatesTable> {
  $$DimensionTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$DimensionTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $DimensionTemplatesTable> {
  $$DimensionTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$DimensionTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DimensionTemplatesTable> {
  $$DimensionTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$DimensionTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DimensionTemplatesTable,
    DimensionTemplate,
    $$DimensionTemplatesTableFilterComposer,
    $$DimensionTemplatesTableOrderingComposer,
    $$DimensionTemplatesTableAnnotationComposer,
    $$DimensionTemplatesTableCreateCompanionBuilder,
    $$DimensionTemplatesTableUpdateCompanionBuilder,
    (
      DimensionTemplate,
      BaseReferences<_$AppDatabase, $DimensionTemplatesTable, DimensionTemplate>
    ),
    DimensionTemplate,
    PrefetchHooks Function()> {
  $$DimensionTemplatesTableTableManager(
      _$AppDatabase db, $DimensionTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DimensionTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DimensionTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DimensionTemplatesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DimensionTemplatesCompanion(
            id: id,
            workId: workId,
            name: name,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String name,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              DimensionTemplatesCompanion.insert(
            id: id,
            workId: workId,
            name: name,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DimensionTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DimensionTemplatesTable,
    DimensionTemplate,
    $$DimensionTemplatesTableFilterComposer,
    $$DimensionTemplatesTableOrderingComposer,
    $$DimensionTemplatesTableAnnotationComposer,
    $$DimensionTemplatesTableCreateCompanionBuilder,
    $$DimensionTemplatesTableUpdateCompanionBuilder,
    (
      DimensionTemplate,
      BaseReferences<_$AppDatabase, $DimensionTemplatesTable, DimensionTemplate>
    ),
    DimensionTemplate,
    PrefetchHooks Function()>;
typedef $$OcsTableCreateCompanionBuilder = OcsCompanion Function({
  required String id,
  required String workId,
  required String name,
  Value<String?> age,
  Value<String?> gender,
  Value<DateTime?> birthday,
  Value<String?> constellation,
  Value<String?> avatarPath,
  Value<String?> mbti,
  Value<String> familyBackground,
  Value<String> coreDrive,
  Value<String> goalMotivation,
  Value<double?> posX,
  Value<double?> posY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$OcsTableUpdateCompanionBuilder = OcsCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String> name,
  Value<String?> age,
  Value<String?> gender,
  Value<DateTime?> birthday,
  Value<String?> constellation,
  Value<String?> avatarPath,
  Value<String?> mbti,
  Value<String> familyBackground,
  Value<String> coreDrive,
  Value<String> goalMotivation,
  Value<double?> posX,
  Value<double?> posY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$OcsTableFilterComposer extends Composer<_$AppDatabase, $OcsTable> {
  $$OcsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get constellation => $composableBuilder(
      column: $table.constellation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mbti => $composableBuilder(
      column: $table.mbti, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familyBackground => $composableBuilder(
      column: $table.familyBackground,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coreDrive => $composableBuilder(
      column: $table.coreDrive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalMotivation => $composableBuilder(
      column: $table.goalMotivation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get posX => $composableBuilder(
      column: $table.posX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get posY => $composableBuilder(
      column: $table.posY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$OcsTableOrderingComposer extends Composer<_$AppDatabase, $OcsTable> {
  $$OcsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get constellation => $composableBuilder(
      column: $table.constellation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mbti => $composableBuilder(
      column: $table.mbti, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familyBackground => $composableBuilder(
      column: $table.familyBackground,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coreDrive => $composableBuilder(
      column: $table.coreDrive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalMotivation => $composableBuilder(
      column: $table.goalMotivation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get posX => $composableBuilder(
      column: $table.posX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get posY => $composableBuilder(
      column: $table.posY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$OcsTableAnnotationComposer extends Composer<_$AppDatabase, $OcsTable> {
  $$OcsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get constellation => $composableBuilder(
      column: $table.constellation, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => column);

  GeneratedColumn<String> get mbti =>
      $composableBuilder(column: $table.mbti, builder: (column) => column);

  GeneratedColumn<String> get familyBackground => $composableBuilder(
      column: $table.familyBackground, builder: (column) => column);

  GeneratedColumn<String> get coreDrive =>
      $composableBuilder(column: $table.coreDrive, builder: (column) => column);

  GeneratedColumn<String> get goalMotivation => $composableBuilder(
      column: $table.goalMotivation, builder: (column) => column);

  GeneratedColumn<double> get posX =>
      $composableBuilder(column: $table.posX, builder: (column) => column);

  GeneratedColumn<double> get posY =>
      $composableBuilder(column: $table.posY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OcsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OcsTable,
    Oc,
    $$OcsTableFilterComposer,
    $$OcsTableOrderingComposer,
    $$OcsTableAnnotationComposer,
    $$OcsTableCreateCompanionBuilder,
    $$OcsTableUpdateCompanionBuilder,
    (Oc, BaseReferences<_$AppDatabase, $OcsTable, Oc>),
    Oc,
    PrefetchHooks Function()> {
  $$OcsTableTableManager(_$AppDatabase db, $OcsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OcsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OcsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OcsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<String?> constellation = const Value.absent(),
            Value<String?> avatarPath = const Value.absent(),
            Value<String?> mbti = const Value.absent(),
            Value<String> familyBackground = const Value.absent(),
            Value<String> coreDrive = const Value.absent(),
            Value<String> goalMotivation = const Value.absent(),
            Value<double?> posX = const Value.absent(),
            Value<double?> posY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OcsCompanion(
            id: id,
            workId: workId,
            name: name,
            age: age,
            gender: gender,
            birthday: birthday,
            constellation: constellation,
            avatarPath: avatarPath,
            mbti: mbti,
            familyBackground: familyBackground,
            coreDrive: coreDrive,
            goalMotivation: goalMotivation,
            posX: posX,
            posY: posY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String name,
            Value<String?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<String?> constellation = const Value.absent(),
            Value<String?> avatarPath = const Value.absent(),
            Value<String?> mbti = const Value.absent(),
            Value<String> familyBackground = const Value.absent(),
            Value<String> coreDrive = const Value.absent(),
            Value<String> goalMotivation = const Value.absent(),
            Value<double?> posX = const Value.absent(),
            Value<double?> posY = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              OcsCompanion.insert(
            id: id,
            workId: workId,
            name: name,
            age: age,
            gender: gender,
            birthday: birthday,
            constellation: constellation,
            avatarPath: avatarPath,
            mbti: mbti,
            familyBackground: familyBackground,
            coreDrive: coreDrive,
            goalMotivation: goalMotivation,
            posX: posX,
            posY: posY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OcsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OcsTable,
    Oc,
    $$OcsTableFilterComposer,
    $$OcsTableOrderingComposer,
    $$OcsTableAnnotationComposer,
    $$OcsTableCreateCompanionBuilder,
    $$OcsTableUpdateCompanionBuilder,
    (Oc, BaseReferences<_$AppDatabase, $OcsTable, Oc>),
    Oc,
    PrefetchHooks Function()>;
typedef $$OcTagsTableCreateCompanionBuilder = OcTagsCompanion Function({
  required String ocId,
  required String tagId,
  Value<int> rowid,
});
typedef $$OcTagsTableUpdateCompanionBuilder = OcTagsCompanion Function({
  Value<String> ocId,
  Value<String> tagId,
  Value<int> rowid,
});

class $$OcTagsTableFilterComposer
    extends Composer<_$AppDatabase, $OcTagsTable> {
  $$OcTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));
}

class $$OcTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $OcTagsTable> {
  $$OcTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));
}

class $$OcTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OcTagsTable> {
  $$OcTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$OcTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OcTagsTable,
    OcTag,
    $$OcTagsTableFilterComposer,
    $$OcTagsTableOrderingComposer,
    $$OcTagsTableAnnotationComposer,
    $$OcTagsTableCreateCompanionBuilder,
    $$OcTagsTableUpdateCompanionBuilder,
    (OcTag, BaseReferences<_$AppDatabase, $OcTagsTable, OcTag>),
    OcTag,
    PrefetchHooks Function()> {
  $$OcTagsTableTableManager(_$AppDatabase db, $OcTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OcTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OcTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OcTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> ocId = const Value.absent(),
            Value<String> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OcTagsCompanion(
            ocId: ocId,
            tagId: tagId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String ocId,
            required String tagId,
            Value<int> rowid = const Value.absent(),
          }) =>
              OcTagsCompanion.insert(
            ocId: ocId,
            tagId: tagId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OcTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OcTagsTable,
    OcTag,
    $$OcTagsTableFilterComposer,
    $$OcTagsTableOrderingComposer,
    $$OcTagsTableAnnotationComposer,
    $$OcTagsTableCreateCompanionBuilder,
    $$OcTagsTableUpdateCompanionBuilder,
    (OcTag, BaseReferences<_$AppDatabase, $OcTagsTable, OcTag>),
    OcTag,
    PrefetchHooks Function()>;
typedef $$AppearanceItemsTableCreateCompanionBuilder = AppearanceItemsCompanion
    Function({
  required String id,
  required String ocId,
  required String section,
  required String richText,
  required String imagesJson,
  required int sort,
  Value<int> rowid,
});
typedef $$AppearanceItemsTableUpdateCompanionBuilder = AppearanceItemsCompanion
    Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> section,
  Value<String> richText,
  Value<String> imagesJson,
  Value<int> sort,
  Value<int> rowid,
});

class $$AppearanceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $AppearanceItemsTable> {
  $$AppearanceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get richText => $composableBuilder(
      column: $table.richText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$AppearanceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppearanceItemsTable> {
  $$AppearanceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get richText => $composableBuilder(
      column: $table.richText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$AppearanceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppearanceItemsTable> {
  $$AppearanceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get richText =>
      $composableBuilder(column: $table.richText, builder: (column) => column);

  GeneratedColumn<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$AppearanceItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppearanceItemsTable,
    AppearanceItem,
    $$AppearanceItemsTableFilterComposer,
    $$AppearanceItemsTableOrderingComposer,
    $$AppearanceItemsTableAnnotationComposer,
    $$AppearanceItemsTableCreateCompanionBuilder,
    $$AppearanceItemsTableUpdateCompanionBuilder,
    (
      AppearanceItem,
      BaseReferences<_$AppDatabase, $AppearanceItemsTable, AppearanceItem>
    ),
    AppearanceItem,
    PrefetchHooks Function()> {
  $$AppearanceItemsTableTableManager(
      _$AppDatabase db, $AppearanceItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppearanceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppearanceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppearanceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<String> richText = const Value.absent(),
            Value<String> imagesJson = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppearanceItemsCompanion(
            id: id,
            ocId: ocId,
            section: section,
            richText: richText,
            imagesJson: imagesJson,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String section,
            required String richText,
            required String imagesJson,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppearanceItemsCompanion.insert(
            id: id,
            ocId: ocId,
            section: section,
            richText: richText,
            imagesJson: imagesJson,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppearanceItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppearanceItemsTable,
    AppearanceItem,
    $$AppearanceItemsTableFilterComposer,
    $$AppearanceItemsTableOrderingComposer,
    $$AppearanceItemsTableAnnotationComposer,
    $$AppearanceItemsTableCreateCompanionBuilder,
    $$AppearanceItemsTableUpdateCompanionBuilder,
    (
      AppearanceItem,
      BaseReferences<_$AppDatabase, $AppearanceItemsTable, AppearanceItem>
    ),
    AppearanceItem,
    PrefetchHooks Function()>;
typedef $$AbilityValuesTableCreateCompanionBuilder = AbilityValuesCompanion
    Function({
  required String id,
  required String ocId,
  required String dimensionName,
  required int score,
  Value<String?> remark,
  Value<int> rowid,
});
typedef $$AbilityValuesTableUpdateCompanionBuilder = AbilityValuesCompanion
    Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> dimensionName,
  Value<int> score,
  Value<String?> remark,
  Value<int> rowid,
});

class $$AbilityValuesTableFilterComposer
    extends Composer<_$AppDatabase, $AbilityValuesTable> {
  $$AbilityValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dimensionName => $composableBuilder(
      column: $table.dimensionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));
}

class $$AbilityValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $AbilityValuesTable> {
  $$AbilityValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dimensionName => $composableBuilder(
      column: $table.dimensionName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));
}

class $$AbilityValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbilityValuesTable> {
  $$AbilityValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get dimensionName => $composableBuilder(
      column: $table.dimensionName, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);
}

class $$AbilityValuesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AbilityValuesTable,
    AbilityValue,
    $$AbilityValuesTableFilterComposer,
    $$AbilityValuesTableOrderingComposer,
    $$AbilityValuesTableAnnotationComposer,
    $$AbilityValuesTableCreateCompanionBuilder,
    $$AbilityValuesTableUpdateCompanionBuilder,
    (
      AbilityValue,
      BaseReferences<_$AppDatabase, $AbilityValuesTable, AbilityValue>
    ),
    AbilityValue,
    PrefetchHooks Function()> {
  $$AbilityValuesTableTableManager(_$AppDatabase db, $AbilityValuesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbilityValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbilityValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbilityValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> dimensionName = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AbilityValuesCompanion(
            id: id,
            ocId: ocId,
            dimensionName: dimensionName,
            score: score,
            remark: remark,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String dimensionName,
            required int score,
            Value<String?> remark = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AbilityValuesCompanion.insert(
            id: id,
            ocId: ocId,
            dimensionName: dimensionName,
            score: score,
            remark: remark,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AbilityValuesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AbilityValuesTable,
    AbilityValue,
    $$AbilityValuesTableFilterComposer,
    $$AbilityValuesTableOrderingComposer,
    $$AbilityValuesTableAnnotationComposer,
    $$AbilityValuesTableCreateCompanionBuilder,
    $$AbilityValuesTableUpdateCompanionBuilder,
    (
      AbilityValue,
      BaseReferences<_$AppDatabase, $AbilityValuesTable, AbilityValue>
    ),
    AbilityValue,
    PrefetchHooks Function()>;
typedef $$CoreValuesTableCreateCompanionBuilder = CoreValuesCompanion Function({
  required String id,
  required String ocId,
  required String value,
  required int sort,
  Value<int> rowid,
});
typedef $$CoreValuesTableUpdateCompanionBuilder = CoreValuesCompanion Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> value,
  Value<int> sort,
  Value<int> rowid,
});

class $$CoreValuesTableFilterComposer
    extends Composer<_$AppDatabase, $CoreValuesTable> {
  $$CoreValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$CoreValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoreValuesTable> {
  $$CoreValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$CoreValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoreValuesTable> {
  $$CoreValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$CoreValuesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CoreValuesTable,
    CoreValue,
    $$CoreValuesTableFilterComposer,
    $$CoreValuesTableOrderingComposer,
    $$CoreValuesTableAnnotationComposer,
    $$CoreValuesTableCreateCompanionBuilder,
    $$CoreValuesTableUpdateCompanionBuilder,
    (CoreValue, BaseReferences<_$AppDatabase, $CoreValuesTable, CoreValue>),
    CoreValue,
    PrefetchHooks Function()> {
  $$CoreValuesTableTableManager(_$AppDatabase db, $CoreValuesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoreValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoreValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoreValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CoreValuesCompanion(
            id: id,
            ocId: ocId,
            value: value,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String value,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              CoreValuesCompanion.insert(
            id: id,
            ocId: ocId,
            value: value,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CoreValuesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CoreValuesTable,
    CoreValue,
    $$CoreValuesTableFilterComposer,
    $$CoreValuesTableOrderingComposer,
    $$CoreValuesTableAnnotationComposer,
    $$CoreValuesTableCreateCompanionBuilder,
    $$CoreValuesTableUpdateCompanionBuilder,
    (CoreValue, BaseReferences<_$AppDatabase, $CoreValuesTable, CoreValue>),
    CoreValue,
    PrefetchHooks Function()>;
typedef $$TraitsTableCreateCompanionBuilder = TraitsCompanion Function({
  required String id,
  required String ocId,
  required String kind,
  required String value,
  required int sort,
  Value<int> rowid,
});
typedef $$TraitsTableUpdateCompanionBuilder = TraitsCompanion Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> kind,
  Value<String> value,
  Value<int> sort,
  Value<int> rowid,
});

class $$TraitsTableFilterComposer
    extends Composer<_$AppDatabase, $TraitsTable> {
  $$TraitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$TraitsTableOrderingComposer
    extends Composer<_$AppDatabase, $TraitsTable> {
  $$TraitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$TraitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TraitsTable> {
  $$TraitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$TraitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TraitsTable,
    Trait,
    $$TraitsTableFilterComposer,
    $$TraitsTableOrderingComposer,
    $$TraitsTableAnnotationComposer,
    $$TraitsTableCreateCompanionBuilder,
    $$TraitsTableUpdateCompanionBuilder,
    (Trait, BaseReferences<_$AppDatabase, $TraitsTable, Trait>),
    Trait,
    PrefetchHooks Function()> {
  $$TraitsTableTableManager(_$AppDatabase db, $TraitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TraitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TraitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TraitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TraitsCompanion(
            id: id,
            ocId: ocId,
            kind: kind,
            value: value,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String kind,
            required String value,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              TraitsCompanion.insert(
            id: id,
            ocId: ocId,
            kind: kind,
            value: value,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TraitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TraitsTable,
    Trait,
    $$TraitsTableFilterComposer,
    $$TraitsTableOrderingComposer,
    $$TraitsTableAnnotationComposer,
    $$TraitsTableCreateCompanionBuilder,
    $$TraitsTableUpdateCompanionBuilder,
    (Trait, BaseReferences<_$AppDatabase, $TraitsTable, Trait>),
    Trait,
    PrefetchHooks Function()>;
typedef $$CatchphrasesTableCreateCompanionBuilder = CatchphrasesCompanion
    Function({
  required String id,
  required String ocId,
  required String phrase,
  required int sort,
  Value<int> rowid,
});
typedef $$CatchphrasesTableUpdateCompanionBuilder = CatchphrasesCompanion
    Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> phrase,
  Value<int> sort,
  Value<int> rowid,
});

class $$CatchphrasesTableFilterComposer
    extends Composer<_$AppDatabase, $CatchphrasesTable> {
  $$CatchphrasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phrase => $composableBuilder(
      column: $table.phrase, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$CatchphrasesTableOrderingComposer
    extends Composer<_$AppDatabase, $CatchphrasesTable> {
  $$CatchphrasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phrase => $composableBuilder(
      column: $table.phrase, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$CatchphrasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatchphrasesTable> {
  $$CatchphrasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get phrase =>
      $composableBuilder(column: $table.phrase, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$CatchphrasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CatchphrasesTable,
    Catchphrase,
    $$CatchphrasesTableFilterComposer,
    $$CatchphrasesTableOrderingComposer,
    $$CatchphrasesTableAnnotationComposer,
    $$CatchphrasesTableCreateCompanionBuilder,
    $$CatchphrasesTableUpdateCompanionBuilder,
    (
      Catchphrase,
      BaseReferences<_$AppDatabase, $CatchphrasesTable, Catchphrase>
    ),
    Catchphrase,
    PrefetchHooks Function()> {
  $$CatchphrasesTableTableManager(_$AppDatabase db, $CatchphrasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatchphrasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatchphrasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatchphrasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> phrase = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatchphrasesCompanion(
            id: id,
            ocId: ocId,
            phrase: phrase,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String phrase,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              CatchphrasesCompanion.insert(
            id: id,
            ocId: ocId,
            phrase: phrase,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CatchphrasesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CatchphrasesTable,
    Catchphrase,
    $$CatchphrasesTableFilterComposer,
    $$CatchphrasesTableOrderingComposer,
    $$CatchphrasesTableAnnotationComposer,
    $$CatchphrasesTableCreateCompanionBuilder,
    $$CatchphrasesTableUpdateCompanionBuilder,
    (
      Catchphrase,
      BaseReferences<_$AppDatabase, $CatchphrasesTable, Catchphrase>
    ),
    Catchphrase,
    PrefetchHooks Function()>;
typedef $$ExtensionFieldsTableCreateCompanionBuilder = ExtensionFieldsCompanion
    Function({
  required String id,
  required String ocId,
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$ExtensionFieldsTableUpdateCompanionBuilder = ExtensionFieldsCompanion
    Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$ExtensionFieldsTableFilterComposer
    extends Composer<_$AppDatabase, $ExtensionFieldsTable> {
  $$ExtensionFieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$ExtensionFieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExtensionFieldsTable> {
  $$ExtensionFieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$ExtensionFieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExtensionFieldsTable> {
  $$ExtensionFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$ExtensionFieldsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExtensionFieldsTable,
    ExtensionField,
    $$ExtensionFieldsTableFilterComposer,
    $$ExtensionFieldsTableOrderingComposer,
    $$ExtensionFieldsTableAnnotationComposer,
    $$ExtensionFieldsTableCreateCompanionBuilder,
    $$ExtensionFieldsTableUpdateCompanionBuilder,
    (
      ExtensionField,
      BaseReferences<_$AppDatabase, $ExtensionFieldsTable, ExtensionField>
    ),
    ExtensionField,
    PrefetchHooks Function()> {
  $$ExtensionFieldsTableTableManager(
      _$AppDatabase db, $ExtensionFieldsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExtensionFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExtensionFieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExtensionFieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExtensionFieldsCompanion(
            id: id,
            ocId: ocId,
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExtensionFieldsCompanion.insert(
            id: id,
            ocId: ocId,
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExtensionFieldsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExtensionFieldsTable,
    ExtensionField,
    $$ExtensionFieldsTableFilterComposer,
    $$ExtensionFieldsTableOrderingComposer,
    $$ExtensionFieldsTableAnnotationComposer,
    $$ExtensionFieldsTableCreateCompanionBuilder,
    $$ExtensionFieldsTableUpdateCompanionBuilder,
    (
      ExtensionField,
      BaseReferences<_$AppDatabase, $ExtensionFieldsTable, ExtensionField>
    ),
    ExtensionField,
    PrefetchHooks Function()>;
typedef $$TimelineEventsTableCreateCompanionBuilder = TimelineEventsCompanion
    Function({
  required String id,
  required String ocId,
  required String timeText,
  required String title,
  required String description,
  required String imagesJson,
  Value<bool> starred,
  required int sort,
  Value<int> rowid,
});
typedef $$TimelineEventsTableUpdateCompanionBuilder = TimelineEventsCompanion
    Function({
  Value<String> id,
  Value<String> ocId,
  Value<String> timeText,
  Value<String> title,
  Value<String> description,
  Value<String> imagesJson,
  Value<bool> starred,
  Value<int> sort,
  Value<int> rowid,
});

class $$TimelineEventsTableFilterComposer
    extends Composer<_$AppDatabase, $TimelineEventsTable> {
  $$TimelineEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeText => $composableBuilder(
      column: $table.timeText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$TimelineEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimelineEventsTable> {
  $$TimelineEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ocId => $composableBuilder(
      column: $table.ocId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeText => $composableBuilder(
      column: $table.timeText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$TimelineEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimelineEventsTable> {
  $$TimelineEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ocId =>
      $composableBuilder(column: $table.ocId, builder: (column) => column);

  GeneratedColumn<String> get timeText =>
      $composableBuilder(column: $table.timeText, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => column);

  GeneratedColumn<bool> get starred =>
      $composableBuilder(column: $table.starred, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$TimelineEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimelineEventsTable,
    TimelineEvent,
    $$TimelineEventsTableFilterComposer,
    $$TimelineEventsTableOrderingComposer,
    $$TimelineEventsTableAnnotationComposer,
    $$TimelineEventsTableCreateCompanionBuilder,
    $$TimelineEventsTableUpdateCompanionBuilder,
    (
      TimelineEvent,
      BaseReferences<_$AppDatabase, $TimelineEventsTable, TimelineEvent>
    ),
    TimelineEvent,
    PrefetchHooks Function()> {
  $$TimelineEventsTableTableManager(
      _$AppDatabase db, $TimelineEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimelineEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimelineEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimelineEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ocId = const Value.absent(),
            Value<String> timeText = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> imagesJson = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimelineEventsCompanion(
            id: id,
            ocId: ocId,
            timeText: timeText,
            title: title,
            description: description,
            imagesJson: imagesJson,
            starred: starred,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ocId,
            required String timeText,
            required String title,
            required String description,
            required String imagesJson,
            Value<bool> starred = const Value.absent(),
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              TimelineEventsCompanion.insert(
            id: id,
            ocId: ocId,
            timeText: timeText,
            title: title,
            description: description,
            imagesJson: imagesJson,
            starred: starred,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimelineEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TimelineEventsTable,
    TimelineEvent,
    $$TimelineEventsTableFilterComposer,
    $$TimelineEventsTableOrderingComposer,
    $$TimelineEventsTableAnnotationComposer,
    $$TimelineEventsTableCreateCompanionBuilder,
    $$TimelineEventsTableUpdateCompanionBuilder,
    (
      TimelineEvent,
      BaseReferences<_$AppDatabase, $TimelineEventsTable, TimelineEvent>
    ),
    TimelineEvent,
    PrefetchHooks Function()>;
typedef $$RelationshipsTableCreateCompanionBuilder = RelationshipsCompanion
    Function({
  required String id,
  required String workId,
  required String sourceOcId,
  required String targetOcId,
  required String label,
  required String strength,
  required int direction,
  required String description,
  Value<int> rowid,
});
typedef $$RelationshipsTableUpdateCompanionBuilder = RelationshipsCompanion
    Function({
  Value<String> id,
  Value<String> workId,
  Value<String> sourceOcId,
  Value<String> targetOcId,
  Value<String> label,
  Value<String> strength,
  Value<int> direction,
  Value<String> description,
  Value<int> rowid,
});

class $$RelationshipsTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceOcId => $composableBuilder(
      column: $table.sourceOcId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetOcId => $composableBuilder(
      column: $table.targetOcId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get strength => $composableBuilder(
      column: $table.strength, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$RelationshipsTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceOcId => $composableBuilder(
      column: $table.sourceOcId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetOcId => $composableBuilder(
      column: $table.targetOcId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get strength => $composableBuilder(
      column: $table.strength, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$RelationshipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get sourceOcId => $composableBuilder(
      column: $table.sourceOcId, builder: (column) => column);

  GeneratedColumn<String> get targetOcId => $composableBuilder(
      column: $table.targetOcId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get strength =>
      $composableBuilder(column: $table.strength, builder: (column) => column);

  GeneratedColumn<int> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$RelationshipsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    Relationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (
      Relationship,
      BaseReferences<_$AppDatabase, $RelationshipsTable, Relationship>
    ),
    Relationship,
    PrefetchHooks Function()> {
  $$RelationshipsTableTableManager(_$AppDatabase db, $RelationshipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> sourceOcId = const Value.absent(),
            Value<String> targetOcId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> strength = const Value.absent(),
            Value<int> direction = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion(
            id: id,
            workId: workId,
            sourceOcId: sourceOcId,
            targetOcId: targetOcId,
            label: label,
            strength: strength,
            direction: direction,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String sourceOcId,
            required String targetOcId,
            required String label,
            required String strength,
            required int direction,
            required String description,
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion.insert(
            id: id,
            workId: workId,
            sourceOcId: sourceOcId,
            targetOcId: targetOcId,
            label: label,
            strength: strength,
            direction: direction,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RelationshipsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    Relationship,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (
      Relationship,
      BaseReferences<_$AppDatabase, $RelationshipsTable, Relationship>
    ),
    Relationship,
    PrefetchHooks Function()>;
typedef $$RelationStagesTableCreateCompanionBuilder = RelationStagesCompanion
    Function({
  required String id,
  required String relationshipId,
  required String stageName,
  required String timeText,
  required String description,
  required String imagesJson,
  required int sort,
  Value<int> rowid,
});
typedef $$RelationStagesTableUpdateCompanionBuilder = RelationStagesCompanion
    Function({
  Value<String> id,
  Value<String> relationshipId,
  Value<String> stageName,
  Value<String> timeText,
  Value<String> description,
  Value<String> imagesJson,
  Value<int> sort,
  Value<int> rowid,
});

class $$RelationStagesTableFilterComposer
    extends Composer<_$AppDatabase, $RelationStagesTable> {
  $$RelationStagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationshipId => $composableBuilder(
      column: $table.relationshipId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stageName => $composableBuilder(
      column: $table.stageName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeText => $composableBuilder(
      column: $table.timeText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$RelationStagesTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationStagesTable> {
  $$RelationStagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationshipId => $composableBuilder(
      column: $table.relationshipId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stageName => $composableBuilder(
      column: $table.stageName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeText => $composableBuilder(
      column: $table.timeText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$RelationStagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationStagesTable> {
  $$RelationStagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationshipId => $composableBuilder(
      column: $table.relationshipId, builder: (column) => column);

  GeneratedColumn<String> get stageName =>
      $composableBuilder(column: $table.stageName, builder: (column) => column);

  GeneratedColumn<String> get timeText =>
      $composableBuilder(column: $table.timeText, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$RelationStagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationStagesTable,
    RelationStage,
    $$RelationStagesTableFilterComposer,
    $$RelationStagesTableOrderingComposer,
    $$RelationStagesTableAnnotationComposer,
    $$RelationStagesTableCreateCompanionBuilder,
    $$RelationStagesTableUpdateCompanionBuilder,
    (
      RelationStage,
      BaseReferences<_$AppDatabase, $RelationStagesTable, RelationStage>
    ),
    RelationStage,
    PrefetchHooks Function()> {
  $$RelationStagesTableTableManager(
      _$AppDatabase db, $RelationStagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationStagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationStagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationStagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> relationshipId = const Value.absent(),
            Value<String> stageName = const Value.absent(),
            Value<String> timeText = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> imagesJson = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationStagesCompanion(
            id: id,
            relationshipId: relationshipId,
            stageName: stageName,
            timeText: timeText,
            description: description,
            imagesJson: imagesJson,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String relationshipId,
            required String stageName,
            required String timeText,
            required String description,
            required String imagesJson,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationStagesCompanion.insert(
            id: id,
            relationshipId: relationshipId,
            stageName: stageName,
            timeText: timeText,
            description: description,
            imagesJson: imagesJson,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RelationStagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RelationStagesTable,
    RelationStage,
    $$RelationStagesTableFilterComposer,
    $$RelationStagesTableOrderingComposer,
    $$RelationStagesTableAnnotationComposer,
    $$RelationStagesTableCreateCompanionBuilder,
    $$RelationStagesTableUpdateCompanionBuilder,
    (
      RelationStage,
      BaseReferences<_$AppDatabase, $RelationStagesTable, RelationStage>
    ),
    RelationStage,
    PrefetchHooks Function()>;
typedef $$WorldMapsTableCreateCompanionBuilder = WorldMapsCompanion Function({
  required String id,
  required String workId,
  required String name,
  required String imagePath,
  Value<int> rowid,
});
typedef $$WorldMapsTableUpdateCompanionBuilder = WorldMapsCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String> name,
  Value<String> imagePath,
  Value<int> rowid,
});

class $$WorldMapsTableFilterComposer
    extends Composer<_$AppDatabase, $WorldMapsTable> {
  $$WorldMapsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));
}

class $$WorldMapsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorldMapsTable> {
  $$WorldMapsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));
}

class $$WorldMapsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorldMapsTable> {
  $$WorldMapsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);
}

class $$WorldMapsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorldMapsTable,
    WorldMap,
    $$WorldMapsTableFilterComposer,
    $$WorldMapsTableOrderingComposer,
    $$WorldMapsTableAnnotationComposer,
    $$WorldMapsTableCreateCompanionBuilder,
    $$WorldMapsTableUpdateCompanionBuilder,
    (WorldMap, BaseReferences<_$AppDatabase, $WorldMapsTable, WorldMap>),
    WorldMap,
    PrefetchHooks Function()> {
  $$WorldMapsTableTableManager(_$AppDatabase db, $WorldMapsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorldMapsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorldMapsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorldMapsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorldMapsCompanion(
            id: id,
            workId: workId,
            name: name,
            imagePath: imagePath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String name,
            required String imagePath,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorldMapsCompanion.insert(
            id: id,
            workId: workId,
            name: name,
            imagePath: imagePath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorldMapsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorldMapsTable,
    WorldMap,
    $$WorldMapsTableFilterComposer,
    $$WorldMapsTableOrderingComposer,
    $$WorldMapsTableAnnotationComposer,
    $$WorldMapsTableCreateCompanionBuilder,
    $$WorldMapsTableUpdateCompanionBuilder,
    (WorldMap, BaseReferences<_$AppDatabase, $WorldMapsTable, WorldMap>),
    WorldMap,
    PrefetchHooks Function()>;
typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  required String id,
  required String workId,
  Value<String?> parentId,
  required String name,
  required String description,
  required String type,
  required String imagesJson,
  Value<String?> mapId,
  Value<double?> x,
  Value<double?> y,
  Value<int> rowid,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<String> id,
  Value<String> workId,
  Value<String?> parentId,
  Value<String> name,
  Value<String> description,
  Value<String> type,
  Value<String> imagesJson,
  Value<String?> mapId,
  Value<double?> x,
  Value<double?> y,
  Value<int> rowid,
});

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mapId => $composableBuilder(
      column: $table.mapId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mapId => $composableBuilder(
      column: $table.mapId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get imagesJson => $composableBuilder(
      column: $table.imagesJson, builder: (column) => column);

  GeneratedColumn<String> get mapId =>
      $composableBuilder(column: $table.mapId, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);
}

class $$LocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
    Location,
    PrefetchHooks Function()> {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> imagesJson = const Value.absent(),
            Value<String?> mapId = const Value.absent(),
            Value<double?> x = const Value.absent(),
            Value<double?> y = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion(
            id: id,
            workId: workId,
            parentId: parentId,
            name: name,
            description: description,
            type: type,
            imagesJson: imagesJson,
            mapId: mapId,
            x: x,
            y: y,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            Value<String?> parentId = const Value.absent(),
            required String name,
            required String description,
            required String type,
            required String imagesJson,
            Value<String?> mapId = const Value.absent(),
            Value<double?> x = const Value.absent(),
            Value<double?> y = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion.insert(
            id: id,
            workId: workId,
            parentId: parentId,
            name: name,
            description: description,
            type: type,
            imagesJson: imagesJson,
            mapId: mapId,
            x: x,
            y: y,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
    Location,
    PrefetchHooks Function()>;
typedef $$RuleEntriesTableCreateCompanionBuilder = RuleEntriesCompanion
    Function({
  required String id,
  required String workId,
  required String section,
  required String title,
  required String body,
  Value<int> rowid,
});
typedef $$RuleEntriesTableUpdateCompanionBuilder = RuleEntriesCompanion
    Function({
  Value<String> id,
  Value<String> workId,
  Value<String> section,
  Value<String> title,
  Value<String> body,
  Value<int> rowid,
});

class $$RuleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RuleEntriesTable> {
  $$RuleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));
}

class $$RuleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleEntriesTable> {
  $$RuleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));
}

class $$RuleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleEntriesTable> {
  $$RuleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);
}

class $$RuleEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RuleEntriesTable,
    RuleEntry,
    $$RuleEntriesTableFilterComposer,
    $$RuleEntriesTableOrderingComposer,
    $$RuleEntriesTableAnnotationComposer,
    $$RuleEntriesTableCreateCompanionBuilder,
    $$RuleEntriesTableUpdateCompanionBuilder,
    (RuleEntry, BaseReferences<_$AppDatabase, $RuleEntriesTable, RuleEntry>),
    RuleEntry,
    PrefetchHooks Function()> {
  $$RuleEntriesTableTableManager(_$AppDatabase db, $RuleEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RuleEntriesCompanion(
            id: id,
            workId: workId,
            section: section,
            title: title,
            body: body,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String section,
            required String title,
            required String body,
            Value<int> rowid = const Value.absent(),
          }) =>
              RuleEntriesCompanion.insert(
            id: id,
            workId: workId,
            section: section,
            title: title,
            body: body,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RuleEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RuleEntriesTable,
    RuleEntry,
    $$RuleEntriesTableFilterComposer,
    $$RuleEntriesTableOrderingComposer,
    $$RuleEntriesTableAnnotationComposer,
    $$RuleEntriesTableCreateCompanionBuilder,
    $$RuleEntriesTableUpdateCompanionBuilder,
    (RuleEntry, BaseReferences<_$AppDatabase, $RuleEntriesTable, RuleEntry>),
    RuleEntry,
    PrefetchHooks Function()>;
typedef $$RuleTagsTableCreateCompanionBuilder = RuleTagsCompanion Function({
  required String ruleId,
  required String tagId,
  Value<int> rowid,
});
typedef $$RuleTagsTableUpdateCompanionBuilder = RuleTagsCompanion Function({
  Value<String> ruleId,
  Value<String> tagId,
  Value<int> rowid,
});

class $$RuleTagsTableFilterComposer
    extends Composer<_$AppDatabase, $RuleTagsTable> {
  $$RuleTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ruleId => $composableBuilder(
      column: $table.ruleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));
}

class $$RuleTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleTagsTable> {
  $$RuleTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ruleId => $composableBuilder(
      column: $table.ruleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));
}

class $$RuleTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleTagsTable> {
  $$RuleTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);

  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$RuleTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RuleTagsTable,
    RuleTag,
    $$RuleTagsTableFilterComposer,
    $$RuleTagsTableOrderingComposer,
    $$RuleTagsTableAnnotationComposer,
    $$RuleTagsTableCreateCompanionBuilder,
    $$RuleTagsTableUpdateCompanionBuilder,
    (RuleTag, BaseReferences<_$AppDatabase, $RuleTagsTable, RuleTag>),
    RuleTag,
    PrefetchHooks Function()> {
  $$RuleTagsTableTableManager(_$AppDatabase db, $RuleTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> ruleId = const Value.absent(),
            Value<String> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RuleTagsCompanion(
            ruleId: ruleId,
            tagId: tagId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String ruleId,
            required String tagId,
            Value<int> rowid = const Value.absent(),
          }) =>
              RuleTagsCompanion.insert(
            ruleId: ruleId,
            tagId: tagId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RuleTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RuleTagsTable,
    RuleTag,
    $$RuleTagsTableFilterComposer,
    $$RuleTagsTableOrderingComposer,
    $$RuleTagsTableAnnotationComposer,
    $$RuleTagsTableCreateCompanionBuilder,
    $$RuleTagsTableUpdateCompanionBuilder,
    (RuleTag, BaseReferences<_$AppDatabase, $RuleTagsTable, RuleTag>),
    RuleTag,
    PrefetchHooks Function()>;
typedef $$ChecklistItemsTableCreateCompanionBuilder = ChecklistItemsCompanion
    Function({
  required String id,
  required String workId,
  required String category,
  required String content,
  required String status,
  required String remark,
  required int sort,
  Value<int> rowid,
});
typedef $$ChecklistItemsTableUpdateCompanionBuilder = ChecklistItemsCompanion
    Function({
  Value<String> id,
  Value<String> workId,
  Value<String> category,
  Value<String> content,
  Value<String> status,
  Value<String> remark,
  Value<int> sort,
  Value<int> rowid,
});

class $$ChecklistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnFilters(column));
}

class $$ChecklistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sort => $composableBuilder(
      column: $table.sort, builder: (column) => ColumnOrderings(column));
}

class $$ChecklistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<int> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);
}

class $$ChecklistItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (
      ChecklistItem,
      BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItem>
    ),
    ChecklistItem,
    PrefetchHooks Function()> {
  $$ChecklistItemsTableTableManager(
      _$AppDatabase db, $ChecklistItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> remark = const Value.absent(),
            Value<int> sort = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChecklistItemsCompanion(
            id: id,
            workId: workId,
            category: category,
            content: content,
            status: status,
            remark: remark,
            sort: sort,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String category,
            required String content,
            required String status,
            required String remark,
            required int sort,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChecklistItemsCompanion.insert(
            id: id,
            workId: workId,
            category: category,
            content: content,
            status: status,
            remark: remark,
            sort: sort,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChecklistItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChecklistItemsTable,
    ChecklistItem,
    $$ChecklistItemsTableFilterComposer,
    $$ChecklistItemsTableOrderingComposer,
    $$ChecklistItemsTableAnnotationComposer,
    $$ChecklistItemsTableCreateCompanionBuilder,
    $$ChecklistItemsTableUpdateCompanionBuilder,
    (
      ChecklistItem,
      BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItem>
    ),
    ChecklistItem,
    PrefetchHooks Function()>;
typedef $$InspirationsTableCreateCompanionBuilder = InspirationsCompanion
    Function({
  required String id,
  required String workId,
  required String type,
  required String content,
  required String transcript,
  required String audioPath,
  required String tagsJson,
  required String status,
  required String refsJson,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$InspirationsTableUpdateCompanionBuilder = InspirationsCompanion
    Function({
  Value<String> id,
  Value<String> workId,
  Value<String> type,
  Value<String> content,
  Value<String> transcript,
  Value<String> audioPath,
  Value<String> tagsJson,
  Value<String> status,
  Value<String> refsJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$InspirationsTableFilterComposer
    extends Composer<_$AppDatabase, $InspirationsTable> {
  $$InspirationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transcript => $composableBuilder(
      column: $table.transcript, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refsJson => $composableBuilder(
      column: $table.refsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$InspirationsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspirationsTable> {
  $$InspirationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workId => $composableBuilder(
      column: $table.workId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transcript => $composableBuilder(
      column: $table.transcript, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refsJson => $composableBuilder(
      column: $table.refsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$InspirationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspirationsTable> {
  $$InspirationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workId =>
      $composableBuilder(column: $table.workId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get transcript => $composableBuilder(
      column: $table.transcript, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get refsJson =>
      $composableBuilder(column: $table.refsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InspirationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InspirationsTable,
    Inspiration,
    $$InspirationsTableFilterComposer,
    $$InspirationsTableOrderingComposer,
    $$InspirationsTableAnnotationComposer,
    $$InspirationsTableCreateCompanionBuilder,
    $$InspirationsTableUpdateCompanionBuilder,
    (
      Inspiration,
      BaseReferences<_$AppDatabase, $InspirationsTable, Inspiration>
    ),
    Inspiration,
    PrefetchHooks Function()> {
  $$InspirationsTableTableManager(_$AppDatabase db, $InspirationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspirationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspirationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspirationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> transcript = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> refsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InspirationsCompanion(
            id: id,
            workId: workId,
            type: type,
            content: content,
            transcript: transcript,
            audioPath: audioPath,
            tagsJson: tagsJson,
            status: status,
            refsJson: refsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workId,
            required String type,
            required String content,
            required String transcript,
            required String audioPath,
            required String tagsJson,
            required String status,
            required String refsJson,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              InspirationsCompanion.insert(
            id: id,
            workId: workId,
            type: type,
            content: content,
            transcript: transcript,
            audioPath: audioPath,
            tagsJson: tagsJson,
            status: status,
            refsJson: refsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InspirationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InspirationsTable,
    Inspiration,
    $$InspirationsTableFilterComposer,
    $$InspirationsTableOrderingComposer,
    $$InspirationsTableAnnotationComposer,
    $$InspirationsTableCreateCompanionBuilder,
    $$InspirationsTableUpdateCompanionBuilder,
    (
      Inspiration,
      BaseReferences<_$AppDatabase, $InspirationsTable, Inspiration>
    ),
    Inspiration,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorksTableTableManager get works =>
      $$WorksTableTableManager(_db, _db.works);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$DimensionTemplatesTableTableManager get dimensionTemplates =>
      $$DimensionTemplatesTableTableManager(_db, _db.dimensionTemplates);
  $$OcsTableTableManager get ocs => $$OcsTableTableManager(_db, _db.ocs);
  $$OcTagsTableTableManager get ocTags =>
      $$OcTagsTableTableManager(_db, _db.ocTags);
  $$AppearanceItemsTableTableManager get appearanceItems =>
      $$AppearanceItemsTableTableManager(_db, _db.appearanceItems);
  $$AbilityValuesTableTableManager get abilityValues =>
      $$AbilityValuesTableTableManager(_db, _db.abilityValues);
  $$CoreValuesTableTableManager get coreValues =>
      $$CoreValuesTableTableManager(_db, _db.coreValues);
  $$TraitsTableTableManager get traits =>
      $$TraitsTableTableManager(_db, _db.traits);
  $$CatchphrasesTableTableManager get catchphrases =>
      $$CatchphrasesTableTableManager(_db, _db.catchphrases);
  $$ExtensionFieldsTableTableManager get extensionFields =>
      $$ExtensionFieldsTableTableManager(_db, _db.extensionFields);
  $$TimelineEventsTableTableManager get timelineEvents =>
      $$TimelineEventsTableTableManager(_db, _db.timelineEvents);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$RelationStagesTableTableManager get relationStages =>
      $$RelationStagesTableTableManager(_db, _db.relationStages);
  $$WorldMapsTableTableManager get worldMaps =>
      $$WorldMapsTableTableManager(_db, _db.worldMaps);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$RuleEntriesTableTableManager get ruleEntries =>
      $$RuleEntriesTableTableManager(_db, _db.ruleEntries);
  $$RuleTagsTableTableManager get ruleTags =>
      $$RuleTagsTableTableManager(_db, _db.ruleTags);
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
  $$InspirationsTableTableManager get inspirations =>
      $$InspirationsTableTableManager(_db, _db.inspirations);
}
