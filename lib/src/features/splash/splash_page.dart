import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 开机动画：铅笔手绘风螺线松树（一深一浅盘旋）+ 棱面立体星 + 树周亮光小星
/// （可选自定义图替换）
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onFinished, this.splashImage});
  final VoidCallback onFinished;
  final String? splashImage;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _fill = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2400))
    ..forward();
  late final AnimationController _wave = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..repeat();
  late final AnimationController _enter = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2900), widget.onFinished);
  }

  @override
  void dispose() {
    _fill.dispose();
    _wave.dispose();
    _enter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final scale = Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: _enter, curve: Curves.easeOutBack));
    final hasCustom =
        widget.splashImage != null && File(widget.splashImage!).existsSync();
    return Scaffold(
      body: Container(
        // 素描纸底色（暖米色 / 墨蓝夜色）
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.15),
            radius: 1.5,
            colors: dark
                ? const [
                    Color(0xFF18241D),
                    Color(0xFF101713),
                    Color(0xFF0B100D),
                  ]
                : const [
                    Color(0xFFFFFCF3),
                    Color(0xFFFAF2DE),
                    Color(0xFFF2E8CF),
                  ],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: scale,
            child: AnimatedBuilder(
              animation: Listenable.merge([_fill, _wave]),
              builder: (context, _) {
                final progress =
                    Curves.easeInOut.transform(_fill.value).clamp(0.0, 1.0);
                if (hasCustom) {
                  return SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRect(
                      clipper: _BottomRevealClipper(progress),
                      child: Image.file(File(widget.splashImage!),
                          width: 200, height: 200, fit: BoxFit.contain),
                    ),
                  );
                }
                return CustomPaint(
                  size: const Size(200, 240),
                  painter: _PencilTreePainter(
                    progress: progress,
                    phase: _wave.value * 2 * math.pi,
                    dark: dark,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// 从底部向上裁剪（进度 0→1 逐渐露出），用于自定义开机图
class _BottomRevealClipper extends CustomClipper<Rect> {
  _BottomRevealClipper(this.progress);
  final double progress;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(0, size.height * (1 - progress), size.width, size.height);

  @override
  bool shouldReclip(_BottomRevealClipper old) => old.progress != progress;
}

/// ============ 铅笔手绘螺线松树 ============
class _PencilTreePainter extends CustomPainter {
  _PencilTreePainter({
    required this.progress,
    required this.phase,
    required this.dark,
  });

  final double progress;
  final double phase;
  final bool dark;

  static const double _apexY = 56;
  static const double _baseY = 170;
  static const double _halfBase = 52;
  static const double _turns = 3.5;

  // —— 调色板 ——
  Color get _foliageA => dark ? const Color(0xFF55905F) : const Color(0xFFB6DDA2);
  Color get _foliageB => dark ? const Color(0xFF3E6F4B) : const Color(0xFF72AE79);
  Color get _foliageC => dark ? const Color(0xFF24452F) : const Color(0xFF2C6744);
  Color get _bandDark => dark ? const Color(0xFF10281A) : const Color(0xFF1B4427);
  Color get _bandPale => dark ? const Color(0xFFE3F5CF) : const Color(0xFFEAF7D6);
  Color get _char => dark ? const Color(0xFFB9D6BD) : const Color(0xFF40533F); // 铅笔灰绿
  Color get _needle => dark ? const Color(0xFF82B48B) : const Color(0xFF2E6345);
  Color get _gold => const Color(0xFFFFCE4E);

  // 星星棱面色
  Color get _starDeep => const Color(0xFFA84E08);
  Color get _starPale => const Color(0xFFFFE3A3);
  Color get _starMid => const Color(0xFFE8A83C);
  Color get _starLine => const Color(0xFF6B3B0C);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final p = _c01(progress);
    const h = _baseY - _apexY;

    // 0) 地面软影
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, _baseY + 20), width: 108, height: 18),
      Paint()
        ..color = Colors.black.withValues(alpha: dark ? 0.5 : 0.10)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // 1) 树后呼吸光晕
    final pulse = 0.5 + 0.5 * math.sin(phase);
    final haloC = Offset(cx, _apexY + h * 0.55);
    const haloR = 104.0;
    canvas.drawCircle(
      haloC,
      haloR,
      Paint()
        ..shader = RadialGradient(colors: [
          _gold.withValues(alpha: (dark ? 0.22 : 0.30) * p + 0.10 * pulse * p),
          _gold.withValues(alpha: 0),
        ]).createShader(Rect.fromCircle(center: haloC, radius: haloR)),
    );

    // 2) 树干与地面的随手几笔
    _trunkAndGround(canvas, cx, _c01(p * 6));

    // 3) 铅笔勾出松树位置（淡）
    final guide = _foliagePath(cx);
    canvas.drawPath(
      guide,
      Paint()
        ..color = _char.withValues(alpha: dark ? 0.20 : 0.14)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // 4) 树冠体块（左上受光的渐变 → 体积感）
    canvas.drawPath(
      guide,
      Paint()
        ..shader = LinearGradient(
          begin: const Alignment(-1, -0.9),
          end: const Alignment(0.9, 0.7),
          colors: [_foliageA, _foliageB, _foliageC],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(_foliageRectFor(cx)),
    );

    // 5) 深浅螺线盘旋扫过树身（画到哪笔尖点到哪）
    final coil = _spiral(canvas, cx, h, p);

    // 6) 铅笔小松针笔触（错落的短促分叉笔道）
    _needles(canvas, cx, coil);

    // 7) 外轮廓"描了两遍"的炭笔线（断断续续更像手绘）
    _pencilOutline(canvas, cx);

    // 8) 树周亮光小星（错峰忽闪）
    final mid = Offset(cx, _apexY + h * 0.5);
    for (int i = 0; i < _sparkleSpecs.length; i++) {
      final (o, sz, ph) = _sparkleSpecs[i];
      final appear = _c01((p - 0.20 - i * 0.026) / 0.20);
      if (appear <= 0) continue;
      final tw = 0.5 + 0.5 * math.sin(phase * 1.5 + ph * 7.0);
      _sparkle(canvas, mid + o, sz * (0.75 + 0.4 * tw),
          appear * (0.3 + 0.7 * tw), i);
    }

    // 9) 树顶棱面立体星（快画完时"啪"地弹出）
    _bigStar(canvas, Offset(cx, 27), phase, pulse);
  }

  // ---------------- 树冠 / 螺线 ----------------

  /// 松树轮廓（带轻微的不规则抖动，左右不完全对称）
  Path _foliagePath(double cx) {
    const n = 26;
    const h = _baseY - _apexY;
    final path = Path();
    // 左侧边（从上往下：顶端收拢 → 底端展开）
    for (int i = 0; i <= n; i++) {
      final u = i / n;
      final taper = math.pow(u, 0.95).toDouble();
      final bump = 1 +
          0.06 * math.sin(u * 6.0 + 1.1) +
          0.04 * math.sin(u * 11.0 + 2.7);
      final x = cx - _halfBase * taper * bump + _noise(i * 1.7 + 13.0) * 1.8;
      final y = _apexY + u * h + _noise(i * 2.3 + 5.0) * 1.2;
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    // 右侧边（从下往上）
    for (int i = n; i >= 0; i--) {
      final u = i / n;
      final taper = math.pow(u, 0.95).toDouble();
      final bump = 1 +
          0.06 * math.sin(u * 6.0 + 3.6) +
          0.04 * math.sin(u * 9.4 + 0.4);
      final x = cx + _halfBase * taper * bump + _noise(i * 1.7 + 29.0) * 1.8;
      final y = _apexY + u * h + _noise(i * 2.3 + 17.0) * 1.2;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  Rect _foliageRectFor(double cx) => Rect.fromLTRB(
      cx - _halfBase * 1.1 - 4, _apexY - 10, cx + _halfBase * 1.1 + 4, _baseY + 14);

  /// 返回本帧已画出的螺线采样点（供松针笔触使用）
  List<Offset> _spiral(Canvas canvas, double cx, double h, double p) {
    const steps = 250;
    final n = (steps * p).floor();
    final pts = <Offset>[];
    final normals = <Offset>[];
    final angs = <double>[];

    // 先算出中心线
    for (int i = 0; i <= n; i++) {
      final t = i / steps;
      final ang = math.pi + t * _turns * 2 * math.pi;
      final taper = math.pow(1 - t, 0.95).toDouble();
      final bump = 1 +
          0.06 * math.sin(t * 2 * math.pi * 2.2 + 1.4) +
          0.04 * math.sin(t * 2 * math.pi * 5.1 + 4.0) * (1 - t);
      final r = _halfBase * taper * bump + 2.8;
      final sway = math.sin(t * math.pi * 1.3 + 0.6) * 2.2;
      final x = cx + sway + r * math.cos(ang) +
          _noise(i * 0.27 + 41.0) * 1.4;
      final y = _baseY - t * h + _noise(i * 0.15 + 7.0) * 1.6;
      pts.add(Offset(x, y));
      angs.add(ang);
      if (i == 0) {
        normals.add(Offset.zero);
      } else {
        final d = pts[i] - pts[i - 1];
        final len = d.distance == 0 ? 1.0 : d.distance;
        normals.add(Offset(-d.dy / len, d.dx / len));
      }
    }
    if (pts.length < 2) return pts;

    final boundaryMid =
        Color.lerp(_bandDark, _bandPale, 0.5)!.withValues(alpha: 0.9);
    for (int i = 0; i < n; i++) {
      final t = i / steps;
      final ang = angs[i];
      final bandW = (10.5 + (1.6 - 10.5) * math.pow(t, 0.9)) *
          (1 + 0.22 * _noise(i * 0.53 + 77.0));
      // 以每半个盘旋为一段：深 / 浅交替，段界处自然过渡
      final half = (ang / math.pi).floor();
      final pos = (ang / math.pi) - half; // 0..1
      final dCenter = (pos - 0.5).abs();
      final mm = _smooth(_c01((0.42 - dCenter) / 0.16));
      final base = half.isEven ? _bandDark : _bandPale;
      var col = Color.lerp(boundaryMid, base.withValues(alpha: 0.92), mm)!;
      if (i % 5 == 0) col = col.withValues(alpha: 0.86);

      final w = math.max(1.2, bandW);
      canvas.drawLine(
        pts[i],
        pts[i + 1],
        Paint()
          ..color = col
          ..strokeWidth = w
          ..strokeCap = StrokeCap.round,
      );
      // 铅笔第二道：略宽的淡边，破掉"机器"的硬边
      if (w > 2.8) {
        final off = normals[i] * 0.9;
        canvas.drawLine(
          pts[i] + off,
          pts[i + 1] + off,
          Paint()
            ..color = base.withValues(alpha: 0.22)
            ..strokeWidth = w * 1.18
            ..strokeCap = StrokeCap.round,
        );
      }
    }
    // 笔尖：正画着的位置留一个墨点
    if (p < 0.995) {
      canvas.drawCircle(pts.last, 2.6,
          Paint()..color = _char.withValues(alpha: 0.85));
    }
    return pts;
  }

  /// 铅笔小松针：沿螺线错落点几簇短促分叉笔道
  void _needles(Canvas canvas, double cx, List<Offset> coil) {
    if (coil.length < 40) return;
    final paint = Paint()
      ..color = _needle.withValues(alpha: dark ? 0.5 : 0.42)
      ..strokeCap = StrokeCap.round;
    for (int i = 8; i < coil.length - 2; i += 11) {
      final t = i / 250.0;
      if (t < 0.06 || t > 0.94) continue;
      final pt = coil[i];
      final n0 = _noise(i * 1.7 + 3.0);
      if (n0 < 0.15) continue; // 留一些空档，别太整齐
      final dirX = pt.dx >= cx ? 1.0 : -1.0;
      final L = (4.5 + 4.5 * (1 - t) + n0.abs() * 4.0).clamp(3.0, 13.0);
      final dy = 1.2 + L * 0.28 + _noise(i * 2.9 + 8.0) * 1.2;
      paint.strokeWidth = 1.3 + _noise(i * 4.1 + 1.0);
      canvas.drawLine(
          pt, Offset(pt.dx + dirX * L, pt.dy + dy), paint); // 主笔
      canvas.drawLine(
          Offset(pt.dx + dirX * L * 0.35, pt.dy + dy * 0.25),
          Offset(pt.dx + dirX * (L * 0.92 + 2.0), pt.dy + dy * 0.9),
          paint); // 分叉
    }
  }

  /// 外轮廓：炭笔淡线描两遍，略错位 → 草稿感
  void _pencilOutline(Canvas canvas, double cx) {
    final path = _foliagePath(cx);
    final c = _char.withValues(alpha: dark ? 0.55 : 0.45);
    canvas.save();
    canvas.translate(0.7, -0.6);
    canvas.drawPath(
      path,
      Paint()
        ..color = c.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.restore();
    canvas.drawPath(
      path,
      Paint()
        ..color = c
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..strokeJoin = StrokeJoin.round,
    );
    // 树顶轻绕一笔
    canvas.drawCircle(
      Offset(cx, _apexY + 2),
      3.2,
      Paint()
        ..color = c.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );
  }

  void _trunkAndGround(Canvas canvas, double cx, double alpha) {
    if (alpha <= 0.01) return;
    final pen = Paint()
      ..color = _char.withValues(alpha: alpha * 0.8)
      ..strokeCap = StrokeCap.round;
    // 树干
    final pts = <Offset>[];
    for (int i = 0; i <= 8; i++) {
      final t = i / 8;
      pts.add(Offset(
          cx + _noise(i * 0.9 + 91.0) * 2.2, _baseY - 4 + t * 22));
    }
    for (int i = 0; i < pts.length - 1; i++) {
      pen.strokeWidth = 4.2 - 2.2 * (i / pts.length);
      canvas.drawLine(pts[i], pts[i + 1], pen);
    }
    // 地面两条松散的线
    for (final (x0, x1, seed) in const [
      (-62.0, -4.0, 11.0),
      (4.0, 64.0, 47.0),
    ]) {
      for (int pass = 0; pass < 2; pass++) {
        final y0 = _baseY + 15 + pass * 2.5 + _noise(seed) * 1.5;
        final path = Path();
        for (int i = 0; i <= 12; i++) {
          final t = i / 12;
          final x = cx + (x0 + (x1 - x0) * t);
          final y = y0 + _noise(i * 1.1 + seed + pass * 31.0) * 2.4;
          i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
        }
        canvas.drawPath(
          path,
          Paint()
            ..color = _char.withValues(alpha: alpha * (0.45 - pass * 0.15))
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.6 - pass * 0.5
            ..strokeCap = StrokeCap.round,
        );
      }
    }
    // 小草几簇
    final grass = Paint()
      ..color = _needle.withValues(alpha: alpha * 0.6)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int k = 0; k < 6; k++) {
      final gx = cx + (k - 3) * 13 + _noise(k * 7.0 + 3.0) * 5;
      final gy = _baseY + 17 + _noise(k * 3.3 + 9.0) * 3;
      final gL = 3.5 + _noise(k * 5.1 + 1.0) * 2;
      canvas.drawLine(Offset(gx, gy), Offset(gx + 1.5, gy - gL), grass);
      canvas.drawLine(Offset(gx + 2, gy), Offset(gx + 3.4, gy - gL * 0.8), grass);
    }
  }

  // ---------------- 棱面立体星 ----------------

  void _bigStar(Canvas canvas, Offset c, double phase, double pulse) {
    final appear = _c01((progress - 0.80) / 0.20);
    final s = Curves.easeOutBack.transform(appear);
    if (s <= 0.01) return;

    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.scale(s);
    canvas.translate(-c.dx, -c.dy);

    const outer = 17.0, inner = 7.6;

    // 光晕（呼吸）
    final glowR = 42 + 6 * pulse;
    canvas.drawCircle(
      c,
      glowR,
      Paint()
        ..shader = RadialGradient(colors: [
          const Color(0xFFFFE082).withValues(alpha: 0.55 + 0.25 * pulse),
          const Color(0xFFFFE082).withValues(alpha: 0),
        ]).createShader(Rect.fromCircle(center: c, radius: glowR)),
    );

    // 星点（含微抖的顶点）
    final tips = <Offset>[];
    final notchs = <Offset>[];
    for (int k = 0; k < 5; k++) {
      final a = -math.pi / 2 + k * 2 * math.pi / 5;
      final j = 1 + 0.04 * _noise(k * 3.3 + 2.0);
      tips.add(c +
          Offset(math.cos(a) * outer * j, math.sin(a) * outer * j));
      final na = a + math.pi / 5;
      notchs.add(
          c + Offset(math.cos(na) * inner, math.sin(na) * inner));
    }

    // 投影
    final shadow = _starOutlinePath(c + const Offset(1.4, 2.6), outer, inner);
    canvas.drawPath(
      shadow,
      Paint()
        ..color = Colors.black.withValues(alpha: dark ? 0.4 : 0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // 每条星芒 = 两条棱面（亮 / 暗），光源在左上慢慢摆动
    final lightAngle = -math.pi * 0.74 + 0.12 * math.sin(phase * 0.4);
    for (int k = 0; k < 5; k++) {
      final t = tips[k];
      final ml = notchs[(k + 4) % 5];
      final mr = notchs[k];
      for (final (m, side) in [(ml, -1.0), (mr, 1.0)]) {
        final mid = (t + m) / 2;
        final ang = math.atan2(mid.dy - c.dy, mid.dx - c.dx);
        final b = 0.5 + 0.5 * math.cos(ang - lightAngle);
        // 靠边的棱压暗一点，让折角更明显
        final bright = _c01(b * (0.55 + 0.45 * side * 0.3 + 0.22));
        final face = Path()
          ..moveTo(c.dx, c.dy)
          ..lineTo(t.dx, t.dy)
          ..lineTo(m.dx, m.dy)
          ..close();
        canvas.drawPath(
          face,
          Paint()
            ..color = Color.lerp(_starDeep, _starPale, bright)!,
        );
      }
      // 星芒脊线（中缝提亮 → "折"出来）
      canvas.drawLine(
        c,
        t,
        Paint()
          ..color = _starPale.withValues(alpha: 0.55)
          ..strokeWidth = 1.1
          ..strokeCap = StrokeCap.round,
      );
    }

    // 中央五边形（受光面）
    final pent = Path()..addPolygon(notchs, true);
    canvas.drawPath(pent, Paint()..color = _starMid);
    canvas.drawPath(
      pent,
      Paint()
        ..color = _starPale.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 轮廓：描两遍、错一点位，像铅笔线
    final outline = _starOutlinePath(c, outer, inner);
    canvas.drawPath(
      outline,
      Paint()
        ..color = _starLine.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawPath(
      _starOutlinePath(c + const Offset(0.6, -0.5), outer, inner),
      Paint()
        ..color = _starLine.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..strokeJoin = StrokeJoin.round,
    );

    // 小高光
    canvas.drawCircle(
      c + const Offset(-2.2, -3.0),
      1.8,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );

    // 手绘光斑：长短 / 角度都略带偏差，随相位忽闪
    for (int k = 0; k < 8; k++) {
      final a = math.pi / 8 * (2 * k + 1) * 0.5 + _noise(k * 2.1 + 55.0) * 0.16;
      final shake = _noise(k * 5.7 + 12.0);
      final dir = Offset(math.cos(a), math.sin(a));
      final r0 = outer + 4.0 + shake * 2.0;
      final len =
          (9.0 + 10.0 * (0.5 + 0.5 * math.sin(phase * 1.7 + k * 2.1))) *
              (0.5 + shake * 0.5);
      canvas.drawLine(
        c + dir * r0,
        c + dir * (r0 + len),
        Paint()
          ..color = _starPale.withValues(alpha: 0.25 + 0.45 * pulse * appear)
          ..strokeWidth = 1.4 + shake
          ..strokeCap = StrokeCap.round,
      );
    }

    canvas.restore();
  }

  Path _starOutlinePath(Offset c, double outer, double inner) {
    final path = Path();
    for (int k = 0; k <= 10; k++) {
      final idx = k % 10;
      final isTip = idx.isEven;
      final a = -math.pi / 2 + idx * math.pi / 5;
      final j = isTip ? 1 + 0.04 * _noise(idx * 3.3 + 2.0) : 1.0;
      final r = (isTip ? outer : inner) * j;
      final pt = c + Offset(math.cos(a) * r, math.sin(a) * r);
      k == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    return path;
  }

  // ---------------- 亮光小星 ----------------

  void _sparkle(Canvas canvas, Offset c, double r, double alpha, int seed) {
    // 柔光芯
    canvas.drawCircle(
      c,
      r * 1.6,
      Paint()
        ..color = _gold.withValues(alpha: alpha * 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    // 四道不对称的短笔触（每道角度 / 长度略错开，不死板）
    for (int k = 0; k < 4; k++) {
      final a = math.pi / 2 * k + 0.18 * _noise(seed * 3.1 + k * 1.7);
      final dir = Offset(math.cos(a), math.sin(a));
      final L = r * (1.15 + 0.35 * _noise(seed * 5.3 + k * 2.3));
      canvas.drawLine(
        c - dir * L * 0.55,
        c + dir * L,
        Paint()
          ..color = Colors.white.withValues(alpha: alpha * 0.9)
          ..strokeWidth = math.max(1.0, r * 0.22)
          ..strokeCap = StrokeCap.round,
      );
    }
    canvas.drawCircle(c, r * 0.26,
        Paint()..color = _gold.withValues(alpha: alpha));
  }

  // ---------------- 工具 ----------------

  double _noise(double x) {
    final v = math.sin(x * 127.1 + 311.7) * 43758.5453;
    return (v - v.floorToDouble()) * 2.0 - 1.0;
  }

  double _smooth(double t) {
    final x = _c01(t);
    return x * x * (3 - 2 * x);
  }

  double _c01(double x) => x < 0 ? 0 : (x > 1 ? 1 : x);

  static const _sparkleSpecs = [
    (Offset(-64, -22), 3.4, 0.13),
    (Offset(62, -30), 2.6, 0.47),
    (Offset(-50, 28), 2.3, 0.71),
    (Offset(52, 26), 3.0, 0.29),
    (Offset(-26, -52), 2.4, 0.88),
    (Offset(28, -58), 2.0, 0.05),
    (Offset(-72, 8), 2.1, 0.61),
    (Offset(72, -4), 2.6, 0.35),
    (Offset(-14, 46), 2.0, 0.79),
    (Offset(16, 52), 1.8, 0.53),
    (Offset(0, -70), 2.2, 0.23),
    (Offset(-70, -44), 1.8, 0.92),
    (Offset(70, -44), 1.8, 0.66),
  ];

  @override
  bool shouldRepaint(covariant _PencilTreePainter old) =>
      old.progress != progress ||
      old.phase != phase ||
      old.dark != dark;
}
