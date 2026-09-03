import 'dart:io';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils.dart';
import '../../core/page_route.dart';
import '../../data/database.dart';
import '../../data/oc_repository.dart';
import '../../state/providers.dart';
import 'character_detail_page.dart';

class CharacterLibraryPage extends ConsumerStatefulWidget {
  const CharacterLibraryPage({super.key});

  @override
  ConsumerState<CharacterLibraryPage> createState() =>
      _CharacterLibraryPageState();
}

class _CharacterLibraryPageState extends ConsumerState<CharacterLibraryPage> {
  String _query = '';
  String? _tagFilter;
  String? _mbtiFilter;
  int _sortMode = 0;

  Future<void> _createOc() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('新建 OC'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '角色姓名'),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('创建'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;

    final db = ref.read(databaseProvider);
    final workId = ref.read(currentWorkIdProvider);
    if (workId == null) return;
    final now = DateTime.now();
    final id = newId();
    await db.into(db.ocs).insert(OcsCompanion.insert(
          id: id,
          workId: workId,
          name: name,
          createdAt: now,
          updatedAt: now,
        ));
    if (!mounted) return;
    await Navigator.push(
      context,
      fadeSlideRoute(CharacterDetailPage(ocId: id)),
    );
  }

  Future<void> _rename(Oc oc) async {
    final controller = TextEditingController(text: oc.name);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重命名'),
        content: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('确定'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final db = ref.read(databaseProvider);
    await (db.update(db.ocs)..where((t) => t.id.equals(oc.id)))
        .write(OcsCompanion(name: Value(name), updatedAt: Value(DateTime.now())));
  }

  Future<void> _delete(Oc oc) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除「${oc.name}」？'),
        content: const Text('该角色参与的关系连线会一并删除。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );
    if (ok != true) return;
    await deleteOc(ref.read(databaseProvider), oc.id);
  }

  Future<void> _copy(Oc oc) async {
    await copyOc(ref.read(databaseProvider), oc.id);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已复制')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final ocs = ref.watch(ocsStreamProvider(workId)).value ?? const <Oc>[];
    final tags = ref.watch(tagsStreamProvider(workId)).value ?? const <Tag>[];
    final ocTagsMap =
        ref.watch(ocTagsMapProvider(workId)).value ?? <String, List<Tag>>{};

    final filtered = ocs.where((oc) {
      if (_query.isNotEmpty) {
        final tagNames = (ocTagsMap[oc.id] ?? []).map((t) => t.name);
        final hay = '${oc.name} ${tagNames.join(' ')}';
        if (!hay.contains(_query)) return false;
      }
      if (_tagFilter != null) {
        final ids = (ocTagsMap[oc.id] ?? []).map((t) => t.id);
        if (!ids.contains(_tagFilter)) return false;
      }
      if (_mbtiFilter != null && oc.mbti != _mbtiFilter) return false;
      return true;
    }).toList();

    filtered.sort((a, b) {
      switch (_sortMode) {
        case 1:
          return a.name.compareTo(b.name);
        case 2:
          return a.createdAt.compareTo(b.createdAt);
        default:
          return b.updatedAt.compareTo(a.updatedAt);
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createOc,
        icon: const Icon(Icons.add),
        label: const Text('新建人物'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                const Text('人物库',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${filtered.length} 个 OC',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    decoration: const InputDecoration(
                      hintText: '按姓名 / 标签搜索',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<int>(
                  onSelected: (v) => setState(() => _sortMode = v),
                  itemBuilder: (ctx) => const [
                    PopupMenuItem(value: 0, child: Text('最近更新')),
                    PopupMenuItem(value: 1, child: Text('姓名')),
                    PopupMenuItem(value: 2, child: Text('创建时间')),
                  ],
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _filterChip('全部标签', _tagFilter == null,
                    () => setState(() => _tagFilter = null)),
                for (final t in tags)
                  _filterChip(t.name, _tagFilter == t.id,
                      () => setState(() => _tagFilter = t.id)),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? _Empty(query: _query, onCreate: _createOc)
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => _OcCard(
                      oc: filtered[i],
                      tags: ocTagsMap[filtered[i].id] ?? const [],
                      onRename: () => _rename(filtered[i]),
                      onDelete: () => _delete(filtered[i]),
                      onCopy: () => _copy(filtered[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _OcCard extends StatelessWidget {
  const _OcCard({
    required this.oc,
    required this.tags,
    required this.onRename,
    required this.onDelete,
    required this.onCopy,
  });

  final Oc oc;
  final List<Tag> tags;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onCopy;

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('重命名'),
              onTap: () {
                Navigator.pop(ctx);
                onRename();
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: const Text('复制'),
              onTap: () {
                Navigator.pop(ctx);
                onCopy();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除'),
              onTap: () {
                Navigator.pop(ctx);
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(
          context,
          fadeSlideRoute(CharacterDetailPage(ocId: oc.id)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: _Avatar(oc: oc, size: 72),
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onPressed: () => _showMenu(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                oc.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              if (oc.mbti != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(oc.mbti!,
                      style: const TextStyle(fontSize: 11)),
                ),
              const SizedBox(height: 4),
              if (tags.isNotEmpty)
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  children: tags
                      .take(3)
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(t.colorValue).withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(t.name,
                                style: const TextStyle(fontSize: 11)),
                          ))
                      .toList(),
                ),
              const Spacer(),
              Text(
                '更新于 ${_fmtTime(oc.updatedAt)}',
                style: TextStyle(
                    fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.oc, this.size = 48});
  final Oc oc;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (oc.avatarPath != null && File(oc.avatarPath!).existsSync()) {
      return ClipOval(
        child: Image.file(File(oc.avatarPath!),
            width: size, height: size, fit: BoxFit.cover),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      child: Text(oc.name.isEmpty ? '?' : oc.name.characters.first),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.query, required this.onCreate});
  final String query;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.face_retouching_natural, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(query.isEmpty ? '还没有 OC，点此创建第一个角色' : '没有匹配的角色'),
          const SizedBox(height: 16),
          if (query.isEmpty)
            FilledButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.add),
                label: const Text('新建人物')),
        ],
      ),
    );
  }
}

String _fmtTime(DateTime t) {
  final now = DateTime.now();
  final d = now.difference(t);
  if (d.inDays == 0) return '今天';
  if (d.inDays == 1) return '昨天';
  if (d.inDays < 30) return '${d.inDays} 天前';
  return DateFormat('yyyy-MM-dd').format(t);
}
