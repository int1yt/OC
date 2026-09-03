import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../core/constants.dart';
import '../../core/export_util.dart';
import '../../core/image_store.dart';
import '../../core/page_route.dart';
import '../../data/database.dart';
import '../../data/export_service.dart';
import '../../state/providers.dart';
import '../character/character_library_page.dart';
import '../help/help_sheet.dart';
import '../relationship/relationship_graph_page.dart';
import '../saved/saved_page.dart';
import '../work/work_list_page.dart';
import '../world/world_page.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late final AnimationController _fade = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: 1.0,
  );

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }

  void _switchTab(int i) {
    if (i == _index) return;
    setState(() => _index = i);
    _fade.forward(from: 0);
  }

  void _showHelp(BuildContext context) {
    switch (_index) {
      case 0:
        showHelpSheet(context, '人物库', const [
          HelpItem(Icons.grid_view, '卡片网格', '每个 OC 一张卡片，显示头像、姓名、MBTI、标签和更新时间。'),
          HelpItem(Icons.search, '搜索 / 筛选 / 排序', '按姓名或标签搜索，按标签筛选，按更新时间/姓名/创建时间排序。'),
          HelpItem(Icons.add, '新建人物', '点右下角「新建人物」，输入姓名即可创建，之后进入详情补充更多信息。'),
          HelpItem(Icons.more_vert, '卡片菜单', '点卡片右上角「···」可重命名、复制、删除。'),
        ]);
        break;
      case 1:
        showHelpSheet(context, '关系图谱', const [
          HelpItem(Icons.open_with, '平移与缩放', '单指拖动空白处平移，双指或按钮缩放，「适应视图」一键回到全貌。'),
          HelpItem(Icons.circle_outlined, '节点与连线', '拖动节点调整位置；从节点底部圆点拖到另一节点即可建立关系。'),
          HelpItem(Icons.label_outline, '连线查看与编辑', '单击连线弹出气泡卡片（看详情/编辑/删除），双击连线删除。'),
          HelpItem(Icons.palette_outlined, '颜色与图例', '连线颜色按关系强度撞色显示，图例按钮查看；背景可切换纯白/方格。'),
          HelpItem(Icons.save_alt, '导出', '点「导出」把当前关系图存成图片，可查看/分享/删除。'),
          HelpItem(Icons.lock, '锁定', '锁定后仅平移/缩放画布，不响应节点和连线操作。'),
        ]);
        break;
      case 2:
        showHelpSheet(context, '世界观', const [
          HelpItem(Icons.account_tree, '层级树', '创建多级地理结构（大陆→国家→城市→地标），可增删、编辑、移动。'),
          HelpItem(Icons.map, '地图标注', '上传手绘地图并打点标注；拖动图钉可微调位置，可切换/删除地图。'),
          HelpItem(Icons.menu_book, '规则书', '按分区录入设定条目，支持全文搜索。'),
          HelpItem(Icons.checklist, '自检清单', '逐项标记通过/存疑/不适用并写备注，可导出报告。'),
          HelpItem(Icons.save_alt, '导出地图', '在地图页点「导出」把整张地图存成图片。'),
          HelpItem(Icons.lock, '板块锁定', '锁定后四个子 Tab 不能左右滑动切换，便于在地图里缩放拖动。'),
        ]);
        break;
      default:
        showHelpSheet(context, '灵感碎片', const [
          HelpItem(Icons.lightbulb_outline, '即将上线', '快速记录突发灵感的草稿箱，支持文字/语音，敬请期待。'),
        ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    final works = ref.watch(worksStreamProvider);
    Work? work;
    final workList = works.value;
    if (workList != null) {
      for (final w in workList) {
        if (w.id == workId) {
          work = w;
          break;
        }
      }
    }

    final pages = <Widget>[
      const CharacterLibraryPage(),
      const RelationshipGraphPage(),
      const WorldPage(),
      const _Placeholder(title: '灵感碎片', icon: Icons.lightbulb_outline),
    ];

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => Navigator.push(
            context,
            fadeSlideRoute(const WorkListPage()),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  work?.name ?? '选择作品',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more, size: 20),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: '本页帮助',
            onPressed: () => _showHelp(context),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              fadeSlideRoute(const _SettingsPage()),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fade,
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _switchTab,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: '人物'),
          NavigationDestination(
              icon: Icon(Icons.hub_outlined), selectedIcon: Icon(Icons.hub), label: '关系'),
          NavigationDestination(
              icon: Icon(Icons.public), label: '世界观'),
          NavigationDestination(
              icon: Icon(Icons.lightbulb_outline),
              selectedIcon: Icon(Icons.lightbulb),
              label: '灵感'),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text('$title · 即将上线'),
        ],
      ),
    );
  }
}

class _SettingsPage extends ConsumerStatefulWidget {
  const _SettingsPage();

