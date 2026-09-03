import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/utils.dart';
import '../../data/database.dart';
import '../../state/providers.dart';
import '../character/tabs/ability_tab.dart';

class ShareCardPage extends ConsumerStatefulWidget {
  const ShareCardPage({super.key, required this.ocId});
  final String ocId;

  @override
  ConsumerState<ShareCardPage> createState() => _ShareCardPageState();
}

class _ShareCardPageState extends ConsumerState<ShareCardPage> {
  final GlobalKey _cardKey = GlobalKey();
  final List<String> _modules = ['avatar', 'name', 'mbti', 'radar', 'catchphrases', 'tags'];
  final List<String> _available = ['avatar', 'name', 'mbti', 'radar', 'catchphrases', 'tags'];
  int _themeIndex = 0;

  static const _themes = [
    Color(0xFFE8A6B8),
    Color(0xFF9FB8E8),
    Color(0xFFC7B7E8),
  ];

  Future<void> _savePng() async {
    final boundary =
        _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = data!.buffer.asUint8List();
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'share_${newId()}.png'));
    await file.writeAsBytes(bytes);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已保存：${file.path}')),
    );
  }

  void _toggle(String m) {
    setState(() {
      if (_modules.contains(m)) {
        _modules.remove(m);
      } else {
        _modules.add(m);
      }
    });
  }

  void _move(String m, int delta) {
    setState(() {
      final i = _modules.indexOf(m);
      final target = i + delta;
      if (i < 0 || target < 0 || target >= _modules.length) return;
      final item = _modules.removeAt(i);
      _modules.insert(target, item);
    });
  }

  String _label(String m) => switch (m) {
        'avatar' => '头像',
        'name' => '姓名',
        'mbti' => 'MBTI',
        'radar' => '六维雷达图',
        'catchphrases' => '口头禅',
        'tags' => '标签',
        _ => m,
      };

  @override
  Widget build(BuildContext context) {
    final oc = ref.watch(ocStreamProvider(widget.ocId)).value;
    if (oc == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final abilities =
        ref.watch(abilityValuesStreamProvider(widget.ocId)).value ??
            const <AbilityValue>[];
    final catchphrases =
        ref.watch(catchphrasesStreamProvider(widget.ocId)).value ??
            const <Catchphrase>[];
    final tagsMap =
        ref.watch(ocTagsMapProvider(oc.workId)).value ?? <String, List<Tag>>{};
    final tags = tagsMap[oc.id] ?? const <Tag>[];
    final theme = _themes[_themeIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('分享卡片'),
        actions: [
          TextButton.icon(
            onPressed: _savePng,
            icon: const Icon(Icons.save_alt),
            label: const Text('保存 PNG'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: RepaintBoundary(
                key: _cardKey,
                child: _Card(
                  theme: theme,
                  oc: oc,
                  modules: _modules,
                  abilities: abilities,
                  catchphrases: catchphrases,
                  tags: tags,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('主题色', style: _s),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var i = 0; i < _themes.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _themeIndex = i),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _themes[i],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: i == _themeIndex
                              ? Colors.black87
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('模块（勾选 + 排序）', style: _s),
            const SizedBox(height: 8),
            for (var i = 0; i < _available.length; i++)
              Card(
                child: ListTile(
                  dense: true,
                  title: Text(_label(_available[i])),
                  leading: Checkbox(
                    value: _modules.contains(_available[i]),
                    onChanged: (_) => _toggle(_available[i]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_modules.contains(_available[i])) ...[
                        IconButton(
                          icon: const Icon(Icons.arrow_upward, size: 18),
                          onPressed: () => _move(_available[i], -1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_downward, size: 18),
                          onPressed: () => _move(_available[i], 1),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

TextStyle get _s => const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

/// 3:4 竖版卡片（逻辑尺寸 320x426.67）
class _Card extends StatelessWidget {
  const _Card({
    required this.theme,
    required this.oc,
    required this.modules,
    required this.abilities,
    required this.catchphrases,
    required this.tags,
  });

  final Color theme;
  final Oc oc;
  final List<String> modules;
  final List<AbilityValue> abilities;
  final List<Catchphrase> catchphrases;
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 426.67,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.withValues(alpha: 0.9), Colors.white],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          for (final m in modules) _block(m),
          const Spacer(),
          Text('— OC 创作台 —',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  Widget _block(String m) {
    switch (m) {
      case 'avatar':
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _CardAvatar(oc: oc),
        );
      case 'name':
        return Text(oc.name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800));
      case 'mbti':
        if (oc.mbti == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(oc.mbti!, style: const TextStyle(fontSize: 13)),
          ),
        );
      case 'radar':
        if (abilities.isEmpty) return const SizedBox.shrink();
        return SizedBox(
          height: 140,
          child: RadarChart(
            labels: abilities.map((a) => a.dimensionName).toList(),
            values: abilities.map((a) => a.score).toList(),
          ),
        );
      case 'catchphrases':
        if (catchphrases.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: catchphrases
                .take(3)
                .map((c) => Text('“${c.phrase}”',
                    style: const TextStyle(fontSize: 13, height: 1.5)))
                .toList(),
          ),
        );
      case 'tags':
        if (tags.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(t.colorValue).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          Text(t.name, style: const TextStyle(fontSize: 11)),
                    ))
                .toList(),
          ),
        );
    }
    return const SizedBox.shrink();
  }
}

class _CardAvatar extends StatelessWidget {
  const _CardAvatar({required this.oc});
  final Oc oc;

  @override
  Widget build(BuildContext context) {
    if (oc.avatarPath != null && File(oc.avatarPath!).existsSync()) {
      return ClipOval(
        child: Image.file(File(oc.avatarPath!),
            width: 72, height: 72, fit: BoxFit.cover),
      );
    }
    return CircleAvatar(
      radius: 36,
      child: Text(oc.name.isEmpty ? '?' : oc.name.characters.first,
          style: const TextStyle(fontSize: 28)),
    );
  }
}
