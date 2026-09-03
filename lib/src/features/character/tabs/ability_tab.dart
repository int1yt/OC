import 'dart:math' as math;

import 'package:drift/drift.dart' hide isNull, Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../data/database.dart';
import '../../../state/providers.dart';

class AbilityTab extends ConsumerWidget {
  const AbilityTab({super.key, required this.ocId});
  final String ocId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oc = ref.watch(ocStreamProvider(ocId)).value;
    final workId = oc?.workId;
    final templates = workId == null
        ? const <DimensionTemplate>[]
        : ref.watch(dimensionsStreamProvider(workId)).value ??
            const <DimensionTemplate>[];
    final abilities = ref.watch(abilityValuesStreamProvider(ocId)).value ??
        const <AbilityValue>[];

    // 合并：模板维度在前，OC 覆盖/新增维度在后
    final merged = <_Dim>[];
    for (final t in templates) {
      final existing =
          abilities.where((a) => a.dimensionName == t.name).toList();
      if (existing.isEmpty) {
        merged.add(_Dim(name: t.name, score: 0, remark: '', id: null));
      } else {
        merged.add(_Dim(
            name: t.name,
            score: existing.first.score,
            remark: existing.first.remark ?? '',
            id: existing.first.id));
      }
    }
    for (final a in abilities) {
      if (!templates.any((t) => t.name == a.dimensionName)) {
        merged.add(_Dim(
            name: a.dimensionName,
            score: a.score,
            remark: a.remark ?? '',
            id: a.id));
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: RadarChart(
            labels: merged.map((d) => d.name).toList(),
            values: merged.map((d) => d.score).toList(),
          ),
        ),
        const SizedBox(height: 8),
        for (final d in merged) _dimRow(context, ref, d),
        TextButton.icon(
          onPressed: merged.length >= 8
              ? null
              : () => _addDim(context, ref),
          icon: const Icon(Icons.add),
          label: Text('添加维度（${merged.length}/8）'),
        ),
      ],
    );
  }

  Widget _dimRow(BuildContext context, WidgetRef ref, _Dim d) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: d.name,
                    decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true),
                    onFieldSubmitted: (v) => _renameDim(ref, d, v.trim()),
                  ),
                ),
                Text('${d.score}',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => _removeDim(ref, d),
                ),
              ],
            ),
            Slider(
              value: d.score.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (v) => _setScore(ref, d, v.round()),
            ),
            TextFormField(
              initialValue: d.remark,
              minLines: 1,
              maxLines: 2,
              decoration: const InputDecoration(
                  hintText: '备注…', border: InputBorder.none, isDense: true),
              onChanged: (v) => _setScore(ref, d, d.score, remark: v),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setScore(WidgetRef ref, _Dim d, int score,
      {String? remark}) async {
    final db = ref.read(databaseProvider);
    if (d.id == null) {
      await db.into(db.abilityValues).insert(AbilityValuesCompanion.insert(
            id: newId(),
            ocId: ocId,
            dimensionName: d.name,
            score: score,
            remark: Value(remark),
          ));
    } else {
      await (db.update(db.abilityValues)..where((t) => t.id.equals(d.id!)))
          .write(AbilityValuesCompanion(
              score: Value(score),
              remark: remark != null ? Value(remark) : const Value.absent()));
    }
  }

  Future<void> _renameDim(WidgetRef ref, _Dim d, String newName) async {
    if (newName.isEmpty) return;
    final db = ref.read(databaseProvider);
    if (d.id == null) {
      await db.into(db.abilityValues).insert(AbilityValuesCompanion.insert(
            id: newId(),
            ocId: ocId,
            dimensionName: newName,
            score: d.score,
            remark: Value(d.remark.isEmpty ? null : d.remark),
          ));
    } else {
      await (db.update(db.abilityValues)..where((t) => t.id.equals(d.id!)))
          .write(AbilityValuesCompanion(dimensionName: Value(newName)));
    }
  }

  Future<void> _removeDim(WidgetRef ref, _Dim d) async {
    final db = ref.read(databaseProvider);
    if (d.id != null) {
      await db.deleteWhere(db.abilityValues, (t) => t.id.equals(d.id!));
    }
  }

  Future<void> _addDim(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加维度'),
        content: TextField(
            controller: ctrl,
            autofocus: true,
            decoration: const InputDecoration(labelText: '维度名'),
            onSubmitted: (v) => Navigator.pop(ctx, v.trim())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
              child: const Text('添加')),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final db = ref.read(databaseProvider);
    await db.into(db.abilityValues).insert(AbilityValuesCompanion.insert(
          id: newId(),
          ocId: ocId,
          dimensionName: name,
          score: 0,
          remark: const Value.absent(),
        ));
  }
}

class _Dim {
  const _Dim(
      {required this.name, required this.score, required this.remark, this.id});
  final String name;
  final int score;
  final String remark;
  final String? id;
}

/// 雷达图（六维可扩展，3~8 维）
class RadarChart extends StatelessWidget {
  const RadarChart({super.key, required this.labels, required this.values});
  final List<String> labels;
  final List<int> values;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CustomPaint(
      size: const Size(260, 220),
      painter: _RadarPainter(
        labels: labels,
        values: values,
        fill: scheme.primary.withValues(alpha: 0.25),
        line: scheme.primary,
        grid: Colors.grey.withValues(alpha: 0.3),
        label: Colors.grey.shade600,
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.labels,
    required this.values,
    required this.fill,
    required this.line,
    required this.grid,
    required this.label,
  });

  final List<String> labels;
  final List<int> values;
  final Color fill;
  final Color line;
  final Color grid;
  final Color label;

  @override
  void paint(Canvas canvas, Size size) {
    if (labels.isEmpty) return;
    final n = labels.length;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 28;

    Offset point(int i, double r) {
      final angle = -math.pi / 2 + 2 * math.pi * i / n;
      return center + Offset(math.cos(angle) * r, math.sin(angle) * r);
    }

    for (int ring = 1; ring <= 4; ring++) {
      final path = Path();
      for (int i = 0; i < n; i++) {
        final p = point(i, radius * ring / 4);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      path.close();
      canvas.drawPath(path, Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = grid);
    }

    for (int i = 0; i < n; i++) {
      canvas.drawLine(center, point(i, radius), Paint()
        ..color = grid
        ..strokeWidth = 1);
    }

    final dataPath = Path();
    for (int i = 0; i < n; i++) {
      final v = (values[i].clamp(0, 10)) / 10;
      final p = point(i, radius * v);
      if (i == 0) {
        dataPath.moveTo(p.dx, p.dy);
      } else {
        dataPath.lineTo(p.dx, p.dy);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, Paint()..color = fill..style = PaintingStyle.fill);
    canvas.drawPath(dataPath, Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2);

    for (int i = 0; i < n; i++) {
      final p = point(i, radius);
      canvas.drawCircle(p, 3, Paint()..color = line);
      final lp = point(i, radius + 16);
      final tp = TextPainter(
        text: TextSpan(
            text: labels[i], style: TextStyle(fontSize: 12, color: label)),
        textDirection: TextDirection.ltr,
      )..layout();
      var dx = lp.dx - tp.width / 2;
      var dy = lp.dy - tp.height / 2;
      dx = dx.clamp(0, size.width - tp.width);
      dy = dy.clamp(0, size.height - tp.height);
      tp.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) =>
      old.labels != labels || old.values != values;
}
