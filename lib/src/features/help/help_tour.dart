import 'package:flutter/material.dart';

class HelpTourPage extends StatefulWidget {
  const HelpTourPage({super.key});

  @override
  State<HelpTourPage> createState() => _HelpTourPageState();
}

class _HelpTourPageState extends State<HelpTourPage> {
  final PageController _controller = PageController();
  int _index = 0;

  static const _steps = [
    (
      Icons.people_alt_outlined,
      '人物库',
      '在这里创建和管理你的 OC。\n点卡片进入详情，右上角「···」可重命名、复制、删除。'
    ),
    (
      Icons.hub_outlined,
      '关系图谱',
      '拖动空白处平移画布，双指缩放。\n拖动节点调整位置，从节点底部圆点拖到另一节点即可连线。\n双击连线可查看并删除关系。'
    ),
    (
      Icons.public,
      '世界观',
      '用层级树搭地理结构，上传地图打点标注，\n用规则书整理设定，用自检清单检查合理性。'
    ),
    (
      Icons.ios_share_outlined,
      '分享卡片',
      '在人物详情点「分享」生成 3:4 竖版图片，\n可勾选模块、排序、换主题色，一键保存发小红书。'
    ),
    (
      Icons.settings_outlined,
      '设置',
      '换主题颜色、设置应用背景图片、\n导出/导入数据备份。'
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLast = _index == _steps.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('功能导览'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('跳过'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _steps.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) {
                final (icon, title, desc) = _steps[i];
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 60, color: scheme.primary),
                      ),
                      const SizedBox(height: 32),
                      Text(title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 16),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_steps.length, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _index ? scheme.primary : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (isLast) {
                    Navigator.pop(context);
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                    );
                  }
                },
                child: Text(isLast ? '开始使用' : '下一步'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
