import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/utils.dart';

/// 从相册选择图片并复制到应用文档目录，返回存储路径
Future<String?> pickAndStoreImage({double? maxWidth}) async {
  final picker = ImagePicker();
  final x = await picker.pickImage(
      source: ImageSource.gallery, maxWidth: maxWidth);
  if (x == null) return null;
  final dir = await getApplicationDocumentsDirectory();
  final imagesDir = Directory(p.join(dir.path, 'images'));
  if (!await imagesDir.exists()) {
    await imagesDir.create(recursive: true);
  }
  final ext = p.extension(x.path).isEmpty ? '.jpg' : p.extension(x.path);
  final dest = p.join(imagesDir.path, '${newId()}$ext');
  await File(x.path).copy(dest);
  return dest;
}
