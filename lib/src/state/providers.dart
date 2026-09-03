import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';
import '../data/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// 当前选中的作品 id（全局切换器）
final currentWorkIdProvider = StateProvider<String?>((ref) => null);

Future<void> selectWork(WidgetRef ref, String? id) async {
  ref.read(currentWorkIdProvider.notifier).state = id;
  final prefs = await SharedPreferences.getInstance();
  if (id == null) {
    await prefs.remove('lastWorkId');
  } else {
    await prefs.setString('lastWorkId', id);
  }
}

/// 主题种子色
final themeSeedProvider = StateProvider<int>((ref) => 0xFFE8A6B8);

/// 应用背景图片路径
final bgImagePathProvider = StateProvider<String?>((ref) => null);

/// 开机动画自定义图片路径
final splashImageProvider = StateProvider<String?>((ref) => null);

Future<void> setSplashImage(WidgetRef ref, String? path) async {
  ref.read(splashImageProvider.notifier).state = path;
  final prefs = await SharedPreferences.getInstance();
  if (path == null) {
    await prefs.remove('splashImage');
  } else {
    await prefs.setString('splashImage', path);
  }
}

/// 应用背景图片透明度（0~1）
final bgOpacityProvider = StateProvider<double>((ref) => 1.0);

Future<void> setThemeSeed(WidgetRef ref, int value) async {
  ref.read(themeSeedProvider.notifier).state = value;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('themeSeed', value);
}

Future<void> setBgImage(WidgetRef ref, String? path) async {
  ref.read(bgImagePathProvider.notifier).state = path;
  final prefs = await SharedPreferences.getInstance();
  if (path == null) {
    await prefs.remove('bgImagePath');
  } else {
    await prefs.setString('bgImagePath', path);
  }
}

Future<void> setBgOpacity(WidgetRef ref, double value) async {
  ref.read(bgOpacityProvider.notifier).state = value;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('bgOpacity', value);
}

/// 关系强度颜色（用户可自定义撞色），label → [color1, color2]
final strengthColorsProvider = StateProvider<Map<String, List<int>>>((ref) =>
    defaultStrengthColors());

Map<String, List<int>> defaultStrengthColors() {
  final m = <String, List<int>>{};
  for (final s in RelationStrength.all) {
    m[s.label] = [s.color.toARGB32(), s.color2.toARGB32()];
  }
  return m;
}

Map<String, List<int>> loadStrengthColors(String? json) {
  final m = defaultStrengthColors();
  if (json == null || json.isEmpty) return m;
  try {
    final decoded = jsonDecode(json) as Map<String, dynamic>;
    decoded.forEach((k, v) {
      final list = (v as List).map((e) => (e as num).toInt()).toList();
      if (m.containsKey(k) && list.length == 2) m[k] = list;
    });
  } catch (_) {}
  return m;
}

Future<void> setStrengthColors(
    WidgetRef ref, String label, int c1, int c2) async {
  ref.read(strengthColorsProvider.notifier).update((state) {
    final m = Map<String, List<int>>.from(state);
    m[label] = [c1, c2];
    return m;
  });
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'strengthColors', jsonEncode(ref.read(strengthColorsProvider)));
}

/// 全部作品
final worksStreamProvider = StreamProvider<List<Work>>((ref) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.works)
    ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
  return q.watch();
});

/// 某作品的 OC 列表
final ocsStreamProvider =
    StreamProvider.family<List<Oc>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.ocs)
    ..where((t) => t.workId.equals(workId))
    ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
  return q.watch();
});

/// 某作品内 OC → 标签 映射
final ocTagsMapProvider =
    StreamProvider.family<Map<String, List<Tag>>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.ocTags).join([
    innerJoin(db.tags, db.tags.id.equalsExp(db.ocTags.tagId)),
  ])
    ..where(db.tags.workId.equals(workId));
  return q.watch().map((rows) {
    final map = <String, List<Tag>>{};
    for (final row in rows) {
      final ocId = row.readTable(db.ocTags).ocId;
      final tag = row.readTable(db.tags);
      map.putIfAbsent(ocId, () => []).add(tag);
    }
    return map;
  });
});

/// 某作品的全部标签
final tagsStreamProvider =
    StreamProvider.family<List<Tag>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.tags)
    ..where((t) => t.workId.equals(workId))
    ..orderBy([(t) => OrderingTerm.asc(t.name)]);
  return q.watch();
});

/// 某作品的维度模板
final dimensionsStreamProvider =
    StreamProvider.family<List<DimensionTemplate>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.dimensionTemplates)
    ..where((t) => t.workId.equals(workId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 详情
final ocStreamProvider = StreamProvider.family<Oc?, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.ocs)..where((t) => t.id.equals(ocId));
  return q.watchSingleOrNull();
});

/// 单个 OC 的能力值
final abilityValuesStreamProvider =
    StreamProvider.family<List<AbilityValue>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.abilityValues)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.dimensionName)]);
  return q.watch();
});

/// 单个 OC 的外貌条目
final appearanceStreamProvider =
    StreamProvider.family<List<AppearanceItem>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.appearanceItems)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 的时间轴事件
final timelineStreamProvider =
    StreamProvider.family<List<TimelineEvent>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.timelineEvents)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 的核心价值观
final coreValuesStreamProvider =
    StreamProvider.family<List<CoreValue>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.coreValues)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 的优点/缺点
final traitsStreamProvider =
    StreamProvider.family<List<Trait>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.traits)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 的口头禅
final catchphrasesStreamProvider =
    StreamProvider.family<List<Catchphrase>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.catchphrases)
    ..where((t) => t.ocId.equals(ocId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});

/// 单个 OC 的扩展字段
final extensionFieldsStreamProvider =
    StreamProvider.family<List<ExtensionField>, String>((ref, ocId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.extensionFields)
    ..where((t) => t.ocId.equals(ocId));
  return q.watch();
});

/// 某作品的关系连线
final relationshipsStreamProvider =
    StreamProvider.family<List<Relationship>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.relationships)
    ..where((t) => t.workId.equals(workId));
  return q.watch();
});

/// 某作品的地点
final locationsStreamProvider =
    StreamProvider.family<List<Location>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.locations)
    ..where((t) => t.workId.equals(workId));
  return q.watch();
});

/// 某作品的地图
final mapsStreamProvider =
    StreamProvider.family<List<WorldMap>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.worldMaps)..where((t) => t.workId.equals(workId));
  return q.watch();
});

/// 某作品的规则条目
final ruleEntriesStreamProvider =
    StreamProvider.family<List<RuleEntry>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.ruleEntries)
    ..where((t) => t.workId.equals(workId));
  return q.watch();
});

/// 某作品的自检项
final checklistStreamProvider =
    StreamProvider.family<List<ChecklistItem>, String>((ref, workId) {
  final db = ref.watch(databaseProvider);
  final q = db.select(db.checklistItems)
    ..where((t) => t.workId.equals(workId))
    ..orderBy([(t) => OrderingTerm.asc(t.sort)]);
  return q.watch();
});
