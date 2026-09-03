import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'features/home/home_shell.dart';
import 'features/splash/splash_page.dart';
import 'features/work/work_list_page.dart';
import 'state/providers.dart';

class OcApp extends ConsumerWidget {
  const OcApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seed = Color(ref.watch(themeSeedProvider));
    final bgImage = ref.watch(bgImagePathProvider);
    final bgOpacity = ref.watch(bgOpacityProvider);
    return MaterialApp(
      title: 'OC果子铺',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(seed),
      darkTheme: AppTheme.dark(seed),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final base = isDark ? const Color(0xFF191518) : const Color(0xFFFBF7F8);
        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: base),
            if (bgImage != null && File(bgImage).existsSync())
              Opacity(
                opacity: bgOpacity,
                child: Image.file(File(bgImage), fit: BoxFit.cover),
              ),
            child!,
          ],
        );
      },
      home: const _SplashGate(),
    );
  }
}

class _SplashGate extends ConsumerStatefulWidget {
  const _SplashGate();

  @override
  ConsumerState<_SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends ConsumerState<_SplashGate> {
  bool _showMain = false;

  @override
  Widget build(BuildContext context) {
    if (_showMain) return const AppRoot();
    final splashImage = ref.watch(splashImageProvider);
    return SplashPage(
      splashImage: splashImage,
      onFinished: () {
        if (mounted) setState(() => _showMain = true);
      },
    );
  }
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workId = ref.watch(currentWorkIdProvider);
    final works = ref.watch(worksStreamProvider);
    final hasWorks = works.value?.isNotEmpty ?? false;
    if (workId == null || !hasWorks) {
      return const WorkListPage();
    }
    return const HomeShell();
  }
}
