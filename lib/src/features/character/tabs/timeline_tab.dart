import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/image_store.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class TimelineTab extends ConsumerStatefulWidget {
  const TimelineTab({super.key, required this.ocId});
  final String ocId;

  @override
  ConsumerState<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends ConsumerState<TimelineTab> {
  bool _newestFirst = false;

  Future<void> _add() async {
    final timeCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加事件'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: timeCtrl,
                decoration: const InputDecoration(labelText: '时间（如 12 岁 / 第三章）')),
            TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: '事件标题')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('添加')),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    final count = await (db.select(db.timelineEvents)
          ..where((t) => t.ocId.equals(widget.ocId)))
        .get();
    await db.into(db.timelineEvents).insert(TimelineEventsCompanion.insert(
          id: newId(),
          ocId: widget.ocId,
          timeText: timeCtrl.text.trim(),
          title: titleCtrl.text.trim(),
          description: '',
          imagesJson: '[]',
          starred: const Value(false),
          sort: count.length,
        ));
  }

  Future<void> _toggleStar(TimelineEvent e) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.timelineEvents)..where((t) => t.id.equals(e.id)))
        .write(TimelineEventsCompanion(starred: Value(!e.starred)));
  }

  Future<void> _reorder(List<TimelineEvent> list, String id, int delta) async {
    final idx = list.indexWhere((e) => e.id == id);
    final target = idx + delta;
    if (idx < 0 || target < 0 || target >= list.length) return;
    final reordered = List<TimelineEvent>.from(list);
    final item = reordered.removeAt(idx);
    reordered.insert(target, item);
    final db = ref.read(databaseProvider);
    for (var i = 0; i < reordered.length; i++) {
      await (db.update(db.timelineEvents)
            ..where((t) => t.id.equals(reordered[i].id)))
          .write(TimelineEventsCompanion(sort: Value(i)));
    }
  }

  Future<void> _addImage(TimelineEvent e) async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    final list = (jsonDecode(e.imagesJson) as List).cast<Map>();
    list.add({'path': path, 'caption': ''});
    final db = ref.read(databaseProvider);
    await (db.update(db.timelineEvents)..where((t) => t.id.equals(e.id)))
        .write(TimelineEventsCompanion(imagesJson: Value(jsonEncode(list))));
  }

  Future<void> _removeImage(TimelineEvent e, int index) async {
    final list = (jsonDecode(e.imagesJson) as List).cast<Map>();
    list.removeAt(index);
    final db = ref.read(databaseProvider);
    await (db.update(db.timelineEvents)..where((t) => t.id.equals(e.id)))
        .write(TimelineEventsCompanion(imagesJson: Value(jsonEncode(list))));
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(timelineStreamProvider(widget.ocId)).value ??
        const <TimelineEvent>[];
    final sorted = List<TimelineEvent>.from(events)
      ..sort((a, b) => _newestFirst
          ? b.sort.compareTo(a.sort)
          : a.sort.compareTo(b.sort));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              Text('共 ${events.length} 条',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              const Spacer(),
              TextButton.icon(
                onPressed: () => setState(() => _newestFirst = !_newestFirst),
                icon: Icon(_newestFirst
                    ? Icons.arrow_upward
                    : Icons.arrow_downward),
                label: Text(_newestFirst ? '最新在上' : '最旧在上'),
              ),
            ],
          ),
        ),
        Expanded(
          child: sorted.isEmpty
              ? Center(
                  child: Text('暂无事件',
                      style: TextStyle(color: Colors.grey.shade500)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (context, i) => _TimelineItem(
                    event: sorted[i],
                    index: i,
                    total: sorted.length,
                    onStar: () => _toggleStar(sorted[i]),
                    onUp: () => _reorder(sorted, sorted[i].id, -1),
                    onDown: () => _reorder(sorted, sorted[i].id, 1),
                    onAddImage: () => _addImage(sorted[i]),
                    onRemoveImage: (idx) => _removeImage(sorted[i], idx),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _add,
              icon: const Icon(Icons.add),
              label: const Text('添加事件'),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.index,
    required this.total,
    required this.onStar,
    required this.onUp,
    required this.onDown,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  final TimelineEvent event;
  final int index;
  final int total;
  final VoidCallback onStar;
  final VoidCallback onUp;
  final VoidCallback onDown;
  final VoidCallback onAddImage;
  final ValueChanged<int> onRemoveImage;

  @override
  Widget build(BuildContext context) {
    final images = (jsonDecode(event.imagesJson) as List).cast<Map>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(event.timeText, style: const TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(event.title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                IconButton(
                  icon: Icon(
                    event.starred ? Icons.star : Icons.star_border,
                    color: event.starred ? Colors.amber : null,
                  ),
                  onPressed: onStar,
                ),
              ],
            ),
            TextFormField(
              initialValue: event.description,
              maxLines: null,
              minLines: 2,
              decoration: const InputDecoration(
                  hintText: '事件描述…', border: InputBorder.none),
              onChanged: (v) async {
                final db = ProviderScope.containerOf(context, listen: false)
                    .read(databaseProvider);
                (db.update(db.timelineEvents)
                      ..where((t) => t.id.equals(event.id)))
                    .write(TimelineEventsCompanion(description: Value(v)));
              },
            ),
            if (images.isNotEmpty)
              SizedBox(
                height: 84,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, i) => Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(images[i]['path'] as String),
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () => onRemoveImage(i),
                          child: const CircleAvatar(
                            radius: 10,
                            child: Icon(Icons.close, size: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined, size: 20),
                  onPressed: onAddImage,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_upward, size: 18),
                  onPressed: index == 0 ? null : onUp,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward, size: 18),
                  onPressed: index == total - 1 ? null : onDown,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
