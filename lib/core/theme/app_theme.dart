import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Hub IA Premium Dark Theme
/// Futuristic dark mode with glassmorphism effects
class AppTheme {
  // Private constructor
  AppTheme._();

  // ============== COLORS ==============

  /// Primary background - very dark
  static const Color backgroundPrimary = Color(0xFF0F0F1A);

  /// Secondary background - slightly lighter
  static const Color backgroundSecondary = Color(0xFF1A1A2E);

  /// Surface color for cards
  static const Color surface = Color(0xFF16213E);

  /// Surface variant for hover states
  static const Color surfaceVariant = Color(0xFF1F2B4D);

  /// Primary accent color
  static const Color primary = Color(0xFF6366F1);

  /// Primary accent light
  static const Color primaryLight = Color(0xFF818CF8);

  /// Text primary
  static const Color textPrimary = Color(0xFFF8FAFC);

  /// Text secondary
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Text muted
  static const Color textMuted = Color(0xFF64748B);

  /// Border color
  static const Color border = Color(0xFF2D3748);

  /// Success color
  static const Color success = Color(0xFF10B981);

  /// Error color
  static const Color error = Color(0xFFEF4444);

  /// Warning color
  static const Color warning = Color(0xFFF59E0B);

  // ============== GRADIENTS ==============

  /// Main background gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundPrimary, backgroundSecondary],
  );

  /// Glassmorphism gradient
  static LinearGradient get glassGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
  );

  // ============== SHADOWS ==============

  /// Glow shadow for active elements
  static List<BoxShadow> glowShadow(Color color) => [
    BoxShadow(color: color.withOpacity(0.4), blurRadius: 20, spreadRadius: -2),
    BoxShadow(color: color.withOpacity(0.2), blurRadius: 40, spreadRadius: -4),
  ];

  /// Subtle shadow
  static List<BoxShadow> subtleShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // ============== DECORATIONS ==============

  /// Glassmorphism decoration
  static BoxDecoration glassDecoration({
    Color? borderColor,
    double borderRadius = 16,
  }) => BoxDecoration(
    gradient: glassGradient,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor ?? border, width: 1),
    boxShadow: subtleShadow,
  );

  // ============== TEXT STYLES ==============

  /// Display large
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  /// Heading
  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  /// Title
  static TextStyle get title => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  /// Body
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );

  /// Caption
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textMuted,
  );

  // ============== THEME DATA ==============

  /// Full ThemeData for the application
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundPrimary,

    // Color scheme
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primaryLight,
      surface: surface,
      error: error,
    ),

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: heading,
      iconTheme: const IconThemeData(color: textPrimary),
    ),

    // Card
    cardTheme: const CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: border),
      ),
    ),

    // Icon
    iconTheme: const IconThemeData(color: textSecondary, size: 24),

    // Text
    textTheme: TextTheme(
      displayLarge: displayLarge,
      headlineMedium: heading,
      titleMedium: title,
      bodyMedium: body,
      bodySmall: caption,
    ),

    // Divider
    dividerColor: border,
    dividerTheme: const DividerThemeData(color: border, thickness: 1),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      textStyle: body.copyWith(color: textPrimary),
    ),
  );

  // ============== LIGHT THEME COLORS ==============

  /// Light background - off-white
  static const Color lightBackgroundPrimary = Color(0xFFF8FAFC);

  /// Light secondary background
  static const Color lightBackgroundSecondary = Color(0xFFE2E8F0);

  /// Light surface for cards
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Light surface variant
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);

  /// Light text primary
  static const Color lightTextPrimary = Color(0xFF0F172A);

  /// Light text secondary
  static const Color lightTextSecondary = Color(0xFF475569);

  /// Light text muted
  static const Color lightTextMuted = Color(0xFF94A3B8);

  /// Light border color
  static const Color lightBorder = Color(0xFFCBD5E1);

  // ============== LIGHT GRADIENTS ==============

  /// Light background gradient
  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightBackgroundPrimary, lightBackgroundSecondary],
  );

  // ============== LIGHT THEME DATA ==============

  /// Light theme text styles
  static TextStyle get lightDisplayLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: lightTextPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get lightHeading => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: lightTextPrimary,
  );

  static TextStyle get lightTitle => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: lightTextPrimary,
  );

  static TextStyle get lightBody => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: lightTextSecondary,
  );

  static TextStyle get lightCaption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: lightTextMuted,
  );

  /// Full Light ThemeData for the application
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundPrimary,

    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: primaryLight,
      surface: lightSurface,
      error: error,
    ),

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: lightHeading,
      iconTheme: const IconThemeData(color: lightTextPrimary),
    ),

    // Card
    cardTheme: const CardThemeData(
      color: lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: lightBorder),
      ),
    ),

    // Icon
    iconTheme: const IconThemeData(color: lightTextSecondary, size: 24),

    // Text
    textTheme: TextTheme(
      displayLarge: lightDisplayLarge,
      headlineMedium: lightHeading,
      titleMedium: lightTitle,
      bodyMedium: lightBody,
      bodySmall: lightCaption,
    ),

    // Divider
    dividerColor: lightBorder,
    dividerTheme: const DividerThemeData(color: lightBorder, thickness: 1),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: lightSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lightBorder),
      ),
      textStyle: lightBody.copyWith(color: lightTextPrimary),
    ),
  );

  // ============== DYNAMIC HELPERS ==============

  /// Get background gradient based on brightness
  static LinearGradient getBackgroundGradient(bool isDark) =>
      isDark ? backgroundGradient : lightBackgroundGradient;

  /// Get background primary based on brightness
  static Color getBackgroundPrimary(bool isDark) =>
      isDark ? backgroundPrimary : lightBackgroundPrimary;

  /// Get surface color based on brightness
  static Color getSurface(bool isDark) => isDark ? surface : lightSurface;

  /// Get text primary based on brightness
  static Color getTextPrimary(bool isDark) =>
      isDark ? textPrimary : lightTextPrimary;

  /// Get text secondary based on brightness
  static Color getTextSecondary(bool isDark) =>
      isDark ? textSecondary : lightTextSecondary;

  /// Get border color based on brightness
  static Color getBorder(bool isDark) => isDark ? border : lightBorder;
}
