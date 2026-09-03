import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class StoryTab extends ConsumerWidget {
  const StoryTab({super.key, required this.ocId});
  final String ocId;

  Future<void> _saveText(WidgetRef ref, String field, String text) async {
    final db = ref.read(databaseProvider);
    final companion = OcsCompanion(
      familyBackground: field == 'family' ? Value(text) : const Value.absent(),
      coreDrive: field == 'core' ? Value(text) : const Value.absent(),
      goalMotivation: field == 'goal' ? Value(text) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
    await (db.update(db.ocs)..where((t) => t.id.equals(ocId))).write(companion);
  }

  Future<void> _addTurningPoint(
      BuildContext context, WidgetRef ref, int sort) async {
    final timeCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final ok = await _dialog(context, '添加人生转折点', [
      TextField(
          controller: timeCtrl,
          decoration: const InputDecoration(labelText: '时间（如 12 岁）')),
      TextField(
          controller: titleCtrl,
          decoration: const InputDecoration(labelText: '事件标题')),
    ]);
    if (!ok) return;
    final db = ref.read(databaseProvider);
    await db.into(db.timelineEvents).insert(TimelineEventsCompanion.insert(
          id: newId(),
          ocId: ocId,
          timeText: timeCtrl.text.trim(),
          title: titleCtrl.text.trim(),
          description: '',
          imagesJson: '[]',
          starred: const Value(true),
          sort: sort,
        ));
  }

  Future<bool> _dialog(
      BuildContext context, String title, List<Widget> fields) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(mainAxisSize: MainAxisSize.min, children: fields),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('确定')),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oc = ref.watch(ocStreamProvider(ocId)).value;
    final events =
        ref.watch(timelineStreamProvider(ocId)).value ?? const <TimelineEvent>[];
    final turning = events.where((e) => e.starred).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('原生家庭', style: _s),
        _LongText(
          initial: oc?.familyBackground ?? '',
          hint: '家庭背景、成长环境…',
          onChanged: (v) => _saveText(ref, 'family', v),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('人生转折点', style: _s),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addTurningPoint(context, ref, turning.length)),
          ],
        ),
        if (turning.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text('暂无', style: TextStyle(color: Colors.grey.shade500)),
          ),
        for (final e in turning)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(e.timeText, style: const TextStyle(fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(e.title,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18),
                        onPressed: () {
                          final db = ref.read(databaseProvider);
                          db.deleteWhere(db.timelineEvents, (t) => t.id.equals(e.id));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    initialValue: e.description,
                    maxLines: null,
                    minLines: 2,
                    decoration: const InputDecoration(
                        hintText: '事件描述…', border: InputBorder.none),
                    onChanged: (v) {
                      final db = ref.read(databaseProvider);
                      (db.update(db.timelineEvents)
                            ..where((t) => t.id.equals(e.id)))
                          .write(TimelineEventsCompanion(description: Value(v)));
                    },
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 24),
        Text('核心驱动力', style: _s),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text('这是角色立得住的关键，建议填写',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ),
        _LongText(
          initial: oc?.coreDrive ?? '',
          hint: '驱动这个角色行动的根本原因…',
          onChanged: (v) => _saveText(ref, 'core', v),
        ),
        const SizedBox(height: 24),
        Text('目标 / 动机', style: _s),
        _LongText(
          initial: oc?.goalMotivation ?? '',
          hint: '角色想要什么、怕什么、愿意付出什么…',
          onChanged: (v) => _saveText(ref, 'goal', v),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

TextStyle get _s => const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

class _LongText extends StatelessWidget {
  const _LongText(
      {required this.initial, required this.hint, required this.onChanged});
  final String initial;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initial,
      maxLines: null,
      minLines: 3,
      decoration: InputDecoration(hintText: hint),
      onChanged: onChanged,
    );
  }
}
