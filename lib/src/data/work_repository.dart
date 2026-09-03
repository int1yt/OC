import 'database.dart';
import 'oc_repository.dart';

/// 级联删除作品及其全部数据
Future<void> deleteWorkCascade(AppDatabase db, String workId) async {
  final rels = await (db.select(db.relationships)
        ..where((t) => t.workId.equals(workId)))
      .get();
  for (final r in rels) {
    await db
        .deleteWhere(db.relationStages, (t) => t.relationshipId.equals(r.id));
  }
  await db.deleteWhere(db.relationships, (t) => t.workId.equals(workId));

  final ocs =
      await (db.select(db.ocs)..where((t) => t.workId.equals(workId))).get();
  for (final oc in ocs) {
    await deleteOc(db, oc.id);
  }

  final rules = await (db.select(db.ruleEntries)
        ..where((t) => t.workId.equals(workId)))
      .get();
  for (final r in rules) {
    await db.deleteWhere(db.ruleTags, (t) => t.ruleId.equals(r.id));
  }
  await db.deleteWhere(db.ruleEntries, (t) => t.workId.equals(workId));

  await db.deleteWhere(db.tags, (t) => t.workId.equals(workId));
  await db
      .deleteWhere(db.dimensionTemplates, (t) => t.workId.equals(workId));
  await db.deleteWhere(db.worldMaps, (t) => t.workId.equals(workId));
  await db.deleteWhere(db.locations, (t) => t.workId.equals(workId));
  await db.deleteWhere(db.checklistItems, (t) => t.workId.equals(workId));
  await db.deleteWhere(db.inspirations, (t) => t.workId.equals(workId));
  await db.deleteWhere(db.works, (t) => t.id.equals(workId));
}
