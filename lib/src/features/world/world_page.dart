import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tabs/checklist_tab.dart';
import 'tabs/location_tree_tab.dart';
import 'tabs/map_tab.dart';
import 'tabs/rulebook_tab.dart';

class WorldPage extends ConsumerStatefulWidget {
  const WorldPage({super.key});

  @override
  ConsumerState<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends ConsumerState<WorldPage> {
  bool _locked = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: '层级树'),
                    Tab(text: '地图'),
                    Tab(text: '规则书'),
                    Tab(text: '自检清单'),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(_locked ? Icons.lock : Icons.lock_open),
                tooltip: _locked ? '解锁（可左右滑动切换）' : '锁定板块（缩放/拖动不切界面）',
                onPressed: () => setState(() => _locked = !_locked),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: _locked
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              children: const [
                LocationTreeTab(),
                MapTab(),
                RulebookTab(),
                ChecklistTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
