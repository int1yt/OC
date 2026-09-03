import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'utils.dart';

/// 导出目录：优先用外部存储（文件管理器/图库可见），失败退回应用文档目录
Future<Directory> getExportDir() async {
  Directory? ext;
  try {
    ext = await getExternalStorageDirectory();
  } catch (_) {}
  final base = ext ?? await getApplicationDocumentsDirectory();
  final dir = Directory(p.join(base.path, 'OC果子铺'));
  if (!await dir.exists()) await dir.create(recursive: true);
  return dir;
}

/// 把 RepaintBoundary 捕获为 PNG 并保存到导出目录，返回文件路径
Future<String> captureAndSavePng(GlobalKey key, String prefix,
    {double pixelRatio = 3.0}) async {
  final boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: pixelRatio);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = data!.buffer.asUint8List();
  final dir = await getExportDir();
  final file = File(p.join(dir.path, '${prefix}_${newId()}.png'));
  await file.writeAsBytes(bytes);
  return file.path;
}

/// 导出成功后：显示存储位置 + 分享
Future<void> showExportResult(BuildContext context, String path) async {
  await showModalBottomSheet(
    context: context,
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('导出成功',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SelectableText(path,
                  style: const TextStyle(fontSize: 12, height: 1.4)),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                Share.shareXFiles([XFile(path)]);
              },
              icon: const Icon(Icons.share),
              label: const Text('分享'),
            ),
          ],
        ),
      ),
    ),
  );
}
