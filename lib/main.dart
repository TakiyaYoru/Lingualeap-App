// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart'; // ← NEW
import 'routes/app_router.dart';
import 'theme/theme_manager.dart';
import 'theme/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return GetMaterialApp.router( // ← CHANGED: GetMaterialApp instead of MaterialApp
            title: 'LinguaLeap',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeManager.themeMode,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            routerDelegate: AppRouter.router.routerDelegate,
            debugShowCheckedModeBanner: false,
            
            // GetX Configuration
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}