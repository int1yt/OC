import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Works,
    Tags,
    DimensionTemplates,
    Ocs,
    OcTags,
    AppearanceItems,
    AbilityValues,
    CoreValues,
    Traits,
    Catchphrases,
    ExtensionFields,
    TimelineEvents,
    Relationships,
    RelationStages,
    WorldMaps,
    Locations,
    RuleEntries,
    RuleTags,
    ChecklistItems,
    Inspirations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'oc_studio'));

  @override
  int get schemaVersion => 1;
}

/// drift 无 `deleteWhere`，这里补一个便捷方法
extension DbDeleteWhere on GeneratedDatabase {
  Future<int> deleteWhere<T extends Table, D>(
    TableInfo<T, D> table,
    Expression<bool> Function(T tbl) predicate,
  ) =>
      (delete(table)..where(predicate)).go();
}
