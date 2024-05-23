import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/configs/theme/app_colors.dart';
import 'core/configs/theme/app_theme.dart';
import 'core/init/app_initializer.dart';
import 'core/routing/app_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColors.background,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.bottom],
  );

  await AppInitializer.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.unFocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.themeMode,
        theme: AppTheme.lightTheme,
        routerConfig: AppNavigation.routerConfig,
      ),
    );
  }
}
