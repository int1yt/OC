import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class LocationTreeTab extends ConsumerWidget {
  const LocationTreeTab({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref, String workId,
      {String? parentId}) async {
    final nameCtrl = TextEditingController();
    final typeCtrl = TextEditingController(text: '地标');
    final descCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(parentId == null ? '添加顶层地点' : '添加子地点'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: '名称')),
              const SizedBox(height: 16),
              TextField(
                  controller: typeCtrl,
                  decoration: const InputDecoration(
                      labelText: '类型（大陆/国家/城市/地标）')),
              const SizedBox(height: 16),
              TextField(
                  controller: descCtrl,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: '简介')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('添加')),
        ],
      ),
    );
    if (ok != true || nameCtrl.text.trim().isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.locations).insert(LocationsCompanion.insert(
          id: newId(),
          workId: workId,
          parentId: Value(parentId),
          name: nameCtrl.text.trim(),
          description: descCtrl.text.trim(),
          type: typeCtrl.text.trim().isEmpty ? '地标' : typeCtrl.text.trim(),
          imagesJson: '[]',
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final locations =
        ref.watch(locationsStreamProvider(workId)).value ?? const <Location>[];

    final roots = locations.where((l) => l.parentId == null).toList();
    final childrenMap = <String, List<Location>>{};
    for (final l in locations) {
      if (l.parentId != null) {
        childrenMap.putIfAbsent(l.parentId!, () => []).add(l);
      }
    }

    return Column(
      children: [
        Expanded(
          child: locations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.account_tree_outlined,
                          size: 56, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('还没有地点，创建世界层级结构'),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () => _add(context, ref, workId),
                        icon: const Icon(Icons.add),
                        label: const Text('添加顶层地点'),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    for (final root in roots)
                      _LocationNode(
                        location: root,
                        childrenMap: childrenMap,
                        depth: 0,
                        onAddChild: (pid) =>
                            _add(context, ref, workId, parentId: pid),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _LocationNode extends ConsumerWidget {
  const _LocationNode({
    required this.location,
    required this.childrenMap,
    required this.depth,
    required this.onAddChild,
  });

  final Location location;
  final Map<String, List<Location>> childrenMap;
  final int depth;
  final void Function(String parentId) onAddChild;

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController(text: location.name);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重命名'),
        content: TextField(
            controller: ctrl,
            autofocus: true,
            onSubmitted: (v) => Navigator.pop(ctx, v.trim())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
              child: const Text('确定')),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.locations)..where((t) => t.id.equals(location.id)))
        .write(LocationsCompanion(name: Value(name)));
  }

  Future<void> _editDesc(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController(text: location.description);
    final desc = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('简介'),
        content: TextField(controller: ctrl, maxLines: 4),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text),
              child: const Text('保存')),
        ],
      ),
    );
    if (desc == null) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.locations)..where((t) => t.id.equals(location.id)))
        .write(LocationsCompanion(description: Value(desc)));
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除「${location.name}」？'),
        content: const Text('子地点会提升到其上一级。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.locations)
          ..where((t) => t.parentId.equals(location.id)))
        .write(LocationsCompanion(parentId: Value(location.parentId)));
    await db.deleteWhere(db.locations, (t) => t.id.equals(location.id));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = childrenMap[location.id] ?? const <Location>[];
    final hasChildren = children.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        initiallyExpanded: depth < 2,
        leading: hasChildren
            ? const Icon(Icons.folder_outlined)
            : const Icon(Icons.place_outlined),
        title: Row(
          children: [
            Flexible(child: Text(location.name)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(location.type, style: const TextStyle(fontSize: 11)),
            ),
          ],
        ),
        subtitle: location.description.isEmpty
            ? null
            : Text(location.description,
                maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add, size: 18),
              onPressed: () => onAddChild(location.id),
            ),
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'rename') _rename(context, ref);
                if (v == 'desc') _editDesc(context, ref);
                if (v == 'delete') _delete(context, ref);
              },
              itemBuilder: (ctx) => const [
                PopupMenuItem(value: 'rename', child: Text('重命名')),
                PopupMenuItem(value: 'desc', child: Text('编辑简介')),
                PopupMenuItem(value: 'delete', child: Text('删除')),
              ],
            ),
          ],
        ),
        children: [
          for (final c in children)
            _LocationNode(
              location: c,
              childrenMap: childrenMap,
              depth: depth + 1,
              onAddChild: onAddChild,
            ),
        ],
      ),
    );
  }
}