  @override
  ConsumerState<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<_SettingsPage> {
  Future<void> _export() async {
    final db = ref.read(databaseProvider);
    final path = await exportAll(db);
    if (!mounted) return;
    await showExportResult(context, path);
  }

  Future<void> _import() async {
    final exportDir = await getExportDir();
    final files = exportDir.existsSync()
        ? exportDir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.zip'))
            .toList()
        : <File>[];

    if (!mounted) return;
    final chosen = await showDialog<File>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('选择要导入的备份'),
        content: files.isEmpty
            ? const Text('暂无可导入的备份文件。')
            : SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: files
                      .map((f) => ListTile(
                            title: Text(p.basename(f.path)),
                            onTap: () => Navigator.pop(ctx, f),
                          ))
                      .toList(),
                ),
              ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
        ],
      ),
    );
    if (chosen == null) return;
    final count = await importZip(ref.read(databaseProvider), chosen.path);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('已导入 $count 个作品')));
  }

  static const _themeColors = [
    Color(0xFFE8A6B8),
    Color(0xFF9FB8E8),
    Color(0xFFC7B7E8),
    Color(0xFFA8D8C0),
    Color(0xFFF2C9A0),
    Color(0xFF9AC7C7),
  ];

  Future<void> _pickBgImage() async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    await setBgImage(ref, path);
  }

  Future<void> _pickSplashImage() async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    await setSplashImage(ref, path);
  }

  @override
  Widget build(BuildContext context) {
    final seed = ref.watch(themeSeedProvider);
    final bgImage = ref.watch(bgImagePathProvider);
    final bgOpacity = ref.watch(bgOpacityProvider);
    final splashImage = ref.watch(splashImageProvider);
    final strengthColors = ref.watch(strengthColorsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: '本页帮助',
            onPressed: () => showHelpSheet(context, '设置', const [
              HelpItem(Icons.color_lens, '主题颜色', '更换全局配色。'),
              HelpItem(Icons.image_outlined, '应用背景图片', '上传自定义照片作为全屏背景，可调透明度。'),
              HelpItem(Icons.auto_awesome, '开机动画图片', '用自定义图替换默认开机动画。'),
              HelpItem(Icons.palette_outlined, '关系强度颜色', '为五档关系强度各选撞色搭配。'),
              HelpItem(Icons.upload_file, '导出 / 导入', '备份数据为 zip，或从备份恢复。'),
              HelpItem(Icons.folder_outlined, '已保存的内容', '查看 / 分享 / 删除所有已导出的文件。'),
            ]),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('主题颜色',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _themeColors.map((c) {
                final selected = c.toARGB32() == seed;
                return GestureDetector(
                  onTap: () => setThemeSeed(ref, c.toARGB32()),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? Colors.black87 : Colors.black12,
                        width: selected ? 3 : 1,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: const Text('应用背景图片'),
            subtitle: Text(bgImage == null ? '未设置' : '已设置（点击更换）'),
            onTap: _pickBgImage,
          ),
          if (bgImage != null) ...[
            ListTile(
              leading: const Icon(Icons.opacity),
              title: const Text('背景透明度'),
              subtitle: Slider(
                value: bgOpacity,
                min: 0.1,
                max: 1.0,
                onChanged: (v) => setBgOpacity(ref, v),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('清除背景图片'),
              onTap: () => setBgImage(ref, null),
            ),
          ],
          ListTile(
            leading: const Icon(Icons.auto_awesome),
            title: const Text('开机动画图片'),
            subtitle:
                Text(splashImage == null ? '未设置（使用默认动画）' : '已设置（点击更换）'),
            onTap: _pickSplashImage,
          ),
          if (splashImage != null)
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('清除开机图片'),
              onTap: () => setSplashImage(ref, null),
            ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('关系强度颜色',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          for (final s in RelationStrength.all)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.label, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: kColorPairs.map((pair) {
                      final selected = strengthColors[s.label] != null &&
                          strengthColors[s.label]![0] == pair.$1.toARGB32() &&
                          strengthColors[s.label]![1] == pair.$2.toARGB32();
                      return GestureDetector(
                        onTap: () => setStrengthColors(ref, s.label,
                            pair.$1.toARGB32(), pair.$2.toARGB32()),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient:
                                LinearGradient(colors: [pair.$1, pair.$2]),
                            border: Border.all(
                              color:
                                  selected ? Colors.black87 : Colors.black12,
                              width: selected ? 3 : 1,
                            ),
                          ),
                          child: selected
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          const Divider(),
          const ListTile(
            title: Text('论坛'),
            subtitle: Text('默认关闭，MVP 未实现'),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('导出全部数据（zip）'),
            subtitle: const Text('data.json + images，用于备份与迁移'),
            onTap: _export,
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('导入备份'),
            subtitle: const Text('从之前导出的 zip 恢复'),
            onTap: _import,
          ),
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('已保存的内容'),
            subtitle: const Text('查看 / 分享 / 删除已导出的文件'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SavedPage())),
          ),
        ],
      ),
    );
  }
}
