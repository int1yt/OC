import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/state/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lastWorkId = prefs.getString('lastWorkId');
  final themeSeed = prefs.getInt('themeSeed') ?? 0xFFE8A6B8;
  final bgImage = prefs.getString('bgImagePath');
  final bgOpacity = prefs.getDouble('bgOpacity') ?? 1.0;
  final splashImage = prefs.getString('splashImage');
  final strengthColors = loadStrengthColors(prefs.getString('strengthColors'));
  runApp(
    ProviderScope(
      overrides: [
        currentWorkIdProvider.overrideWith((ref) => lastWorkId),
        themeSeedProvider.overrideWith((ref) => themeSeed),
        bgImagePathProvider.overrideWith((ref) => bgImage),
        bgOpacityProvider.overrideWith((ref) => bgOpacity),
        splashImageProvider.overrideWith((ref) => splashImage),
        strengthColorsProvider.overrideWith((ref) => strengthColors),
      ],
      child: const OcApp(),
    ),
  );
}
