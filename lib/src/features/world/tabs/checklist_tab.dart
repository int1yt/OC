import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

const List<(String, String)> _builtinChecklist = [
  ('地理', '河流流向是否从高到低、是否与山脉走向矛盾'),
  ('地理', '城市是否靠近水源（河/湖/井）'),
  ('地理', '城市补给线（粮食、水源、道路）是否存在'),
  ('地理', '气候带与纬度/洋流是否自洽（沙漠不该挨着雨林）'),
  ('地理', '山脉走向是否影响季风/降雨'),
  ('经济', '货币体系能否支撑跨地区贸易'),
  ('经济', '大城市的粮食能否自给或有明确进口来源'),
  ('经济', '资源（矿/木材/魔法材料）分布与产业是否匹配'),
  ('经济', '人口规模与城市规模是否匹配'),
  ('政治 / 社会', '国家边界是否与地理屏障（山脉/河流）一致'),
  ('政治 / 社会', '是否存在地缘冲突的合理动机'),
  ('政治 / 社会', '阶级/社会制度与经济基础是否自洽'),
];

const List<String> _statuses = ['通过', '存疑', '不适用'];

class ChecklistTab extends ConsumerStatefulWidget {
  const ChecklistTab({super.key});

  @override
  ConsumerState<ChecklistTab> createState() => _ChecklistTabState();
}

class _ChecklistTabState extends ConsumerState<ChecklistTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_seed);
  }

  Future<void> _seed() async {
    final workId = ref.read(currentWorkIdProvider);
    if (workId == null) return;
    final db = ref.read(databaseProvider);
    final existing = await (db.select(db.checklistItems)
          ..where((t) => t.workId.equals(workId)))
        .get();
    if (existing.isNotEmpty) return;
    for (var i = 0; i < _builtinChecklist.length; i++) {
      final (cat, text) = _builtinChecklist[i];
      await db.into(db.checklistItems).insert(ChecklistItemsCompanion.insert(
            id: newId(),
            workId: workId,
            category: cat,
            content: text,
            status: '',
            remark: '',
            sort: i,
          ));
    }
  }

  Future<void> _setStatus(ChecklistItem item, String status) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.checklistItems)..where((t) => t.id.equals(item.id)))
        .write(ChecklistItemsCompanion(status: Value(status)));
  }

  Future<void> _setRemark(ChecklistItem item, String remark) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.checklistItems)..where((t) => t.id.equals(item.id)))
        .write(ChecklistItemsCompanion(remark: Value(remark)));
  }

  Future<void> _addCustom() async {
    final workId = ref.read(currentWorkIdProvider);
    if (workId == null) return;
    final ctrl = TextEditingController();
    var category = kChecklistCategories.first;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                initialValue: category,
                decoration: const InputDecoration(labelText: '分类'),
                items: kChecklistCategories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => category = v ?? category),
              ),
              const SizedBox(height: 8),
              TextField(
                  controller: ctrl,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: '核查项')),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final db = ref.read(databaseProvider);
                  final count = await (db.select(db.checklistItems)
                        ..where((t) => t.workId.equals(workId)))
                      .get();
                  await db.into(db.checklistItems).insert(
                      ChecklistItemsCompanion.insert(
                          id: newId(),
                          workId: workId,
                          category: category,
                          content: ctrl.text.trim(),
                          status: '',
                          remark: '',
                          sort: count.length));
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('添加'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _exportReport(List<ChecklistItem> items) async {
    final buffer = StringBuffer();
    for (final cat in kChecklistCategories) {
      final group = items.where((i) => i.category == cat).toList();
      if (group.isEmpty) continue;
      buffer.writeln('【$cat】');
      for (final i in group) {
        final status = i.status.isEmpty ? '未标记' : i.status;
        buffer.writeln(
            '- [$status] ${i.content}${i.remark.isEmpty ? '' : '（备注：${i.remark}）'}');
      }
      buffer.writeln();
    }
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('自检报告'),
        content: SingleChildScrollView(
          child: SelectableText(buffer.toString()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('关闭')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final items =
        ref.watch(checklistStreamProvider(workId)).value ?? const <ChecklistItem>[];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () => _addCustom(),
                icon: const Icon(Icons.add),
                label: const Text('添加核查项'),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _exportReport(items),
                icon: const Icon(Icons.description_outlined),
                label: const Text('导出报告'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final cat in kChecklistCategories)
                if (items.any((i) => i.category == cat)) ...[
                  Text(cat,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  for (final i in items.where((i) => i.category == cat))
                    _ChecklistCard(
                      item: i,
                      onStatus: (s) => _setStatus(i, s),
                      onRemark: (r) => _setRemark(i, r),
                    ),
                  const SizedBox(height: 12),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({
    required this.item,
    required this.onStatus,
    required this.onRemark,
  });

  final ChecklistItem item;
  final ValueChanged<String> onStatus;
  final ValueChanged<String> onRemark;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.content),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: _statuses
                  .map((s) => ChoiceChip(
                        label: Text(s),
                        selected: item.status == s,
                        onSelected: (_) =>
                            onStatus(item.status == s ? '' : s),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: item.remark,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: '备注（存疑时可写）', isDense: true),
              onChanged: onRemark,
            ),
          ],
        ),
      ),
    );
  }
}
