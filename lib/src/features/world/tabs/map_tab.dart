import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/image_store.dart';
import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class MapTab extends ConsumerStatefulWidget {
  const MapTab({super.key});

  @override
  ConsumerState<MapTab> createState() => _MapTabState();
}

class _MapTabState extends ConsumerState<MapTab> {
  String? _selectedMapId;
  final TransformationController _transform = TransformationController();
  bool _panMode = false;

  String? _dragPinId;
  Offset _dragPinStartGlobal = Offset.zero;
  Offset _dragPinStartNorm = Offset.zero;
  double _dragPinScale = 1.0;
  Size _dragSize = Size.zero;
  final Map<String, Offset> _pinOverrides = {};

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  Future<Size> _decodeSize(String path) async {
    final bytes = await File(path).readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return Size(frame.image.width.toDouble(), frame.image.height.toDouble());
  }

  Future<void> _uploadMap(String workId) async {
    final path = await pickAndStoreImage();
    if (path == null) return;
    final ctrl = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('地图名称'),
        content: TextField(
            controller: ctrl,
            autofocus: true,
            onSubmitted: (v) => Navigator.pop(ctx, v.trim())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
              child: const Text('添加')),
        ],
      ),
    );
    final db = ref.read(databaseProvider);
    await db.into(db.worldMaps).insert(WorldMapsCompanion.insert(
          id: newId(),
          workId: workId,
          name: name == null || name.isEmpty ? '未命名地图' : name,
          imagePath: path,
        ));
  }

  Future<void> _addPin(String workId, String mapId, Offset norm) async {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加地点标注'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: '地点名称')),
            TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: '简介')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('添加')),
        ],
      ),
    );
    if (ok != true || nameCtrl.text.trim().isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.locations).insert(LocationsCompanion.insert(
          id: newId(),
          workId: workId,
          name: nameCtrl.text.trim(),
          description: descCtrl.text.trim(),
          type: '地点',
          imagesJson: '[]',
          mapId: Value(mapId),
          x: Value(norm.dx),
          y: Value(norm.dy),
        ));
  }

  Future<void> _editPin(Location pin) async {
    final nameCtrl = TextEditingController(text: pin.name);
    final descCtrl = TextEditingController(text: pin.description);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: '名称')),
            const SizedBox(height: 8),
            TextField(
                controller: descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: '简介')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      final db = ref.read(databaseProvider);
                      await (db.update(db.locations)
                            ..where((t) => t.id.equals(pin.id)))
                          .write(LocationsCompanion(
                              name: Value(nameCtrl.text.trim()),
                              description: Value(descCtrl.text.trim())));
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('保存'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    final db = ref.read(databaseProvider);
                    await db.deleteWhere(db.locations, (t) => t.id.equals(pin.id));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onPinPanStart(DragStartDetails d, Location pin, Size size) {
    _dragPinId = pin.id;
    _dragPinStartGlobal = d.globalPosition;
    _dragPinStartNorm = Offset(pin.x!, pin.y!);
    _dragPinScale = _transform.value.getMaxScaleOnAxis();
    _dragSize = size;
  }

  void _onPinPanUpdate(DragUpdateDetails d) {
    if (_dragPinId == null) return;
    final screenDelta = d.globalPosition - _dragPinStartGlobal;
    final childDelta = screenDelta / _dragPinScale;
    final norm = _dragPinStartNorm +
        Offset(childDelta.dx / _dragSize.width, childDelta.dy / _dragSize.height);
    setState(() => _pinOverrides[_dragPinId!] = norm);
  }

  Future<void> _onPinPanEnd() async {
    final id = _dragPinId;
    if (id == null) return;
    final norm = _pinOverrides[id];
    if (norm != null) {
      final db = ref.read(databaseProvider);
      await (db.update(db.locations)..where((t) => t.id.equals(id)))
          .write(LocationsCompanion(x: Value(norm.dx), y: Value(norm.dy)));
    }
    setState(() {
      _pinOverrides.remove(id);
      _dragPinId = null;
    });
  }

  Future<void> _deleteMap(WorldMap map) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除地图「${map.name}」？'),
        content: const Text('该地图上的所有地点标注会一并删除。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
        ],
      ),
    );
    if (ok != true) return;
    final db = ref.read(databaseProvider);
    await db.deleteWhere(db.locations, (t) => t.mapId.equals(map.id));
    await db.deleteWhere(db.worldMaps, (t) => t.id.equals(map.id));
    if (_selectedMapId == map.id) {
      setState(() => _selectedMapId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final workId = ref.watch(currentWorkIdProvider);
    if (workId == null) return const SizedBox.shrink();
    final maps =
        ref.watch(mapsStreamProvider(workId)).value ?? const <WorldMap>[];
    final locations =
        ref.watch(locationsStreamProvider(workId)).value ?? const <Location>[];

    if (_selectedMapId == null && maps.isNotEmpty) {
      _selectedMapId = maps.first.id;
    }
    final selected = maps.where((m) => m.id == _selectedMapId).toList();

    final pins = locations
        .where((l) => l.mapId == _selectedMapId && l.x != null && l.y != null)
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            children: [
              ActionChip(
                avatar: const Icon(Icons.add, size: 16),
                label: const Text('上传地图'),
                onPressed: () => _uploadMap(workId),
              ),
              for (final m in maps)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ChoiceChip(
                    label: Text(m.name),
                    selected: m.id == _selectedMapId,
                    onSelected: (_) => setState(() => _selectedMapId = m.id),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ActionChip(
                  avatar: Icon(_panMode ? Icons.pan_tool : Icons.open_with, size: 16),
                  label: Text(_panMode ? '平移画布' : '打点/移动'),
                  onPressed: () => setState(() => _panMode = !_panMode),
                ),
              ),
              if (selected.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: '删除地图',
                    onPressed: () => _deleteMap(selected.first),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: selected.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.map_outlined, size: 56, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('上传手绘地图，然后在上面打点标注'),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () => _uploadMap(workId),
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: const Text('上传地图'),
                      ),
                    ],
                  ),
                )
              : FutureBuilder<Size>(
                  future: _decodeSize(selected.first.imagePath),
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final size = snap.data!;
                    return InteractiveViewer(
                      transformationController: _transform,
                      panEnabled: _panMode,
                      scaleEnabled: true,
                      minScale: 0.2,
                      maxScale: 5,
                      boundaryMargin: const EdgeInsets.all(200),
                      child: GestureDetector(
                        onTapUp: (d) => _addPin(
                            workId,
                            selected.first.id,
                            Offset(d.localPosition.dx / size.width,
                                d.localPosition.dy / size.height)),
                        child: SizedBox(
                          width: size.width,
                          height: size.height,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.file(File(selected.first.imagePath),
                                    fit: BoxFit.contain),
                              ),
                              for (final pin in pins)
                                Positioned(
                                  left:
                                      (_pinOverrides[pin.id]?.dx ?? pin.x!) *
                                              size.width -
                                          42,
                                  top:
                                      (_pinOverrides[pin.id]?.dy ?? pin.y!) *
                                              size.height -
                                          28,
                                  child: GestureDetector(
                                    onTap: () => _editPin(pin),
                                    onPanStart: (d) =>
                                        _onPinPanStart(d, pin, size),
                                    onPanUpdate: _onPinPanUpdate,
                                    onPanEnd: (_) => _onPinPanEnd(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.location_pin,
                                            color: Colors.red, size: 28),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 84),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: 0.88),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: Colors.black12),
                                          ),
                                          child: Text(
                                            pin.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
