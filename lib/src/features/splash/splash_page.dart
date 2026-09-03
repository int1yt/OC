import 'dart:io';

import 'package:flutter/material.dart';

/// 开机动画：圆形 OC 图标 + 旋转环（可选自定义图片）
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onFinished, this.splashImage});
  final VoidCallback onFinished;
  final String? splashImage;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1900), widget.onFinished);
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final scale =
        CurvedAnimation(parent: _entrance, curve: Curves.elasticOut);
    final hasCustom = widget.splashImage != null &&
        File(widget.splashImage!).existsSync();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primaryContainer.withValues(alpha: 0.6),
              Colors.white,
              scheme.secondaryContainer.withValues(alpha: 0.5),
            ],
          ),
        ),
        child: Center(
          child: hasCustom
              ? ScaleTransition(
                  scale: scale,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.file(File(widget.splashImage!),
                        width: 132, height: 132, fit: BoxFit.contain),
                  ),
                )
              : ScaleTransition(
                  scale: scale,
                  child: FadeTransition(
                    opacity: _entrance,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: scheme.primary,
                          ),
                        ),
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: scheme.primary.withValues(alpha: 0.4),
                                blurRadius: 24,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'OC',
                              style: TextStyle(
                                color: scheme.onPrimary,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
