import 'package:flutter/material.dart';

/// Material Design 3 Theme Configuration
/// This theme uses ColorScheme.fromSeed for dynamic color support
/// All colors are semantic tokens - NO hardcoded hex values
class AppTheme {
  /// Primary seed color - generates entire color scheme dynamically
  /// This enables Material You dynamic coloring on Android 12+
  static const Color _seedColor = Color(0xFF6750A4); // Professional purple

  /// Light Theme Configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    // Typography - strict MD3 scale
    textTheme: _buildTextTheme(Brightness.light),
    // Scaffold & Surface configuration
    scaffoldBackgroundColor: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ).surface,
    // App Bar configuration
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).surface,
      foregroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).onSurface,
      scrolledUnderElevation: 4,
      surfaceTintColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).primary,
    ),
    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).surface,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).primary,
      unselectedItemColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).onSurfaceVariant,
    ),
    // Card configuration with MD3 corner radius
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Medium corner radius
      ),
      color: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).surfaceContainerHighest,
    ),
    // Button themes
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ).primary,
        foregroundColor: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ).onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ).primary,
        side: BorderSide(
          color: ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.light,
          ).outline,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    // FAB configuration
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).primaryContainer,
      foregroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).onPrimaryContainer,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ).surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.light,
          ).outline,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.light,
          ).outline,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorScheme.fromSeed(
            seedColor: _seedColor,
            brightness: Brightness.light,
          ).primary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  /// Dark Theme Configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    textTheme: _buildTextTheme(Brightness.dark),
    scaffoldBackgroundColor: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ).surface,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).surface,
      foregroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).onSurface,
      scrolledUnderElevation: 4,
      surfaceTintColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).surface,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).primary,
      unselectedItemColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).onSurfaceVariant,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).surfaceContainerHighest,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).primaryContainer,
      foregroundColor: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ).onPrimaryContainer,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  /// Build MD3-compliant Text Theme
  /// All typography follows strict Material Design 3 scale
  static TextTheme _buildTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return TextTheme(
      // Display Styles - Large, eye-catching text
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      // Headline Styles - Page/Section titles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      // Title Styles - Card headers, emphasis
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      // Body Styles - Main content
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: colorScheme.onSurfaceVariant,
      ),
      // Label Styles - Buttons, chips, tables
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
    );
  }

  /// Get elevation surface tint overlay based on level (0-5)
  /// MD3 uses surface tint overlays instead of drop shadows
  static Color getSurfaceTint(ColorScheme colorScheme, int elevationLevel) {
    const opacityLevels = {
      0: 0.00,
      1: 0.05,
      2: 0.08,
      3: 0.11,
      4: 0.12,
      5: 0.14,
    };

    return colorScheme.primary.withOpacity(
      opacityLevels[elevationLevel] ?? 0.0,
    );
  }
}
