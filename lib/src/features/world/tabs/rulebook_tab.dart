import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class RulebookTab extends ConsumerStatefulWidget {
  const RulebookTab({super.key});

  @override
  ConsumerState<RulebookTab> createState() => _RulebookTabState();
}

class _RulebookTabState extends ConsumerState<RulebookTab> {
  String _query = '';

  Future<void> _addOrEdit(String workId, {RuleEntry? existing}) async {
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    final bodyCtrl = TextEditingController(text: existing?.body ?? '');
    var section = existing?.section ?? kRuleSections.first;

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
                initialValue: section,
                decoration: const InputDecoration(labelText: '分区'),
                items: kRuleSections
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => section = v ?? section),
              ),
              const SizedBox(height: 8),
              TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: '标题')),
              const SizedBox(height: 8),
              TextField(
                  controller: bodyCtrl,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: '正文')),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final db = ref.read(databaseProvider);
                  if (existing == null) {
                    await db.into(db.ruleEntries).insert(
                        RuleEntriesCompanion.insert(
                            id: newId(),
                            workId: workId,
                            section: section,
                            title: titleCtrl.text.trim(),
                            body: bodyCtrl.text.trim()));
                  } else {
                    await (db.update(db.ruleEntries)
                          ..where((t) => t.id.equals(existing.id)))
                        .write(RuleEntriesCompanion(
                            section: Value(section),
                            title: Value(titleCtrl.text.trim()),
                            body: Value(bodyCtrl.text.trim())));
                  }
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final entries =
        ref.watch(ruleEntriesStreamProvider(workId)).value ?? const <RuleEntry>[];

    final filtered = entries.where((e) {
      if (_query.isEmpty) return true;
      return e.title.contains(_query) || e.body.contains(_query);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    hintText: '全文搜索规则条目',
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: '添加条目',
                onPressed: () => _addOrEdit(workId),
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text('暂无规则条目',
                      style: TextStyle(color: Colors.grey.shade500)))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (final section in kRuleSections)
                      if (filtered.any((e) => e.section == section)) ...[
                        Text(section,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        const SizedBox(height: 4),
                        for (final e
                            in filtered.where((e) => e.section == section))
                          Card(
                            child: ListTile(
                              title: Text(e.title),
                              subtitle: Text(e.body,
                                  maxLines: 3, overflow: TextOverflow.ellipsis),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  final db = ref.read(databaseProvider);
                                  db.deleteWhere(
                                      db.ruleEntries, (t) => t.id.equals(e.id));
                                },
                              ),
                              onTap: () => _addOrEdit(workId, existing: e),
                            ),
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
