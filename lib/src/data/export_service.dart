import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/utils.dart';
import 'database.dart';

String _iso(DateTime? d) => d?.toIso8601String() ?? '';
DateTime? _date(String? s) => (s == null || s.isEmpty) ? null : DateTime.tryParse(s);

/// 导出全部作品为 zip（data.json + images/），返回 zip 路径
Future<String> exportAll(AppDatabase db) async {
  Future<List<Map<String, dynamic>>> rows<T>(Future<List<T>> future,
      Map<String, dynamic> Function(T) toMap) async {
    final list = await future;
    return list.map(toMap).toList();
  }

  final data = <String, dynamic>{
    'version': 1,
    'exportedAt': DateTime.now().toIso8601String(),
    'works': await rows(
        db.select(db.works).get(), (w) => {
              'id': w.id, 'name': w.name, 'coverPath': w.coverPath,
              'createdAt': _iso(w.createdAt), 'updatedAt': _iso(w.updatedAt),
            }),
    'tags': await rows(db.select(db.tags).get(), (t) => {
          'id': t.id, 'workId': t.workId, 'name': t.name, 'colorValue': t.colorValue,
        }),
    'dimensionTemplates': await rows(db.select(db.dimensionTemplates).get(), (d) => {
          'id': d.id, 'workId': d.workId, 'name': d.name, 'sort': d.sort,
        }),
    'ocs': await rows(db.select(db.ocs).get(), (o) => {
          'id': o.id, 'workId': o.workId, 'name': o.name, 'age': o.age,
          'gender': o.gender, 'birthday': _iso(o.birthday),
          'constellation': o.constellation, 'avatarPath': o.avatarPath,
          'mbti': o.mbti, 'familyBackground': o.familyBackground,
          'coreDrive': o.coreDrive, 'goalMotivation': o.goalMotivation,
          'posX': o.posX, 'posY': o.posY,
          'createdAt': _iso(o.createdAt), 'updatedAt': _iso(o.updatedAt),
        }),
    'ocTags': await rows(db.select(db.ocTags).get(), (t) => {
          'ocId': t.ocId, 'tagId': t.tagId,
        }),
    'appearanceItems': await rows(db.select(db.appearanceItems).get(), (a) => {
          'id': a.id, 'ocId': a.ocId, 'section': a.section,
          'richText': a.richText, 'imagesJson': a.imagesJson, 'sort': a.sort,
        }),
    'abilityValues': await rows(db.select(db.abilityValues).get(), (a) => {
          'id': a.id, 'ocId': a.ocId, 'dimensionName': a.dimensionName,
          'score': a.score, 'remark': a.remark,
        }),
    'coreValues': await rows(db.select(db.coreValues).get(), (c) => {
          'id': c.id, 'ocId': c.ocId, 'value': c.value, 'sort': c.sort,
        }),
    'traits': await rows(db.select(db.traits).get(), (t) => {
          'id': t.id, 'ocId': t.ocId, 'kind': t.kind, 'value': t.value, 'sort': t.sort,
        }),
    'catchphrases': await rows(db.select(db.catchphrases).get(), (c) => {
          'id': c.id, 'ocId': c.ocId, 'phrase': c.phrase, 'sort': c.sort,
        }),
    'extensionFields': await rows(db.select(db.extensionFields).get(), (e) => {
          'id': e.id, 'ocId': e.ocId, 'key': e.key, 'value': e.value,
        }),
    'timelineEvents': await rows(db.select(db.timelineEvents).get(), (e) => {
          'id': e.id, 'ocId': e.ocId, 'timeText': e.timeText, 'title': e.title,
          'description': e.description, 'imagesJson': e.imagesJson,
          'starred': e.starred, 'sort': e.sort,
        }),
    'relationships': await rows(db.select(db.relationships).get(), (r) => {
          'id': r.id, 'workId': r.workId, 'sourceOcId': r.sourceOcId,
          'targetOcId': r.targetOcId, 'label': r.label, 'strength': r.strength,
          'direction': r.direction, 'description': r.description,
        }),
    'relationStages': await rows(db.select(db.relationStages).get(), (s) => {
          'id': s.id, 'relationshipId': s.relationshipId, 'stageName': s.stageName,
          'timeText': s.timeText, 'description': s.description,
          'imagesJson': s.imagesJson, 'sort': s.sort,
        }),
    'worldMaps': await rows(db.select(db.worldMaps).get(), (m) => {
          'id': m.id, 'workId': m.workId, 'name': m.name, 'imagePath': m.imagePath,
        }),
    'locations': await rows(db.select(db.locations).get(), (l) => {
          'id': l.id, 'workId': l.workId, 'parentId': l.parentId, 'name': l.name,
          'description': l.description, 'type': l.type, 'imagesJson': l.imagesJson,
          'mapId': l.mapId, 'x': l.x, 'y': l.y,
        }),
    'ruleEntries': await rows(db.select(db.ruleEntries).get(), (r) => {
          'id': r.id, 'workId': r.workId, 'section': r.section,
          'title': r.title, 'body': r.body,
        }),
    'ruleTags': await rows(db.select(db.ruleTags).get(), (t) => {
          'ruleId': t.ruleId, 'tagId': t.tagId,
        }),
    'checklistItems': await rows(db.select(db.checklistItems).get(), (c) => {
          'id': c.id, 'workId': c.workId, 'category': c.category,
          'content': c.content, 'status': c.status, 'remark': c.remark, 'sort': c.sort,
        }),
    'inspirations': await rows(db.select(db.inspirations).get(), (i) => {
          'id': i.id, 'workId': i.workId, 'type': i.type, 'content': i.content,
          'transcript': i.transcript, 'audioPath': i.audioPath,
          'tagsJson': i.tagsJson, 'status': i.status, 'refsJson': i.refsJson,
          'createdAt': _iso(i.createdAt),
        }),
  };

  final docDir = await getApplicationDocumentsDirectory();
  final exportDir = Directory(p.join(docDir.path, 'exports'));
  if (!await exportDir.exists()) await exportDir.create(recursive: true);
  final zipPath = p.join(exportDir.path, 'oc_export_${newId()}.zip');

  // 收集图片文件
  final imagePaths = <String>{};
  for (final o in (data['ocs'] as List)) {
    if (o['avatarPath'] != null && (o['avatarPath'] as String).isNotEmpty) {
      imagePaths.add(o['avatarPath'] as String);
    }
  }
  for (final m in (data['worldMaps'] as List)) {
    if (m['imagePath'] != null && (m['imagePath'] as String).isNotEmpty) {
      imagePaths.add(m['imagePath'] as String);
    }
  }
  for (final key in const [
    'appearanceItems',
    'timelineEvents',
    'relationStages',
    'locations'
  ]) {
    for (final row in (data[key] as List)) {
      try {
        final list = jsonDecode(row['imagesJson'] as String) as List;
        for (final img in list) {
          if (img is Map && img['path'] != null) {
            imagePaths.add(img['path'] as String);
          }
        }
      } catch (_) {}
    }
  }

  final encoder = ZipFileEncoder();
  encoder.create(zipPath);
  final dataFile = File(p.join(exportDir.path, 'data.json'));
  await dataFile.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
  encoder.addFile(dataFile, 'data.json');
  var i = 0;
  for (final img in imagePaths) {
    if (File(img).existsSync()) {
      encoder.addFile(File(img), 'images/$i${p.extension(img)}');
      i++;
    }
  }
  encoder.close();
  await dataFile.delete();
  return zipPath;
}

