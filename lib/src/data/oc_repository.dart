import 'package:drift/drift.dart' hide isNull, Column;

import '../core/utils.dart';
import 'database.dart';

/// 删除 OC 及其全部子数据（含参与的关系连线）
Future<void> deleteOc(AppDatabase db, String ocId) async {
  await db.deleteWhere(db.ocTags, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.appearanceItems, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.abilityValues, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.coreValues, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.traits, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.catchphrases, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.extensionFields, (t) => t.ocId.equals(ocId));
  await db.deleteWhere(db.timelineEvents, (t) => t.ocId.equals(ocId));
  final rels = await (db.select(db.relationships)
        ..where((t) => t.sourceOcId.equals(ocId) | t.targetOcId.equals(ocId)))
      .get();
  for (final r in rels) {
    await db
        .deleteWhere(db.relationStages, (t) => t.relationshipId.equals(r.id));
  }
  await db.deleteWhere(db.relationships,
      (t) => t.sourceOcId.equals(ocId) | t.targetOcId.equals(ocId));
  await db.deleteWhere(db.ocs, (t) => t.id.equals(ocId));
}

/// 复制 OC 及其子数据，返回新 OC id
Future<String> copyOc(AppDatabase db, String ocId) async {
  final oc =
      await (db.select(db.ocs)..where((t) => t.id.equals(ocId))).getSingle();
  final newOcId = newId();
  final now = DateTime.now();
  await db.into(db.ocs).insert(OcsCompanion.insert(
        id: newOcId,
        workId: oc.workId,
        name: '${oc.name}（副本）',
        age: Value(oc.age),
        gender: Value(oc.gender),
        birthday: Value(oc.birthday),
        constellation: Value(oc.constellation),
        avatarPath: Value(oc.avatarPath),
        mbti: Value(oc.mbti),
        familyBackground: Value(oc.familyBackground),
        coreDrive: Value(oc.coreDrive),
        goalMotivation: Value(oc.goalMotivation),
        createdAt: now,
        updatedAt: now,
      ));

  final tagLinks =
      await (db.select(db.ocTags)..where((t) => t.ocId.equals(ocId))).get();
  for (final t in tagLinks) {
    await db
        .into(db.ocTags)
        .insert(OcTagsCompanion.insert(ocId: newOcId, tagId: t.tagId));
  }

  final apps = await (db.select(db.appearanceItems)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final a in apps) {
    await db.into(db.appearanceItems).insert(AppearanceItemsCompanion.insert(
          id: newId(),
          ocId: newOcId,
          section: a.section,
          richText: a.richText,
          imagesJson: a.imagesJson,
          sort: a.sort,
        ));
  }

  final abilities = await (db.select(db.abilityValues)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final a in abilities) {
    await db.into(db.abilityValues).insert(AbilityValuesCompanion.insert(
          id: newId(),
          ocId: newOcId,
          dimensionName: a.dimensionName,
          score: a.score,
          remark: Value(a.remark),
        ));
  }

  final coreValues = await (db.select(db.coreValues)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final c in coreValues) {
    await db.into(db.coreValues).insert(CoreValuesCompanion.insert(
        id: newId(), ocId: newOcId, value: c.value, sort: c.sort));
  }

  final traits =
      await (db.select(db.traits)..where((t) => t.ocId.equals(ocId))).get();
  for (final t in traits) {
    await db.into(db.traits).insert(TraitsCompanion.insert(
        id: newId(), ocId: newOcId, kind: t.kind, value: t.value, sort: t.sort));
  }

  final catchphrases = await (db.select(db.catchphrases)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final c in catchphrases) {
    await db.into(db.catchphrases).insert(CatchphrasesCompanion.insert(
        id: newId(), ocId: newOcId, phrase: c.phrase, sort: c.sort));
  }

  final ext = await (db.select(db.extensionFields)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final e in ext) {
    await db.into(db.extensionFields).insert(ExtensionFieldsCompanion.insert(
        id: newId(), ocId: newOcId, key: e.key, value: e.value));
  }

  final timeline = await (db.select(db.timelineEvents)
        ..where((t) => t.ocId.equals(ocId)))
      .get();
  for (final e in timeline) {
    await db.into(db.timelineEvents).insert(TimelineEventsCompanion.insert(
          id: newId(),
          ocId: newOcId,
          timeText: e.timeText,
          title: e.title,
          description: e.description,
          imagesJson: e.imagesJson,
          starred: Value(e.starred),
          sort: e.sort,
        ));
  }

  return newOcId;
}
