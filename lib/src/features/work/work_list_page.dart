import 'dart:io';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/image_store.dart';
import '../../core/utils.dart';
import '../../data/database.dart';
import '../../data/work_repository.dart';
import '../../state/providers.dart';
import '../help/help_sheet.dart';

class WorkListPage extends ConsumerWidget {
  const WorkListPage({super.key});

  Future<void> _createWork(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final scheme = Theme.of(ctx).colorScheme;
        return Align(
          alignment: const Alignment(0, -0.5),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('新建作品',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: '作品名称，如「星海纪」',
                      filled: false,
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: scheme.primary.withValues(alpha: 0.35)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: scheme.primary, width: 1.5),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('取消'),
                      ),
                      const SizedBox(width: 4),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, controller.text.trim()),
                        child: const Text('创建'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (name == null || name.isEmpty) return;

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = newId();
    await db.into(db.works).insert(WorksCompanion.insert(
          id: id,
          name: name,
          createdAt: now,
          updatedAt: now,
        ));
    await _seedDefaults(db, id);
    if (context.mounted) {
      await selectWork(ref, id);
    }
  }

  Future<void> _seedDefaults(AppDatabase db, String workId) async {
    const dims = ['战力', '智力', '魔力', '敏捷', '魅力', '幸运'];
    for (var i = 0; i < dims.length; i++) {
      await db.into(db.dimensionTemplates).insert(
            DimensionTemplatesCompanion.insert(
              id: newId(),
              workId: workId,
              name: dims[i],
              sort: i,
            ),
          );
    }
  }

  Future<void> _deleteWork(
      BuildContext context, WidgetRef ref, Work work) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除「${work.name}」？'),
        content: const Text('该作品内的所有 OC、关系与世界观将一并删除，且不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    await deleteWorkCascade(db, work.id);
    if (ref.read(currentWorkIdProvider) == work.id) {
      await selectWork(ref, null);
    }
  }

  Future<void> _setCover(WidgetRef ref, Work w) async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.works)..where((t) => t.id.equals(w.id)))
        .write(WorksCompanion(coverPath: Value(path), updatedAt: Value(DateTime.now())));
  }

  void _showMenu(BuildContext context, WidgetRef ref, Work w) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image_outlined),
              title: const Text('设置封面'),
              onTap: () {
                Navigator.pop(ctx);
                _setCover(ref, w);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除'),
              onTap: () {
                Navigator.pop(ctx);
                _deleteWork(context, ref, w);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final works = ref.watch(worksStreamProvider);
    final list = works.value ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的作品'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: '本页帮助',
            onPressed: () => showHelpSheet(context, '我的作品', const [
              HelpItem(Icons.add, '新建作品', '点右下角「新建作品」，输入作品名即可创建。'),
              HelpItem(Icons.image_outlined, '设置封面', '点卡片「···」→「设置封面」上传自定义卡面背景图。'),
              HelpItem(Icons.open_in_new, '进入作品', '点卡片进入该作品，内部有 人物/关系/世界观/灵感 四个板块。'),
              HelpItem(Icons.delete_outline, '删除作品', '点卡片「···」→「删除」，会连同该作品内的 OC、关系、世界观一并删除。'),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createWork(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('新建作品'),
      ),
      body: works.maybeWhen(
        loading: () => const Center(child: CircularProgressIndicator()),
        orElse: () => list.isEmpty
            ? _Empty(onCreate: () => _createWork(context, ref))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final w = list[i];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        selectWork(ref, w.id);
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 120,
                            child: w.coverPath != null &&
                                    File(w.coverPath!).existsSync()
                                ? Image.file(File(w.coverPath!),
                                    fit: BoxFit.cover)
                                : Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(w.name.characters.first,
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white
                                                  .withValues(alpha: 0.9))),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(w.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () => _showMenu(context, ref, w),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onCreate});
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('还没有作品，创建第一个世界观容器吧'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
            label: const Text('创建作品'),
          ),
        ],
      ),
    );
  }
}
