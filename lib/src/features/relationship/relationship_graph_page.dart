import 'dart:math' as math;

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/page_route.dart';
import '../../core/utils.dart';
import '../../data/database.dart';
import '../../data/oc_repository.dart';
import '../../state/providers.dart';
import '../character/character_detail_page.dart';

class RelationshipGraphPage extends ConsumerStatefulWidget {
  const RelationshipGraphPage({super.key});

  @override
  ConsumerState<RelationshipGraphPage> createState() =>
      _RelationshipGraphPageState();
}

class _RelationshipGraphPageState extends ConsumerState<RelationshipGraphPage> {
  static const double _canvas = 3000;
  static const Offset _portOffset = Offset(0, 36);

  final Map<String, Offset> _positions = {};
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Size _viewport = Size.zero;
  bool _didFit = false;
  bool _showLegend = false;

  String? _dragNodeId;
  Offset? _dragNodeStartPos;
  String? _connectSource;
  Offset? _tempLine;
  Offset _gestureStartFocalCanvas = Offset.zero;
  double _gestureStartScale = 1.0;

  String? _selectedEdgeId;
  String? _lastTapEdgeId;
  DateTime? _lastTapEdgeTime;
  Relationship? _bubbleEdge;
  Offset? _bubbleScreenPos;
  bool _grid = false;
  bool _locked = false;

  Offset _toCanvas(Offset local) => (local - _offset) / _scale;

  Offset _portOf(String ocId) => _positions[ocId]! + _portOffset;

  Offset _defaultPos(List<Oc> ocs, int index) {
    final count = math.max(1, ocs.length);
    final radius = math.max(150.0, 60.0 * count);
    final angle = 2 * math.pi * index / count - math.pi / 2;
    return Offset(
      _canvas / 2 + math.cos(angle) * radius,
      _canvas / 2 + math.sin(angle) * radius,
    );
  }

  void _ensurePositions(List<Oc> ocs) {
    for (var i = 0; i < ocs.length; i++) {
      final oc = ocs[i];
      if (_positions.containsKey(oc.id)) continue;
      if (oc.posX != null && oc.posY != null) {
        _positions[oc.id] = Offset(oc.posX!, oc.posY!);
      } else {
        _positions[oc.id] = _defaultPos(ocs, i);
      }
    }
  }

  Rect _nodeRect(Offset c) =>
      Rect.fromCenter(center: c, width: 84, height: 84);

  bool _isPort(Offset local, Offset c) {
    final port = c + _portOffset;
    return (local - port).distance <= 14;
  }

  void _fitView(List<Oc> ocs) {
    if (ocs.isEmpty || _viewport == Size.zero) return;
    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    for (final oc in ocs) {
      final p = _positions[oc.id]!;
      minX = math.min(minX, p.dx);
      minY = math.min(minY, p.dy);
      maxX = math.max(maxX, p.dx);
      maxY = math.max(maxY, p.dy);
    }
    final w = math.max(maxX - minX, 1.0);
    final h = math.max(maxY - minY, 1.0);
    final s = math
        .min(_viewport.width / (w + 110), _viewport.height / (h + 130))
        .clamp(0.3, 1.8);
    final center = Offset((minX + maxX) / 2, (minY + maxY) / 2);
    setState(() {
      _scale = s;
      _offset =
          Offset(_viewport.width / 2, _viewport.height / 2) - center * s;
    });
  }

  double _distToSeg(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final len2 = ab.dx * ab.dx + ab.dy * ab.dy;
    if (len2 == 0) return (p - a).distance;
    var t = ((p - a).dx * ab.dx + (p - a).dy * ab.dy) / len2;
    t = t.clamp(0.0, 1.0);
    final proj = a + ab * t;
    return (p - proj).distance;
  }

  Relationship? _edgeAt(Offset canvas, List<Relationship> rels) {
    for (final r in rels) {
      final s = _positions[r.sourceOcId];
      final t = _positions[r.targetOcId];
      if (s == null || t == null) continue;
      if (_distToSeg(canvas, s + _portOffset, t + _portOffset) < 12) {
        return r;
      }
    }
    return null;
  }

