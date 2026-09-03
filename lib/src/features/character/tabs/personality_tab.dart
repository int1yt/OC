import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class PersonalityTab extends ConsumerWidget {
  const PersonalityTab({super.key, required this.ocId});
  final String ocId;

  Future<void> _setMbti(WidgetRef ref, String? mbti) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.ocs)..where((t) => t.id.equals(ocId)))
        .write(OcsCompanion(mbti: Value(mbti), updatedAt: Value(DateTime.now())));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oc = ref.watch(ocStreamProvider(ocId)).value;
    final coreValues = ref.watch(coreValuesStreamProvider(ocId)).value ?? const [];
    final traits = ref.watch(traitsStreamProvider(ocId)).value ?? const [];
    final catchphrases =
        ref.watch(catchphrasesStreamProvider(ocId)).value ?? const [];
    final extFields =
        ref.watch(extensionFieldsStreamProvider(ocId)).value ?? const [];

    final strengths = traits.where((t) => t.kind == 'strength').toList();
    final weaknesses = traits.where((t) => t.kind == 'weakness').toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('MBTI', style: _sectionStyle),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: oc?.mbti,
          decoration: const InputDecoration(labelText: '16 型人格'),
          items: kMbtiTypes
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: (v) => _setMbti(ref, v),
        ),
        if (oc?.mbti != null && kMbtiDescriptions.containsKey(oc!.mbti))
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(kMbtiDescriptions[oc.mbti]!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          ),
        const SizedBox(height: 24),
        _EditableSection(
          title: '核心价值观（最重要的排前）',
          items: coreValues.map((e) => _Item(e.id, e.value)).toList(),
          reorderable: true,
          onAdd: (text) async {
            final db = ref.read(databaseProvider);
            await db.into(db.coreValues).insert(CoreValuesCompanion.insert(
                id: newId(), ocId: ocId, value: text, sort: coreValues.length));
          },
          onDelete: (id) async {
            final db = ref.read(databaseProvider);
            await db.deleteWhere(db.coreValues, (t) => t.id.equals(id));
          },
          onReorder: (id, delta) => _reorder(ref, coreValues, id, delta),
        ),
        const SizedBox(height: 24),
        _EditableSection(
          title: '优点',
          items: strengths.map((e) => _Item(e.id, e.value)).toList(),
          onAdd: (text) async {
            final db = ref.read(databaseProvider);
            await db.into(db.traits).insert(TraitsCompanion.insert(
                id: newId(),
                ocId: ocId,
                kind: 'strength',
                value: text,
                sort: strengths.length));
          },
          onDelete: (id) async {
            final db = ref.read(databaseProvider);
            await db.deleteWhere(db.traits, (t) => t.id.equals(id));
          },
        ),
        const SizedBox(height: 24),
        _EditableSection(
          title: '缺点',
          items: weaknesses.map((e) => _Item(e.id, e.value)).toList(),
          onAdd: (text) async {
            final db = ref.read(databaseProvider);
            await db.into(db.traits).insert(TraitsCompanion.insert(
                id: newId(),
                ocId: ocId,
                kind: 'weakness',
                value: text,
                sort: weaknesses.length));
          },
          onDelete: (id) async {
            final db = ref.read(databaseProvider);
            await db.deleteWhere(db.traits, (t) => t.id.equals(id));
          },
        ),
        const SizedBox(height: 24),
        _EditableSection(
          title: '口头禅',
          items: catchphrases.map((e) => _Item(e.id, e.phrase)).toList(),
          onAdd: (text) async {
            final db = ref.read(databaseProvider);
            await db.into(db.catchphrases).insert(CatchphrasesCompanion.insert(
                id: newId(), ocId: ocId, phrase: text, sort: catchphrases.length));
          },
          onDelete: (id) async {
            final db = ref.read(databaseProvider);
            await db.deleteWhere(db.catchphrases, (t) => t.id.equals(id));
          },
        ),
        const SizedBox(height: 24),
        Text('扩展字段', style: _sectionStyle),
        const SizedBox(height: 8),
        for (final f in extFields)
          Card(
            child: ListTile(
              title: Text(f.key),
              subtitle: Text(f.value),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  final db = ref.read(databaseProvider);
                  db.deleteWhere(db.extensionFields, (t) => t.id.equals(f.id));
                },
              ),
            ),
          ),
        TextButton.icon(
          onPressed: () => _addExtField(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('添加字段'),
        ),
      ],
    );
  }

  Future<void> _reorder(
      WidgetRef ref, List<CoreValue> list, String id, int delta) async {
    final idx = list.indexWhere((e) => e.id == id);
    final target = idx + delta;
    if (idx < 0 || target < 0 || target >= list.length) return;
    final reordered = List<CoreValue>.from(list);
    final item = reordered.removeAt(idx);
    reordered.insert(target, item);
    final db = ref.read(databaseProvider);
    for (var i = 0; i < reordered.length; i++) {
      await (db.update(db.coreValues)..where((t) => t.id.equals(reordered[i].id)))
          .write(CoreValuesCompanion(sort: Value(i)));
    }
  }

  Future<void> _addExtField(BuildContext context, WidgetRef ref) async {
    final keyCtrl = TextEditingController();
    final valCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加扩展字段'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: keyCtrl,
                decoration: const InputDecoration(labelText: '字段名')),
            TextField(
                controller: valCtrl,
                decoration: const InputDecoration(labelText: '值')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('添加')),
        ],
      ),
    );
    if (ok == true && keyCtrl.text.isNotEmpty) {
      final db = ref.read(databaseProvider);
      await db.into(db.extensionFields).insert(ExtensionFieldsCompanion.insert(
          id: newId(),
          ocId: ocId,
          key: keyCtrl.text.trim(),
          value: valCtrl.text.trim()));
    }
  }
}

TextStyle get _sectionStyle =>
    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

class _Item {
  const _Item(this.id, this.text);
  final String id;
  final String text;
}

class _EditableSection extends StatefulWidget {
  const _EditableSection({
    required this.title,
    required this.items,
    required this.onAdd,
    required this.onDelete,
    this.reorderable = false,
    this.onReorder,
  });

  final String title;
  final List<_Item> items;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onDelete;
  final bool reorderable;
  final void Function(String id, int delta)? onReorder;

  @override
  State<_EditableSection> createState() => _EditableSectionState();
}

class _EditableSectionState extends State<_EditableSection> {
  Future<void> _add() async {
    final ctrl = TextEditingController();
    final text = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('添加${widget.title}'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
              child: const Text('添加')),
        ],
      ),
    );
    if (text != null && text.isNotEmpty) widget.onAdd(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: _sectionStyle),
            IconButton(onPressed: _add, icon: const Icon(Icons.add)),
          ],
        ),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text('暂无', style: TextStyle(color: Colors.grey.shade500)),
          ),
        for (var i = 0; i < widget.items.length; i++)
          Card(
            child: ListTile(
              dense: true,
              title: Text(widget.items[i].text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.reorderable) ...[
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, size: 18),
                      onPressed: i == 0
                          ? null
                          : () => widget.onReorder!(widget.items[i].id, -1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, size: 18),
                      onPressed: i == widget.items.length - 1
                          ? null
                          : () => widget.onReorder!(widget.items[i].id, 1),
                    ),
                  ],
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    onPressed: () => widget.onDelete(widget.items[i].id),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
