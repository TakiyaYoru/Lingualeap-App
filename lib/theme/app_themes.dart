// lib/theme/app_themes.dart
import 'package:flutter/material.dart';

class AppThemes {
  // Primary Colors (iOS-inspired)
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryBlueDark = Color(0xFF0051D0);
  static const Color primaryBlueLight = Color(0xFF64B5F6);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF34C759);
  static const Color secondaryDark = Color(0xFF30A14E);
  
  // System Colors (iOS style)
  static const Color systemRed = Color(0xFFFF3B30);
  static const Color systemOrange = Color(0xFFFF9500);
  static const Color systemYellow = Color(0xFFFFCC00);
  static const Color systemGreen = Color(0xFF34C759);
  static const Color systemTeal = Color(0xFF5AC8FA);
  static const Color systemBlue = Color(0xFF007AFF);
  static const Color systemIndigo = Color(0xFF5856D6);
  static const Color systemPurple = Color(0xFFAF52DE);
  static const Color systemPink = Color(0xFFFF2D92);
  
  // Learning Level Colors
  static const Color levelA1 = Color(0xFF34C759);  // Green
  static const Color levelA2 = Color(0xFF5AC8FA);  // Teal
  static const Color levelB1 = Color(0xFF007AFF);  // Blue
  static const Color levelB2 = Color(0xFF5856D6);  // Indigo
  static const Color levelC1 = Color(0xFFAF52DE);  // Purple
  static const Color levelC2 = Color(0xFFFF2D92);  // Pink
  
  // Exercise Type Colors
  static const Color multipleChoice = systemBlue;
  static const Color fillBlank = systemGreen;
  static const Color listening = systemPurple;
  static const Color translation = systemOrange;
  static const Color speaking = systemRed;
  static const Color reading = systemTeal;
  
  // Gamification Colors
  static const Color hearts = systemRed;
  static const Color xp = systemOrange;
  static const Color streak = systemPurple;
  static const Color premium = systemYellow;

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
      primary: primaryBlue,
      secondary: secondary,
      error: systemRed,
      surface: const Color(0xFFF2F2F7),
      background: const Color(0xFFFFFFFF),
    ),
    
    // AppBar Theme (iOS style)
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF2F2F7),
      foregroundColor: Color(0xFF000000),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // Card Theme (iOS style)
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // ElevatedButton Theme (iOS style)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input Decoration Theme (iOS style)
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD1D1D6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD1D1D6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    
    // Bottom Navigation Bar Theme (iOS style)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFF2F2F7),
      selectedItemColor: primaryBlue,
      unselectedItemColor: Color(0xFF8E8E93),
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    ),
    
    // Text Theme (iOS style)
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      displaySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
      headlineMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
      headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
      bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
      bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xFF000000)),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF8E8E93)),
    ),
  );

  // Dark Theme (iOS style)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.dark,
      primary: primaryBlue,
      secondary: secondary,
      error: systemRed,
      surface: const Color(0xFF1C1C1E),
      background: const Color(0xFF000000),
    ),
    
    // AppBar Theme (iOS Dark style)
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // Card Theme (iOS Dark style)
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // ElevatedButton Theme (iOS Dark style)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input Decoration Theme (iOS Dark style)
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF48484A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF48484A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: const Color(0xFF2C2C2E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    
    // Bottom Navigation Bar Theme (iOS Dark style)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF1C1C1E),
      selectedItemColor: primaryBlue,
      unselectedItemColor: Color(0xFF8E8E93),
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    ),
    
    // Text Theme (iOS Dark style)
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      displaySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
      headlineMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF8E8E93)),
    ),
    
    // Scaffold Background
    scaffoldBackgroundColor: const Color(0xFF000000),
  );
  
  // Helper method to get level color
  static Color getLevelColor(String level) {
    switch (level.toUpperCase()) {
      case 'A1': return levelA1;
      case 'A2': return levelA2;
      case 'B1': return levelB1;
      case 'B2': return levelB2;
      case 'C1': return levelC1;
      case 'C2': return levelC2;
      default: return primaryBlue;
    }
  }
  
  // Helper method to get exercise type color
  static Color getExerciseColor(String type) {
    switch (type.toLowerCase()) {
      case 'multiple_choice': return multipleChoice;
      case 'fill_blank': return fillBlank;
      case 'listening': return listening;
      case 'translation': return translation;
      case 'speaking': return speaking;
      case 'reading': return reading;
      default: return primaryBlue;
    }
  }
}