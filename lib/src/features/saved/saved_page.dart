import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

import '../../core/export_util.dart';

/// 已保存（导出）的内容：可查看、分享、删除，支持批量操作
class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  List<File> _files = [];
  bool _selectMode = false;
  final Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final dir = await getExportDir();
    final files = dir.existsSync()
        ? dir.listSync().whereType<File>().toList()
        : <File>[];
    files.sort(
        (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    if (mounted) setState(() => _files = files);
  }

  Future<void> _delete(List<File> files) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除 ${files.length} 个文件？'),
        content: Text(files.map((f) => p.basename(f.path)).join('\n'),
            maxLines: 6, overflow: TextOverflow.ellipsis),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );
    if (ok != true) return;
    for (final f in files) {
      try {
        await f.delete();
      } catch (_) {}
    }
    _selected.clear();
    _selectMode = false;
    await _load();
  }

  void _share(List<File> files) {
    Share.shareXFiles(files.map((f) => XFile(f.path)).toList());
  }

  void _toggleSelectMode() {
    setState(() {
      _selectMode = !_selectMode;
      if (!_selectMode) _selected.clear();
    });
  }

  void _toggleAll() {
    setState(() {
      if (_selected.length == _files.length) {
        _selected.clear();
      } else {
        _selected.addAll(_files.map((f) => f.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedFiles =
        _files.where((f) => _selected.contains(f.path)).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('已保存的内容'),
        actions: [
          if (_files.isNotEmpty)
            TextButton(
              onPressed: _toggleSelectMode,
              child: Text(_selectMode ? '取消' : '选择'),
            ),
        ],
      ),
      body: _files.isEmpty
          ? const Center(
              child: Text('还没有导出的内容', style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 88),
              itemCount: _files.length,
              itemBuilder: (context, i) {
                final file = _files[i];
                final isPng = file.path.endsWith('.png');
                final modified = file.statSync().modified;
                final checked = _selected.contains(file.path);
                return Card(
                  child: ListTile(
                    leading: _selectMode
                        ? Checkbox(
                            value: checked,
                            onChanged: (_) => setState(() {
                              checked
                                  ? _selected.remove(file.path)
                                  : _selected.add(file.path);
                            }),
                          )
                        : (isPng && file.existsSync()
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(file,
                                    width: 48, height: 48, fit: BoxFit.cover),
                              )
                            : const CircleAvatar(
                                child:
                                    Icon(Icons.insert_drive_file, size: 22))),
                    title: Text(p.basename(file.path),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                        '${modified.year}-${modified.month.toString().padLeft(2, '0')}-${modified.day.toString().padLeft(2, '0')} '
                        '${modified.hour.toString().padLeft(2, '0')}:${modified.minute.toString().padLeft(2, '0')}'),
                    onTap: _selectMode
                        ? () => setState(() {
                              checked
                                  ? _selected.remove(file.path)
                                  : _selected.add(file.path);
                            })
                        : () => OpenFilex.open(file.path),
                    trailing: _selectMode
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () => _share([file]),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _delete([file]),
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
      bottomNavigationBar: _selectMode
          ? BottomAppBar(
              child: Row(
                children: [
                  TextButton(
                    onPressed: _toggleAll,
                    child: Text(_selected.length == _files.length ? '取消全选' : '全选'),
                  ),
                  const Spacer(),
                  Text('已选 ${_selected.length} 项',
                      style: TextStyle(color: Colors.grey.shade600)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: selectedFiles.isEmpty
                        ? null
                        : () => _share(selectedFiles),
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('分享'),
                  ),
                  TextButton.icon(
                    onPressed: selectedFiles.isEmpty
                        ? null
                        : () => _delete(selectedFiles),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('删除'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
