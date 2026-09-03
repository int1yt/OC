import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/image_store.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class AppearanceTab extends ConsumerWidget {
  const AppearanceTab({super.key, required this.ocId});
  final String ocId;

  Future<void> _addEntry(WidgetRef ref, String section) async {
    final db = ref.read(databaseProvider);
    final count = await (db.select(db.appearanceItems)
          ..where((t) => t.ocId.equals(ocId) & t.section.equals(section)))
        .get();
    await db.into(db.appearanceItems).insert(AppearanceItemsCompanion.insert(
          id: newId(),
          ocId: ocId,
          section: section,
          richText: '',
          imagesJson: '[]',
          sort: count.length,
        ));
  }

  Future<void> _updateText(
      WidgetRef ref, AppearanceItem item, String text) async {
    final db = ref.read(databaseProvider);
    await (db.update(db.appearanceItems)..where((t) => t.id.equals(item.id)))
        .write(AppearanceItemsCompanion(richText: Value(text)));
  }

  Future<void> _addImage(WidgetRef ref, AppearanceItem item) async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    final list = (jsonDecode(item.imagesJson) as List).cast<Map>();
    list.add({'path': path, 'caption': ''});
    final db = ref.read(databaseProvider);
    await (db.update(db.appearanceItems)..where((t) => t.id.equals(item.id)))
        .write(AppearanceItemsCompanion(imagesJson: Value(jsonEncode(list))));
  }

  Future<void> _removeImage(
      WidgetRef ref, AppearanceItem item, int index) async {
    final list = (jsonDecode(item.imagesJson) as List).cast<Map>();
    list.removeAt(index);
    final db = ref.read(databaseProvider);
    await (db.update(db.appearanceItems)..where((t) => t.id.equals(item.id)))
        .write(AppearanceItemsCompanion(imagesJson: Value(jsonEncode(list))));
  }

  Future<void> _deleteEntry(WidgetRef ref, AppearanceItem item) async {
    final db = ref.read(databaseProvider);
    await db.deleteWhere(db.appearanceItems, (t) => t.id.equals(item.id));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items =
        ref.watch(appearanceStreamProvider(ocId)).value ?? const <AppearanceItem>[];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final section in kAppearanceSections) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(section,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addEntry(ref, section),
              ),
            ],
          ),
          ...items.where((i) => i.section == section).map(
                (item) => _EntryCard(
                  item: item,
                  onText: (t) => _updateText(ref, item, t),
                  onAddImage: () => _addImage(ref, item),
                  onRemoveImage: (i) => _removeImage(ref, item, i),
                  onDelete: () => _deleteEntry(ref, item),
                ),
              ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.item,
    required this.onText,
    required this.onAddImage,
    required this.onRemoveImage,
    required this.onDelete,
  });

  final AppearanceItem item;
  final ValueChanged<String> onText;
  final VoidCallback onAddImage;
  final ValueChanged<int> onRemoveImage;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final images = (jsonDecode(item.imagesJson) as List).cast<Map>();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: item.richText,
              maxLines: null,
              minLines: 2,
              decoration: const InputDecoration(
                hintText: '文字描述…',
                border: InputBorder.none,
              ),
              onChanged: onText,
            ),
            if (images.isNotEmpty)
              SizedBox(
                height: 84,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, i) {
                    final path = images[i]['path'] as String;
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(File(path),
                                width: 76, height: 76, fit: BoxFit.cover),
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
                    );
                  },
                ),
              ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onAddImage,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('加图'),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