  void _onScaleStart(ScaleStartDetails d, List<Oc> ocs) {
    final canvas = _toCanvas(d.localFocalPoint);
    _gestureStartFocalCanvas = canvas;
    _gestureStartScale = _scale;
    _dragNodeId = null;
    _connectSource = null;
    if (_locked) return;
    for (final oc in ocs) {
      if (_isPort(canvas, _positions[oc.id]!)) {
        _connectSource = oc.id;
        _tempLine = canvas;
        return;
      }
    }
    for (final oc in ocs) {
      if (_nodeRect(_positions[oc.id]!).contains(canvas)) {
        _dragNodeId = oc.id;
        _dragNodeStartPos = _positions[oc.id]!;
        return;
      }
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails d) {
    final canvas = _toCanvas(d.localFocalPoint);
    if (_connectSource != null) {
      setState(() => _tempLine = canvas);
    } else if (_dragNodeId != null) {
      final delta = canvas - _gestureStartFocalCanvas;
      setState(() {
        _positions[_dragNodeId!] = _dragNodeStartPos! + delta;
      });
    } else {
      final newScale = (_gestureStartScale * d.scale).clamp(0.2, 4.0);
      setState(() {
        _scale = newScale;
        _offset = d.localFocalPoint - _gestureStartFocalCanvas * newScale;
      });
    }
  }

  Future<void> _onScaleEnd(
      ScaleEndDetails d, List<Oc> ocs, String workId) async {
    if (_connectSource != null) {
      final target = _tempLine;
      for (final oc in ocs) {
        if (oc.id == _connectSource) continue;
        if (target != null && _nodeRect(_positions[oc.id]!).contains(target)) {
          await _openEditor(_connectSource!, oc.id, workId);
          break;
        }
      }
      setState(() {
        _connectSource = null;
        _tempLine = null;
      });
      return;
    }
    if (_dragNodeId != null) {
      final pos = _positions[_dragNodeId!]!;
      final db = ref.read(databaseProvider);
      await (db.update(db.ocs)..where((t) => t.id.equals(_dragNodeId!)))
          .write(OcsCompanion(posX: Value(pos.dx), posY: Value(pos.dy)));
      _dragNodeId = null;
    }
  }

  void _onTapUp(TapUpDetails d, List<Oc> ocs, List<Relationship> rels) {
    if (_locked) return;
    final canvas = _toCanvas(d.localPosition);
    final edge = _edgeAt(canvas, rels);
    if (edge != null) {
      final now = DateTime.now();
      if (_lastTapEdgeId == edge.id &&
          _lastTapEdgeTime != null &&
          now.difference(_lastTapEdgeTime!).inMilliseconds < 400) {
        _edgeMenu(edge);
        _lastTapEdgeId = null;
        setState(() {
          _selectedEdgeId = null;
          _bubbleEdge = null;
        });
        return;
      }
      _lastTapEdgeId = edge.id;
      _lastTapEdgeTime = now;
      final s = _positions[edge.sourceOcId];
      final t = _positions[edge.targetOcId];
      Offset? screenPos;
      if (s != null && t != null) {
        final midCanvas = (s + _portOffset + t + _portOffset) / 2;
        screenPos = midCanvas * _scale + _offset;
      }
      setState(() {
        _selectedEdgeId = edge.id;
        _bubbleEdge = edge;
        _bubbleScreenPos = screenPos;
      });
      return;
    }
    _lastTapEdgeId = null;
    setState(() {
      _selectedEdgeId = null;
      _bubbleEdge = null;
    });
    for (final oc in ocs) {
      if (_nodeRect(_positions[oc.id]!).contains(canvas)) {
        _nodeMenu(oc);
        return;
      }
    }
  }

  void _nodeMenu(Oc oc) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(oc.name),
              subtitle: Text(oc.mbti ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: const Text('查看详情'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  fadeSlideRoute(CharacterDetailPage(ocId: oc.id)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('从这里连线…'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _connectSource = oc.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除'),
              onTap: () async {
                Navigator.pop(ctx);
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (d) => AlertDialog(
                    title: Text('删除「${oc.name}」？'),
                    content: const Text('该角色参与的关系连线会一并删除。'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(d, false),
                          child: const Text('取消')),
                      FilledButton(
                          onPressed: () => Navigator.pop(d, true),
                          child: const Text('删除')),
                    ],
                  ),
                );
                if (ok == true) {
                  await deleteOc(ref.read(databaseProvider), oc.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _edgeMenu(Relationship r) async {
    final db = ref.read(databaseProvider);
    final source =
        await (db.select(db.ocs)..where((t) => t.id.equals(r.sourceOcId)))
            .getSingleOrNull();
    final target =
        await (db.select(db.ocs)..where((t) => t.id.equals(r.targetOcId)))
            .getSingleOrNull();
    if (!mounted) return;
    final strength = RelationStrength.fromLabel(r.strength);
    await showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 6,
                backgroundColor: RelationStrength.fromLabel(r.strength).color,
              ),
              title: Text('${source?.name ?? '?'} → ${target?.name ?? '?'}'),
              subtitle: Text('${r.label} · ${strength.label}'),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('编辑'),
              onTap: () {
                Navigator.pop(ctx);
                _editEdge(r);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('删除这条关系',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(ctx);
                await db.deleteWhere(db.relationships, (t) => t.id.equals(r.id));
                if (mounted) {
                  setState(() {
                    _selectedEdgeId = null;
                    _bubbleEdge = null;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editEdge(Relationship r) async {
    final db = ref.read(databaseProvider);
    final source =
        await (db.select(db.ocs)..where((t) => t.id.equals(r.sourceOcId)))
            .getSingle();
    final target =
        await (db.select(db.ocs)..where((t) => t.id.equals(r.targetOcId)))
            .getSingle();
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _RelationshipEditor(
          sourceOcId: r.sourceOcId,
          targetOcId: r.targetOcId,
          workId: r.workId,
          sourceName: source.name,
          targetName: target.name,
          existing: r),
    );
    if (mounted) {
      setState(() {
        _bubbleEdge = null;
        _selectedEdgeId = null;
      });
    }
  }

  Future<void> _openEditor(
      String sourceId, String targetId, String workId) async {
    final db = ref.read(databaseProvider);
    final oc1 =
        await (db.select(db.ocs)..where((t) => t.id.equals(sourceId))).getSingle();
    final oc2 =
        await (db.select(db.ocs)..where((t) => t.id.equals(targetId))).getSingle();
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _RelationshipEditor(
          sourceOcId: sourceId,
          targetOcId: targetId,
          workId: workId,
          sourceName: oc1.name,
          targetName: oc2.name),
    );
  }

  double _strengthWeight(String label) {
    switch (label) {
      case '亲密':
        return 3.0;
      case '友好':
        return 2.0;
      case '疏远':
        return 1.0;
      case '敌对':
        return 0.4;
      case '仇视':
        return 0.15;
      default:
        return 1.0;
    }
  }

  /// 力导向排版：亲密的关系靠得更近，疏远/敌对离得更远
  void _forceLayout(List<Oc> ocs, List<Relationship> rels) {
    final pos = <String, Offset>{};
    for (var i = 0; i < ocs.length; i++) {
      pos[ocs[i].id] = _defaultPos(ocs, i);
    }
    final n = pos.length;
    if (n < 2) {
      _positions
        ..clear()
        ..addAll(pos);
      return;
    }

    final k = 160.0 + n * 3.0;
    const iterations = 200;

    for (int iter = 0; iter < iterations; iter++) {
      final disp = <String, Offset>{
        for (final id in pos.keys) id: Offset.zero
      };
      final ids = pos.keys.toList();

      for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
          final a = pos[ids[i]]!;
          final b = pos[ids[j]]!;
          var delta = a - b;
          var dist = delta.distance;
          if (dist < 1) dist = 1;
          final force = k * k / dist;
          final dir = delta / dist;
          disp[ids[i]] = disp[ids[i]]! + dir * force;
          disp[ids[j]] = disp[ids[j]]! - dir * force;
        }
      }

      for (final r in rels) {
        final a = pos[r.sourceOcId];
        final b = pos[r.targetOcId];
        if (a == null || b == null) continue;
        var delta = a - b;
        var dist = delta.distance;
        if (dist < 1) dist = 1;
        final w = _strengthWeight(r.strength);
        final force = dist * dist / k * w;
        final dir = delta / dist;
        disp[r.sourceOcId] = disp[r.sourceOcId]! - dir * force;
        disp[r.targetOcId] = disp[r.targetOcId]! + dir * force;
      }

      final temp = 30.0 * (1 - iter / iterations) + 0.5;
      for (final id in ids) {
        var d = disp[id]!;
        final len = d.distance;
        if (len > temp) d = d / len * temp;
        pos[id] = pos[id]! + d;
      }
    }

    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    for (final p in pos.values) {
      minX = math.min(minX, p.dx);
      minY = math.min(minY, p.dy);
      maxX = math.max(maxX, p.dx);
      maxY = math.max(maxY, p.dy);
    }
    final shift = Offset(
        _canvas / 2 - (minX + maxX) / 2, _canvas / 2 - (minY + maxY) / 2);
    _positions
      ..clear()
      ..addAll(pos.map((id, v) => MapEntry(id, v + shift)));
  }

  Future<void> _autoLayout(List<Oc> ocs, List<Relationship> rels) async {
    _forceLayout(ocs, rels);
    setState(() {});
    _fitView(ocs);
    final db = ref.read(databaseProvider);
    for (final oc in ocs) {
      final pos = _positions[oc.id]!;
      await (db.update(db.ocs)..where((t) => t.id.equals(oc.id)))
          .write(OcsCompanion(posX: Value(pos.dx), posY: Value(pos.dy)));
    }
  }

  Future<void> _newNode(String workId) async {
    final ctrl = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('新建 OC 节点'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
              child: const Text('创建')),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    await db.into(db.ocs).insert(OcsCompanion.insert(
          id: newId(),
          workId: workId,
          name: name,
          createdAt: now,
          updatedAt: now,
        ));
  }

  void _zoomBy(double factor) {
    if (_viewport == Size.zero) return;
    final newScale = (_scale * factor).clamp(0.2, 4.0);
    final center = Offset(_viewport.width / 2, _viewport.height / 2);
    final canvasCenter = _toCanvas(center);
    setState(() {
      _scale = newScale;
      _offset = center - canvasCenter * newScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final ocs = ref.watch(ocsStreamProvider(workId)).value ?? const <Oc>[];
    final rels =
        ref.watch(relationshipsStreamProvider(workId)).value ?? const <Relationship>[];
    final strengthColors = ref.watch(strengthColorsProvider);
    _ensurePositions(ocs);

    final edges = <_Edge>[];
    for (final r in rels) {
      final s = _positions[r.sourceOcId];
      final t = _positions[r.targetOcId];
      if (s == null || t == null) continue;
      edges.add(_Edge(s + _portOffset, t + _portOffset, r.strength, r.direction,
          r.id, r.label));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newNode(workId),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _toolbar(ocs, rels),
          Expanded(
            child: Stack(
              children: [
                LayoutBuilder(builder: (context, c) {
                  _viewport = Size(c.maxWidth, c.maxHeight);
                  if (!_didFit && ocs.isNotEmpty) {
                    _didFit = true;
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _fitView(ocs));
                  }
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (d) => _onTapUp(d, ocs, rels),
                    onScaleStart: (d) => _onScaleStart(d, ocs),
                    onScaleUpdate: _onScaleUpdate,
                    onScaleEnd: (d) => _onScaleEnd(d, ocs, workId),
                    child: ClipRect(
                      child: Transform(
                        alignment: Alignment.topLeft,
                        transform: Matrix4.translationValues(
                                _offset.dx, _offset.dy, 0)
                          ..scaleByDouble(_scale, _scale, _scale, 1.0),
                        child: OverflowBox(
                          alignment: Alignment.topLeft,
                          minWidth: 0,
                          maxWidth: double.infinity,
                          minHeight: 0,
                          maxHeight: double.infinity,
                          child: SizedBox(
                            width: _canvas,
                            height: _canvas,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _GridPainter(grid: _grid),
                                  ),
                                ),
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _EdgesPainter(
                                      edges: edges,
                                      colors: strengthColors,
                                      tempStart: _connectSource != null
                                          ? _portOf(_connectSource!)
                                          : null,
                                      tempEnd: _tempLine,
                                      selectedEdgeId: _selectedEdgeId,
                                    ),
                                  ),
                                ),
                                for (final oc in ocs)
                                  _NodeWidget(
                                    oc: oc,
                                    position: _positions[oc.id]!,
                                    connecting: _connectSource == oc.id,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                if (_bubbleEdge != null && _bubbleScreenPos != null)
                  Positioned(
                    left: (_bubbleScreenPos!.dx - 90)
                        .clamp(8.0, _viewport.width - 188.0)
                        .toDouble(),
                    top: (_bubbleScreenPos!.dy - 120)
                        .clamp(8.0, _viewport.height - 170.0)
                        .toDouble(),
                    child: _EdgeBubble(
                      edge: _bubbleEdge!,
                      onEdit: () => _editEdge(_bubbleEdge!),
                      onDelete: () async {
                        final db = ref.read(databaseProvider);
                        await db.deleteWhere(db.relationships,
                            (t) => t.id.equals(_bubbleEdge!.id));
                        if (mounted) {
                          setState(() {
                            _bubbleEdge = null;
                            _selectedEdgeId = null;
                          });
                        }
                      },
                      onClose: () => setState(() {
                        _bubbleEdge = null;
                        _selectedEdgeId = null;
                      }),
                    ),
                  ),
                if (_showLegend)
                  Positioned(top: 8, right: 8, child: _Legend()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar(List<Oc> ocs, List<Relationship> rels) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: '放大',
            onPressed: () => _zoomBy(1.2),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: '缩小',
            onPressed: () => _zoomBy(1 / 1.2),
          ),
          IconButton(
            icon: const Icon(Icons.fit_screen),
            tooltip: '适应视图',
            onPressed: () => _fitView(ocs),
          ),
          TextButton.icon(
            onPressed: () => _autoLayout(ocs, rels),
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text('排版'),
          ),
          IconButton(
            icon: Icon(_grid ? Icons.grid_on : Icons.grid_off),
            tooltip: _grid ? '切换为纯白背景' : '切换为方格背景',
            onPressed: () => setState(() => _grid = !_grid),
          ),
          IconButton(
            icon: Icon(_locked ? Icons.lock : Icons.lock_open),
            tooltip: _locked ? '解锁' : '锁定（仅平移缩放）',
            onPressed: () => setState(() => _locked = !_locked),
          ),
          IconButton(
            icon: Icon(_showLegend
                ? Icons.legend_toggle
                : Icons.legend_toggle_outlined),
            tooltip: '图例',
            onPressed: () => setState(() => _showLegend = !_showLegend),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 4),
            child: Text('${ocs.length} 个角色',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _EdgeBubble extends StatelessWidget {
  const _EdgeBubble({
    required this.edge,
    required this.onEdit,
    required this.onDelete,
    required this.onClose,
  });

  final Relationship edge;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final strength = RelationStrength.fromLabel(edge.strength);
    final color = strength.color;
    final dirText = switch (edge.direction) {
      kDirectionForward => '单向 →',
      kDirectionBackward => '单向 ←',
      _ => '双向',
    };
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(14),
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        width: 180,
        padding: const EdgeInsets.fromLTRB(12, 10, 4, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 6, backgroundColor: color),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(edge.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                ),
                InkWell(
                  onTap: onClose,
                  child: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '强度：'),
                  TextSpan(
                    text: strength.label,
                    style: TextStyle(color: color, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' · $dirText'),
                ],
              ),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            if (edge.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 8),
                child: Text(edge.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onDelete,
                  child: const Text('删除',
                      style: TextStyle(fontSize: 12, color: Colors.red)),
                ),
                TextButton(onPressed: onEdit, child: const Text('编辑')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NodeWidget extends StatelessWidget {
  const _NodeWidget({
    required this.oc,
    required this.position,
    required this.connecting,
  });

  final Oc oc;
  final Offset position;
  final bool connecting;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Positioned(
      left: position.dx - 42,
      top: position.dy - 42,
      width: 84,
      height: 84,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scheme.primaryContainer, scheme.secondaryContainer],
              ),
              border: Border.all(
                color: connecting ? scheme.primary : Colors.white,
                width: connecting ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 9,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  oc.name.isEmpty ? '?' : oc.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.primary,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.grid});
  final bool grid;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
    if (!grid) return;
    const spacing = 24.0;
    final dot = Paint()
      ..color = Colors.grey.withValues(alpha: 0.35);
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => old.grid != grid;
}

class _Edge {
  _Edge(this.start, this.end, this.strength, this.direction, this.id,
      this.label);
  final Offset start;
  final Offset end;
  final String strength;
  final int direction;
  final String id;
  final String label;
}

class _EdgesPainter extends CustomPainter {
  _EdgesPainter({
    required this.edges,
    required this.colors,
    this.tempStart,
    this.tempEnd,
    this.selectedEdgeId,
  });

  final List<_Edge> edges;
  final Map<String, List<int>> colors;
  final Offset? tempStart;
  final Offset? tempEnd;
  final String? selectedEdgeId;

  (Color, Color) _pair(String strength) {
    final pair = colors[strength] ?? const [0xFF9E9E9E, 0xFFB0BEC5];
    return (Color(pair[0]), Color(pair[1]));
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in edges) {
      final selected = e.id == selectedEdgeId;
      final strength = RelationStrength.fromLabel(e.strength);
      final dir = e.end - e.start;
      final len = dir.distance;
      final normal = len == 0 ? Offset.zero : Offset(-dir.dy, dir.dx) / len;
      final labelPos = (e.start + e.end) / 2 + normal * 18;
      if (selected) {
        _drawLine(canvas, e.start, e.end, Colors.black, Colors.black, strength,
            arrowAtEnd: e.direction == kDirectionForward,
            arrowAtStart: e.direction == kDirectionBackward,
            selected: true);
        _drawLabel(canvas, labelPos, e.label, Colors.black);
      } else {
        final (c1, c2) = _pair(e.strength);
        _drawLine(canvas, e.start, e.end, c1, c2, strength,
            arrowAtEnd: e.direction == kDirectionForward,
            arrowAtStart: e.direction == kDirectionBackward);
        _drawLabel(canvas, labelPos, e.label, c1);
      }
    }
    if (tempStart != null && tempEnd != null) {
      _drawLine(canvas, tempStart!, tempEnd!, Colors.blueGrey, Colors.blueGrey,
          RelationStrength.all[0],
          dashed: true);
    }
  }

  void _drawLabel(Canvas canvas, Offset mid, String label, Color color) {
    if (label.isEmpty) return;
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600, color: color),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final rect = Rect.fromCenter(
        center: mid, width: tp.width + 16, height: tp.height + 8);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(12)),
        Paint()..color = Colors.white.withValues(alpha: 0.92));
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(12)),
        Paint()
          ..color = color.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    tp.paint(canvas, Offset(mid.dx - tp.width / 2, mid.dy - tp.height / 2));
  }

  void _drawLine(Canvas canvas, Offset a, Offset b, Color c1, Color c2,
      RelationStrength s,
      {bool arrowAtEnd = false,
      bool arrowAtStart = false,
      bool dashed = false,
      bool selected = false}) {
    final width = selected ? 4.0 : (s.isBold ? 3.0 : 2.0);
    final isDashed = dashed || s.isDashed;

    final rect = Rect.fromPoints(a, b);
    final linePaint = Paint()
      ..shader = LinearGradient(colors: [c1, c2]).createShader(rect)
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    if (isDashed) {
      _drawDashed(canvas, a, b, linePaint);
    } else {
      canvas.drawLine(a, b, Paint()
        ..color = c1.withValues(alpha: selected ? 0.35 : 0.25)
        ..strokeWidth = width + 7
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
      canvas.drawLine(a, b, linePaint);
    }
    if (arrowAtEnd) _arrow(canvas, a, b, c2);
    if (arrowAtStart) _arrow(canvas, b, a, c1);
  }

  void _drawDashed(Canvas canvas, Offset a, Offset b, Paint paint) {
    const dash = 8.0;
    final total = (b - a).distance;
    final dir = (b - a) / total;
    for (double d = 0; d < total; d += dash * 2) {
      final p1 = a + dir * d;
      final p2 = a + dir * math.min(d + dash, total);
      canvas.drawLine(p1, p2, paint);
    }
  }

  void _arrow(Canvas canvas, Offset from, Offset to, Color color) {
    final dir = (to - from);
    final len = dir.distance;
    final unit = dir / len;
    const arrowLen = 10.0;
    final base = to - unit * arrowLen;
    final normal = Offset(-unit.dy, unit.dx);
    final p1 = base + normal * 5;
    final p2 = base - normal * 5;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    canvas.drawLine(base - unit * 2, to, paint);
    canvas.drawLine(p1, to, paint);
    canvas.drawLine(p2, to, paint);
  }

  @override
  bool shouldRepaint(covariant _EdgesPainter old) =>
      old.edges != edges ||
      old.tempStart != tempStart ||
      old.tempEnd != tempEnd ||
      old.selectedEdgeId != selectedEdgeId ||
      old.colors != colors;
}

class _Legend extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(strengthColorsProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('关系强度',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            const SizedBox(height: 8),
            for (final s in RelationStrength.all)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomPaint(
                      size: const Size(26, 6),
                      painter: _LegendLinePainter(
                          s,
                          colors[s.label] ??
                              [s.color.toARGB32(), s.color2.toARGB32()]),
                    ),
                    const SizedBox(width: 8),
                    Text(s.label, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendLinePainter extends CustomPainter {
  _LegendLinePainter(this.s, this.pair);
  final RelationStrength s;
  final List<int> pair;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(pair[0]), Color(pair[1])],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = s.isBold ? 4 : 2
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    if (s.isDashed) {
      for (double d = 0; d < size.width; d += 9) {
        canvas.drawLine(Offset(d, y),
            Offset(math.min(d + 5, size.width), y), paint);
      }
    } else {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LegendLinePainter old) =>
      old.s != s || old.pair != pair;
}

class _RelationshipEditor extends ConsumerStatefulWidget {
  const _RelationshipEditor({
    required this.sourceOcId,
    required this.targetOcId,
    required this.workId,
    required this.sourceName,
    required this.targetName,
    this.existing,
  });

  final String sourceOcId;
  final String targetOcId;
  final String workId;
  final String sourceName;
  final String targetName;
  final Relationship? existing;

  @override
  ConsumerState<_RelationshipEditor> createState() =>
      _RelationshipEditorState();
}

class _RelationshipEditorState extends ConsumerState<_RelationshipEditor> {
  String _label = kPresetRelationLabels.first;
  final TextEditingController _customLabel = TextEditingController();
  String _strength = '亲密';
  int _direction = kDirectionBidirectional;
  final TextEditingController _desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _strength = e.strength;
      _direction = e.direction;
      _desc.text = e.description;
      if (kPresetRelationLabels.contains(e.label)) {
        _label = e.label;
      } else {
        _customLabel.text = e.label;
      }
    }
  }

  Future<void> _save() async {
    final label = _customLabel.text.trim().isEmpty
        ? _label
        : _customLabel.text.trim();
    final db = ref.read(databaseProvider);
    if (widget.existing != null) {
      await (db.update(db.relationships)
            ..where((t) => t.id.equals(widget.existing!.id)))
          .write(RelationshipsCompanion(
              label: Value(label),
              strength: Value(_strength),
              direction: Value(_direction),
              description: Value(_desc.text.trim())));
    } else {
      await db.into(db.relationships).insert(RelationshipsCompanion.insert(
            id: newId(),
            workId: widget.workId,
            sourceOcId: widget.sourceOcId,
            targetOcId: widget.targetOcId,
            label: label,
            strength: _strength,
            direction: _direction,
            description: _desc.text.trim(),
          ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${widget.sourceName} ↔ ${widget.targetName}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 12),
            const Text('关系标签'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: kPresetRelationLabels
                  .map((l) => ChoiceChip(
                        label: Text(l),
                        selected: _label == l,
                        onSelected: (_) => setState(() => _label = l),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _customLabel,
              decoration: const InputDecoration(hintText: '自定义标签…'),
            ),
            const SizedBox(height: 16),
            const Text('关系强度'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: RelationStrength.all
                  .map((s) => ChoiceChip(
                        label: Text(s.label),
                        selected: _strength == s.label,
                        onSelected: (_) => setState(() => _strength = s.label),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text('方向'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: [
                ButtonSegment(
                    value: kDirectionBidirectional,
                    label: Text('${widget.sourceName} ↔ ${widget.targetName}')),
                ButtonSegment(
                    value: kDirectionForward,
                    label: Text('${widget.sourceName} → ${widget.targetName}')),
                ButtonSegment(
                    value: kDirectionBackward,
                    label: Text('${widget.targetName} → ${widget.sourceName}')),
              ],
              selected: {_direction},
              onSelectionChanged: (s) =>
                  setState(() => _direction = s.first),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(hintText: '关系说明…'),
            ),
            const SizedBox(height: 16),
            FilledButton(
                onPressed: _save,
                child: Text(widget.existing == null ? '保存关系' : '更新关系')),
          ],
        ),
      ),
    );
  }
}
