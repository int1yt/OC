import 'package:drift/drift.dart';

/// 作品：顶层容器
class Works extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get coverPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 标签：作品级标签池
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get name => text()();
  IntColumn get colorValue => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 能力维度模板：作品级默认维度
class DimensionTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get name => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// OC
class Ocs extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get name => text()();
  TextColumn get age => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
  TextColumn get constellation => text().nullable()();
  TextColumn get avatarPath => text().nullable()();
  TextColumn get mbti => text().nullable()();
  TextColumn get familyBackground => text().withDefault(const Constant(''))();
  TextColumn get coreDrive => text().withDefault(const Constant(''))();
  TextColumn get goalMotivation => text().withDefault(const Constant(''))();
  RealColumn get posX => real().nullable()();
  RealColumn get posY => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// OC 标签关联（多对多）
class OcTags extends Table {
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get tagId => text().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {ocId, tagId};
}

/// 外貌条目：图文混排最小单元
class AppearanceItems extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get section => text()();
  TextColumn get richText => text()();
  /// JSON 数组：[{path, caption}]
  TextColumn get imagesJson => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 能力值：OC 实际维度 + 分值
class AbilityValues extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get dimensionName => text()();
  IntColumn get score => integer()();
  TextColumn get remark => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 核心价值观：有序
class CoreValues extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get value => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 优点/缺点：kind = strength | weakness
class Traits extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get kind => text()();
  TextColumn get value => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 口头禅
class Catchphrases extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get phrase => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 扩展字段（键值对）
class ExtensionFields extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 时间轴事件（人生转折点 = starred）
class TimelineEvents extends Table {
  TextColumn get id => text()();
  TextColumn get ocId => text().references(Ocs, #id)();
  TextColumn get timeText => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get imagesJson => text()();
  BoolColumn get starred => boolean().withDefault(const Constant(false))();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 关系连线：同作品内一对 OC 可多条
class Relationships extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get sourceOcId => text()();
  TextColumn get targetOcId => text()();
  TextColumn get label => text()();
  TextColumn get strength => text()();
  IntColumn get direction => integer()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 关系时间轴阶段
class RelationStages extends Table {
  TextColumn get id => text()();
  TextColumn get relationshipId => text().references(Relationships, #id)();
  TextColumn get stageName => text()();
  TextColumn get timeText => text()();
  TextColumn get description => text()();
  TextColumn get imagesJson => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 地图底图
class WorldMaps extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get name => text()();
  TextColumn get imagePath => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 地点：层级树 + 地图坐标 双视图
class Locations extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get parentId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get type => text()();
  TextColumn get imagesJson => text()();
  TextColumn get mapId => text().nullable()();
  RealColumn get x => real().nullable()();
  RealColumn get y => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 规则书条目
class RuleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get section => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 规则条目标签关联
class RuleTags extends Table {
  TextColumn get ruleId => text().references(RuleEntries, #id)();
  TextColumn get tagId => text().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {ruleId, tagId};
}

/// 自检清单项
class ChecklistItems extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  TextColumn get category => text()();
  TextColumn get content => text()();
  /// 通过 / 存疑 / 不适用
  TextColumn get status => text()();
  TextColumn get remark => text()();
  IntColumn get sort => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 灵感碎片（后置预留）
class Inspirations extends Table {
  TextColumn get id => text()();
  TextColumn get workId => text().references(Works, #id)();
  /// text | voice
  TextColumn get type => text()();
  TextColumn get content => text()();
  TextColumn get transcript => text()();
  TextColumn get audioPath => text()();
  TextColumn get tagsJson => text()();
  /// unused | used | archived
  TextColumn get status => text()();
  TextColumn get refsJson => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
