import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode options for the application
enum AppThemeMode { light, dark, system }

/// Provider for managing application theme state
/// Handles theme switching, system detection, and persistence
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  AppThemeMode _themeMode = AppThemeMode.system;
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  // ============== GETTERS ==============

  AppThemeMode get themeMode => _themeMode;
  bool get isInitialized => _isInitialized;

  /// Returns true if current effective theme is dark
  bool get isDarkMode {
    if (_themeMode == AppThemeMode.system) {
      return _isSystemDarkMode;
    }
    return _themeMode == AppThemeMode.dark;
  }

  /// Check if system is in dark mode
  bool get _isSystemDarkMode {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  /// Get the Flutter ThemeMode for MaterialApp
  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  // ============== INITIALIZATION ==============

  /// Initialize the theme provider and load saved preference
  Future<void> initialize() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    await _loadTheme();
    _isInitialized = true;
    notifyListeners();
  }

  /// Load theme preference from storage
  Future<void> _loadTheme() async {
    final savedValue = _prefs?.getString(_themeKey);
    if (savedValue != null) {
      _themeMode = AppThemeMode.values.firstWhere(
        (mode) => mode.name == savedValue,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  // ============== THEME SWITCHING ==============

  /// Set the theme mode and persist the choice
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    await _prefs?.setString(_themeKey, mode.name);
    notifyListeners();
  }

  /// Cycle through theme modes: system → light → dark → system
  Future<void> cycleTheme() async {
    final nextMode = switch (_themeMode) {
      AppThemeMode.system => AppThemeMode.light,
      AppThemeMode.light => AppThemeMode.dark,
      AppThemeMode.dark => AppThemeMode.system,
    };
    await setThemeMode(nextMode);
  }

  /// Get icon for current theme mode
  IconData get themeIcon {
    return switch (_themeMode) {
      AppThemeMode.light => Icons.light_mode_rounded,
      AppThemeMode.dark => Icons.dark_mode_rounded,
      AppThemeMode.system => Icons.brightness_auto_rounded,
    };
  }

  /// Get tooltip for current theme mode
  String get themeTooltip {
    return switch (_themeMode) {
      AppThemeMode.light => 'Thème Clair',
      AppThemeMode.dark => 'Thème Sombre',
      AppThemeMode.system => 'Thème Système',
    };
  }
}
