import 'dart:io';

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/image_store.dart';
import '../../core/page_route.dart';
import '../../data/database.dart';
import '../../data/oc_repository.dart';
import '../../state/providers.dart';
import '../share/share_card_page.dart';
import 'tabs/ability_tab.dart';
import 'tabs/appearance_tab.dart';
import 'tabs/personality_tab.dart';
import 'tabs/story_tab.dart';
import 'tabs/timeline_tab.dart';

class CharacterDetailPage extends ConsumerWidget {
  const CharacterDetailPage({super.key, required this.ocId});

  final String ocId;

  Future<void> _updateOc(
      WidgetRef ref, Oc oc, Map<String, dynamic> patch) async {
    final db = ref.read(databaseProvider);
    final companion = OcsCompanion(
      name: patch.containsKey('name')
          ? Value(patch['name'] as String)
          : const Value.absent(),
      age: patch.containsKey('age')
          ? Value(patch['age'] as String?)
          : const Value.absent(),
      gender: patch.containsKey('gender')
          ? Value(patch['gender'] as String?)
          : const Value.absent(),
      birthday: patch.containsKey('birthday')
          ? Value(patch['birthday'] as DateTime?)
          : const Value.absent(),
      constellation: patch.containsKey('constellation')
          ? Value(patch['constellation'] as String?)
          : const Value.absent(),
      avatarPath: patch.containsKey('avatarPath')
          ? Value(patch['avatarPath'] as String?)
          : const Value.absent(),
      mbti: patch.containsKey('mbti')
          ? Value(patch['mbti'] as String?)
          : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
    await (db.update(db.ocs)..where((t) => t.id.equals(oc.id))).write(companion);
  }

  Future<void> _editMeta(BuildContext context, WidgetRef ref, Oc oc) async {
    var age = oc.age ?? '';
    var gender = oc.gender ?? '';
    var constellation = oc.constellation ?? '';
    var birthday = oc.birthday;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('基础元数据',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(labelText: '年龄'),
                    controller: TextEditingController(text: age),
                    onChanged: (v) => age = v,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: gender.isEmpty ? null : gender,
                    decoration: const InputDecoration(labelText: '性别'),
                    items: const ['男', '女', '其他', '无']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (v) => setState(() => gender = v ?? ''),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.cake_outlined),
                    title: Text(birthday == null
                        ? '生日（未设置）'
                        : '生日：${birthday!.year}-${birthday!.month}-${birthday!.day}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: ctx,
                        initialDate: birthday ?? DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (d != null) {
                        setState(() {
                          birthday = d;
                          constellation = zodiacFromDate(d);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(labelText: '星座（可手动覆盖）'),
                    controller: TextEditingController(text: constellation),
                    onChanged: (v) => constellation = v,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () async {
                      await _updateOc(ref, oc, {
                        'age': age.isEmpty ? null : age,
                        'gender': gender.isEmpty ? null : gender,
                        'birthday': birthday,
                        'constellation': constellation.isEmpty ? null : constellation,
                      });
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('保存'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ocAsync = ref.watch(ocStreamProvider(ocId));
    final oc = ocAsync.value;
    if (oc == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('人物详情'),
          actions: [
            IconButton(
              icon: const Icon(Icons.ios_share_outlined),
              tooltip: '分享卡片',
              onPressed: () => Navigator.push(
                context,
                fadeSlideRoute(ShareCardPage(ocId: ocId)),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'delete') {
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
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('删除')),
                      ],
                    ),
                  );
                  if (ok == true && context.mounted) {
                    await deleteOc(ref.read(databaseProvider), ocId);
                    if (context.mounted) Navigator.pop(context);
                  }
                } else if (v == 'copy') {
                  await copyOc(ref.read(databaseProvider), ocId);
                }
              },
              itemBuilder: (ctx) => const [
                PopupMenuItem(value: 'copy', child: Text('复制')),
                PopupMenuItem(value: 'delete', child: Text('删除')),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            _HeaderCard(oc: oc, onEditMeta: () => _editMeta(context, ref, oc)),
            const TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: '外貌特征'),
                Tab(text: '内在性格'),
                Tab(text: '背景故事'),
                Tab(text: '能力量化'),
                Tab(text: '时间轴'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AppearanceTab(ocId: ocId),
                  PersonalityTab(ocId: ocId),
                  StoryTab(ocId: ocId),
                  AbilityTab(ocId: ocId),
                  TimelineTab(ocId: ocId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends ConsumerWidget {
  const _HeaderCard({required this.oc, required this.onEditMeta});

  final Oc oc;
  final VoidCallback onEditMeta;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              final path = await pickAndStoreImage();
              if (path != null) {
                final db = ref.read(databaseProvider);
                await (db.update(db.ocs)..where((t) => t.id.equals(oc.id)))
                    .write(OcsCompanion(
                        avatarPath: Value(path),
                        updatedAt: Value(DateTime.now())));
              }
            },
            child: _HeaderAvatar(oc: oc),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: oc.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    hintText: '姓名',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onFieldSubmitted: (v) {
                    final db = ref.read(databaseProvider);
                    (db.update(db.ocs)..where((t) => t.id.equals(oc.id))).write(
                        OcsCompanion(name: Value(v), updatedAt: Value(DateTime.now())));
                  },
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _metaChip(context, oc.age, '岁'),
                    if (oc.gender != null) _metaChip(context, oc.gender, ''),
                    if (oc.constellation != null)
                      _metaChip(context, oc.constellation, ''),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: onEditMeta,
          ),
        ],
      ),
    );
  }

  Widget _metaChip(BuildContext context, String? value, String suffix) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$value$suffix', style: const TextStyle(fontSize: 12)),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.oc});
  final Oc oc;

  @override
  Widget build(BuildContext context) {
    if (oc.avatarPath != null && File(oc.avatarPath!).existsSync()) {
      return ClipOval(
        child: Image.file(File(oc.avatarPath!),
            width: 64, height: 64, fit: BoxFit.cover),
      );
    }
    return CircleAvatar(
      radius: 32,
      child: Text(oc.name.isEmpty ? '?' : oc.name.characters.first,
          style: const TextStyle(fontSize: 24)),
    );
  }
}