/// 导入 zip（全新插入，重新分配 id），返回导入的作品数量
Future<int> importZip(AppDatabase db, String zipPath) async {
  final bytes = await File(zipPath).readAsBytes();
  final archive = ZipDecoder().decodeBytes(bytes);
  String? jsonStr;
  final images = <String, List<int>>{};
  for (final f in archive) {
    if (f.name == 'data.json') {
      jsonStr = utf8.decode(f.content as List<int>);
    } else if (f.name.startsWith('images/') && f.isFile) {
      images[f.name] = f.content as List<int>;
    }
  }
  if (jsonStr == null) return 0;
  final data = jsonDecode(jsonStr) as Map<String, dynamic>;

  final docDir = await getApplicationDocumentsDirectory();
  final imagesDir = Directory(p.join(docDir.path, 'images'));
  if (!await imagesDir.exists()) await imagesDir.create(recursive: true);
  final imageNameToPath = <String, String>{};
  for (final e in images.entries) {
    final name = p.basename(e.key);
    final dest = p.join(imagesDir.path, name);
    await File(dest).writeAsBytes(e.value);
    imageNameToPath['images/$name'] = dest;
  }

  // id 重映射
  final remap = <String, String>{};
  String nid(String old) {
    final n = newId();
    remap[old] = n;
    return n;
  }

  final works = (data['works'] as List).cast<Map<String, dynamic>>();
  final workIdMap = <String, String>{};
  for (final w in works) {
    workIdMap[w['id'] as String] = nid(w['id'] as String);
  }

  Future<void> insertWorkChildren(String oldWorkId, String newWorkId) async {
    final tags = ((data['tags'] as List).cast<Map<String, dynamic>>())
        .where((t) => t['workId'] == oldWorkId);
    final tagIdMap = <String, String>{};
    for (final t in tags) {
      tagIdMap[t['id'] as String] = nid(t['id'] as String);
      await db.into(db.tags).insert(TagsCompanion.insert(
            id: tagIdMap[t['id']]!,
            workId: newWorkId,
            name: t['name'] as String,
            colorValue: t['colorValue'] as int,
          ));
    }
    final dims = ((data['dimensionTemplates'] as List).cast<Map<String, dynamic>>())
        .where((d) => d['workId'] == oldWorkId);
    for (final d in dims) {
      await db.into(db.dimensionTemplates).insert(DimensionTemplatesCompanion.insert(
            id: nid(d['id'] as String),
            workId: newWorkId,
            name: d['name'] as String,
            sort: d['sort'] as int,
          ));
    }
    final ocs = ((data['ocs'] as List).cast<Map<String, dynamic>>())
        .where((o) => o['workId'] == oldWorkId);
    final ocIdMap = <String, String>{};
    for (final o in ocs) {
      ocIdMap[o['id'] as String] = nid(o['id'] as String);
      await db.into(db.ocs).insert(OcsCompanion.insert(
            id: ocIdMap[o['id']]!,
            workId: newWorkId,
            name: o['name'] as String,
            age: Value(o['age'] as String?),
            gender: Value(o['gender'] as String?),
            birthday: Value(_date(o['birthday'] as String?)),
            constellation: Value(o['constellation'] as String?),
            avatarPath: Value(_remapPath(o['avatarPath'] as String?, imageNameToPath)),
            mbti: Value(o['mbti'] as String?),
            familyBackground: Value(o['familyBackground'] as String? ?? ''),
            coreDrive: Value(o['coreDrive'] as String? ?? ''),
            goalMotivation: Value(o['goalMotivation'] as String? ?? ''),
            posX: Value((o['posX'] as num?)?.toDouble()),
            posY: Value((o['posY'] as num?)?.toDouble()),
            createdAt: _date(o['createdAt'] as String?) ?? DateTime.now(),
            updatedAt: _date(o['updatedAt'] as String?) ?? DateTime.now(),
          ));
    }
    // ocTags
    final ocTags = (data['ocTags'] as List).cast<Map<String, dynamic>>();
    for (final t in ocTags) {
      if (ocIdMap.containsKey(t['ocId']) && tagIdMap.containsKey(t['tagId'])) {
        await db.into(db.ocTags).insert(OcTagsCompanion.insert(
            ocId: ocIdMap[t['ocId']]!, tagId: tagIdMap[t['tagId']]!));
      }
    }
    // sub-tables
    for (final e in (data['appearanceItems'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.appearanceItems).insert(AppearanceItemsCompanion.insert(
              id: nid(e['id'] as String),
              ocId: ocIdMap[e['ocId']]!,
              section: e['section'] as String,
              richText: e['richText'] as String,
              imagesJson: _remapImages(e['imagesJson'] as String, imageNameToPath),
              sort: e['sort'] as int,
            ));
      }
    }
    for (final e in (data['abilityValues'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.abilityValues).insert(AbilityValuesCompanion.insert(
              id: nid(e['id'] as String),
              ocId: ocIdMap[e['ocId']]!,
              dimensionName: e['dimensionName'] as String,
              score: e['score'] as int,
              remark: Value(e['remark'] as String?),
            ));
      }
    }
    for (final e in (data['coreValues'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.coreValues).insert(CoreValuesCompanion.insert(
            id: nid(e['id'] as String), ocId: ocIdMap[e['ocId']]!,
            value: e['value'] as String, sort: e['sort'] as int));
      }
    }
    for (final e in (data['traits'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.traits).insert(TraitsCompanion.insert(
            id: nid(e['id'] as String), ocId: ocIdMap[e['ocId']]!,
            kind: e['kind'] as String, value: e['value'] as String, sort: e['sort'] as int));
      }
    }
    for (final e in (data['catchphrases'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.catchphrases).insert(CatchphrasesCompanion.insert(
            id: nid(e['id'] as String), ocId: ocIdMap[e['ocId']]!,
            phrase: e['phrase'] as String, sort: e['sort'] as int));
      }
    }
    for (final e in (data['extensionFields'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.extensionFields).insert(ExtensionFieldsCompanion.insert(
            id: nid(e['id'] as String), ocId: ocIdMap[e['ocId']]!,
            key: e['key'] as String, value: e['value'] as String));
      }
    }
    for (final e in (data['timelineEvents'] as List).cast<Map<String, dynamic>>()) {
      if (ocIdMap.containsKey(e['ocId'])) {
        await db.into(db.timelineEvents).insert(TimelineEventsCompanion.insert(
              id: nid(e['id'] as String),
              ocId: ocIdMap[e['ocId']]!,
              timeText: e['timeText'] as String,
              title: e['title'] as String,
              description: e['description'] as String,
              imagesJson: _remapImages(e['imagesJson'] as String, imageNameToPath),
              starred: Value(e['starred'] as bool),
              sort: e['sort'] as int,
            ));
      }
    }
    // relationships
    final relIdMap = <String, String>{};
    final rels = ((data['relationships'] as List).cast<Map<String, dynamic>>())
        .where((r) => r['workId'] == oldWorkId);
    for (final r in rels) {
      if (!ocIdMap.containsKey(r['sourceOcId']) ||
          !ocIdMap.containsKey(r['targetOcId'])) {
        continue;
      }
      relIdMap[r['id'] as String] = nid(r['id'] as String);
      await db.into(db.relationships).insert(RelationshipsCompanion.insert(
            id: relIdMap[r['id']]!,
            workId: newWorkId,
            sourceOcId: ocIdMap[r['sourceOcId']]!,
            targetOcId: ocIdMap[r['targetOcId']]!,
            label: r['label'] as String,
            strength: r['strength'] as String,
            direction: r['direction'] as int,
            description: r['description'] as String,
          ));
    }
    for (final s in (data['relationStages'] as List).cast<Map<String, dynamic>>()) {
      if (relIdMap.containsKey(s['relationshipId'])) {
        await db.into(db.relationStages).insert(RelationStagesCompanion.insert(
              id: nid(s['id'] as String),
              relationshipId: relIdMap[s['relationshipId']]!,
              stageName: s['stageName'] as String,
              timeText: s['timeText'] as String,
              description: s['description'] as String,
              imagesJson: _remapImages(s['imagesJson'] as String, imageNameToPath),
              sort: s['sort'] as int,
            ));
      }
    }
    // maps + locations
    final mapIdMap = <String, String>{};
    final maps = ((data['worldMaps'] as List).cast<Map<String, dynamic>>())
        .where((m) => m['workId'] == oldWorkId);
    for (final m in maps) {
      mapIdMap[m['id'] as String] = nid(m['id'] as String);
      await db.into(db.worldMaps).insert(WorldMapsCompanion.insert(
            id: mapIdMap[m['id']]!,
            workId: newWorkId,
            name: m['name'] as String,
            imagePath: _remapPath(m['imagePath'] as String, imageNameToPath) ?? '',
          ));
    }
    final locIdMap = <String, String>{};
    final locs = ((data['locations'] as List).cast<Map<String, dynamic>>())
        .where((l) => l['workId'] == oldWorkId);
    for (final l in locs) {
      locIdMap[l['id'] as String] = nid(l['id'] as String);
    }
    for (final l in locs) {
      final parentOld = l['parentId'] as String?;
      await db.into(db.locations).insert(LocationsCompanion.insert(
            id: locIdMap[l['id']]!,
            workId: newWorkId,
            parentId: Value(parentOld != null && locIdMap.containsKey(parentOld)
                ? locIdMap[parentOld] : null),
            name: l['name'] as String,
            description: l['description'] as String,
            type: l['type'] as String,
            imagesJson: _remapImages(l['imagesJson'] as String, imageNameToPath),
            mapId: Value(l['mapId'] != null && mapIdMap.containsKey(l['mapId'])
                ? mapIdMap[l['mapId']] : null),
            x: Value((l['x'] as num?)?.toDouble()),
            y: Value((l['y'] as num?)?.toDouble()),
          ));
    }
    // rules
    final ruleIdMap = <String, String>{};
    final rules = ((data['ruleEntries'] as List).cast<Map<String, dynamic>>())
        .where((r) => r['workId'] == oldWorkId);
    for (final r in rules) {
      ruleIdMap[r['id'] as String] = nid(r['id'] as String);
      await db.into(db.ruleEntries).insert(RuleEntriesCompanion.insert(
            id: ruleIdMap[r['id']]!,
            workId: newWorkId,
            section: r['section'] as String,
            title: r['title'] as String,
            body: r['body'] as String,
          ));
    }
    for (final t in (data['ruleTags'] as List).cast<Map<String, dynamic>>()) {
      if (ruleIdMap.containsKey(t['ruleId']) && tagIdMap.containsKey(t['tagId'])) {
        await db.into(db.ruleTags).insert(RuleTagsCompanion.insert(
            ruleId: ruleIdMap[t['ruleId']]!, tagId: tagIdMap[t['tagId']]!));
      }
    }
    for (final c in ((data['checklistItems'] as List).cast<Map<String, dynamic>>())
        .where((c) => c['workId'] == oldWorkId)) {
      await db.into(db.checklistItems).insert(ChecklistItemsCompanion.insert(
            id: nid(c['id'] as String),
            workId: newWorkId,
            category: c['category'] as String,
            content: c['content'] as String,
            status: c['status'] as String,
            remark: c['remark'] as String,
            sort: c['sort'] as int,
          ));
    }
    for (final i in ((data['inspirations'] as List).cast<Map<String, dynamic>>())
        .where((i) => i['workId'] == oldWorkId)) {
      await db.into(db.inspirations).insert(InspirationsCompanion.insert(
            id: nid(i['id'] as String),
            workId: newWorkId,
            type: i['type'] as String,
            content: i['content'] as String,
            transcript: i['transcript'] as String,
            audioPath: i['audioPath'] as String,
            tagsJson: i['tagsJson'] as String,
            status: i['status'] as String,
            refsJson: i['refsJson'] as String,
            createdAt: _date(i['createdAt'] as String?) ?? DateTime.now(),
          ));
    }
  }

  for (final w in works) {
    await db.into(db.works).insert(WorksCompanion.insert(
          id: workIdMap[w['id']]!,
          name: w['name'] as String,
          coverPath: Value(w['coverPath'] as String?),
          createdAt: _date(w['createdAt'] as String?) ?? DateTime.now(),
          updatedAt: _date(w['updatedAt'] as String?) ?? DateTime.now(),
        ));
    await insertWorkChildren(w['id'] as String, workIdMap[w['id']]!);
  }

  return works.length;
}

String? _remapPath(String? path, Map<String, String> map) {
  if (path == null || path.isEmpty) return null;
  final name = p.basename(path);
  return map['images/$name'] ?? path;
}

String _remapImages(String imagesJson, Map<String, String> map) {
  try {
    final list = jsonDecode(imagesJson) as List;
    for (final img in list) {
      if (img is Map && img['path'] != null) {
        img['path'] = _remapPath(img['path'] as String, map);
      }
    }
    return jsonEncode(list);
  } catch (_) {
    return imagesJson;
  }
}
