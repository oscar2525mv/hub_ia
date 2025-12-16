import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ai_service.dart';

/// State management for the AI service hub
/// Handles service selection and WebView state
class ServiceProvider extends ChangeNotifier {
  /// List of all available AI services
  List<AIService> _services = [];

  /// Currently selected service
  AIService? _activeService;

  /// Loading state for WebView
  bool _isLoading = false;

  /// Error message if any
  String? _errorMessage;

  /// Whether the sidebar is expanded
  bool _isSidebarExpanded = false;

  // ============== NAVIGATION STATE ==============

  /// Whether the WebView can go back
  bool _canGoBack = false;

  /// Whether the WebView can go forward
  bool _canGoForward = false;

  /// Current URL in the WebView
  String? _currentUrl;

  /// Callback to navigate back in WebView
  VoidCallback? onGoBack;

  /// Callback to navigate forward in WebView
  VoidCallback? onGoForward;

  /// Callback to reload the WebView
  VoidCallback? onReload;

  // ============== GETTERS ==============

  List<AIService> get services => _services;
  AIService? get activeService => _activeService;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSidebarExpanded => _isSidebarExpanded;
  bool get hasError => _errorMessage != null;
  bool get canGoBack => _canGoBack;
  bool get canGoForward => _canGoForward;
  String? get currentUrl => _currentUrl;

  // ============== PERSISTENCE KEYS ==============
  static const String _favoritesKey = 'favorites';
  static const String _visibilityKey = 'visibility';
  static const String _customServicesKey = 'custom_services';

  SharedPreferences? _prefs;

  // ============== INITIALIZATION ==============

  /// Initialize with default services and load saved data
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _services = AIServices.all;
    await _loadCustomServices();
    await _loadFavorites();
    await _loadVisibility();
    _sortServices();
    if (_services.isNotEmpty) {
      selectService(_services.where((s) => s.isEnabled).first);
    }
    notifyListeners();
  }

  /// Select a service by its index in the list (for keyboard shortcuts)
  void selectServiceByIndex(int index) {
    if (index >= 0 && index < _services.length) {
      selectService(_services[index]);
    }
  }

  // ============== SERVICE SELECTION ==============

  /// Select a service to display
  void selectService(AIService service) {
    // Deselect previous service
    if (_activeService != null) {
      final previousIndex = _services.indexWhere(
        (s) => s.id == _activeService!.id,
      );
      if (previousIndex != -1) {
        _services[previousIndex] = _services[previousIndex].copyWith(
          isActive: false,
        );
      }
    }

    // Select new service
    final index = _services.indexWhere((s) => s.id == service.id);
    if (index != -1) {
      _services[index] = _services[index].copyWith(isActive: true);
      _activeService = _services[index];
    }

    // Reset error state
    _errorMessage = null;
    _isLoading = true;

    notifyListeners();
  }

  /// Select service by ID
  void selectServiceById(String id) {
    final service = _services.firstWhere(
      (s) => s.id == id,
      orElse: () => _services.first,
    );
    selectService(service);
  }

  /// Toggle service visibility (enabled/disabled in sidebar)
  void toggleServiceVisibility(String id) {
    final index = _services.indexWhere((s) => s.id == id);
    if (index != -1) {
      _services[index] = _services[index].copyWith(
        isEnabled: !_services[index].isEnabled,
      );
      _saveVisibility();
      notifyListeners();
    }
  }

  /// Toggle service favorite status
  void toggleFavorite(String id) {
    final index = _services.indexWhere((s) => s.id == id);
    if (index != -1) {
      _services[index] = _services[index].copyWith(
        isFavorite: !_services[index].isFavorite,
      );
      // Re-sort to put favorites first
      _sortServices();
      _saveFavorites();
      notifyListeners();
    }
  }

  /// Add a custom AI service
  void addCustomService({required String name, required String url}) {
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final newService = AIService(
      id: id,
      name: name,
      url: url,
      description: 'IA personnalisée',
      icon: Icons.smart_toy_outlined,
    );
    _services.add(newService);
    _saveCustomServices();
    notifyListeners();
  }

  // ============== PERSISTENCE ==============

  /// Sort services: favorites first
  void _sortServices() {
    _services.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) return -1;
      if (!a.isFavorite && b.isFavorite) return 1;
      return 0;
    });
  }

  /// Load favorites from storage
  Future<void> _loadFavorites() async {
    final favoriteIds = _prefs?.getStringList(_favoritesKey) ?? [];
    for (var i = 0; i < _services.length; i++) {
      if (favoriteIds.contains(_services[i].id)) {
        _services[i] = _services[i].copyWith(isFavorite: true);
      }
    }
  }

  /// Save favorites to storage
  Future<void> _saveFavorites() async {
    final favoriteIds = _services
        .where((s) => s.isFavorite)
        .map((s) => s.id)
        .toList();
    await _prefs?.setStringList(_favoritesKey, favoriteIds);
  }

  /// Load visibility from storage
  Future<void> _loadVisibility() async {
    final disabledIds = _prefs?.getStringList(_visibilityKey) ?? [];
    for (var i = 0; i < _services.length; i++) {
      if (disabledIds.contains(_services[i].id)) {
        _services[i] = _services[i].copyWith(isEnabled: false);
      }
    }
  }

  /// Save visibility to storage
  Future<void> _saveVisibility() async {
    final disabledIds = _services
        .where((s) => !s.isEnabled)
        .map((s) => s.id)
        .toList();
    await _prefs?.setStringList(_visibilityKey, disabledIds);
  }

  /// Load custom services from storage
  Future<void> _loadCustomServices() async {
    final customJson = _prefs?.getStringList(_customServicesKey) ?? [];
    for (final json in customJson) {
      final data = jsonDecode(json) as Map<String, dynamic>;
      _services.add(
        AIService(
          id: data['id'] as String,
          name: data['name'] as String,
          url: data['url'] as String,
          description: 'IA personnalisée',
          icon: Icons.smart_toy_outlined,
        ),
      );
    }
  }

  /// Save custom services to storage
  Future<void> _saveCustomServices() async {
    final customServices = _services.where((s) => s.id.startsWith('custom_'));
    final customJson = customServices
        .map((s) => jsonEncode({'id': s.id, 'name': s.name, 'url': s.url}))
        .toList();
    await _prefs?.setStringList(_customServicesKey, customJson);
  }

  // ============== LOADING STATE ==============

  /// Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Mark loading as complete
  void onLoadComplete() {
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set error state
  void setError(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ============== SIDEBAR ==============

  /// Toggle sidebar expansion
  void toggleSidebar() {
    _isSidebarExpanded = !_isSidebarExpanded;
    notifyListeners();
  }

  /// Set sidebar expansion state
  void setSidebarExpanded(bool expanded) {
    _isSidebarExpanded = expanded;
    notifyListeners();
  }

  // ============== NAVIGATION ==============

  /// Navigate to next service
  void nextService() {
    if (_activeService == null || _services.isEmpty) return;

    final currentIndex = _services.indexWhere(
      (s) => s.id == _activeService!.id,
    );
    final nextIndex = (currentIndex + 1) % _services.length;
    selectService(_services[nextIndex]);
  }

  /// Navigate to previous service
  void previousService() {
    if (_activeService == null || _services.isEmpty) return;

    final currentIndex = _services.indexWhere(
      (s) => s.id == _activeService!.id,
    );
    final prevIndex = (currentIndex - 1 + _services.length) % _services.length;
    selectService(_services[prevIndex]);
  }

  // ============== WEBVIEW NAVIGATION ==============

  /// Update the navigation state from WebView
  void updateNavigationState({
    bool? canGoBack,
    bool? canGoForward,
    String? currentUrl,
  }) {
    bool changed = false;

    if (canGoBack != null && _canGoBack != canGoBack) {
      _canGoBack = canGoBack;
      changed = true;
    }

    if (canGoForward != null && _canGoForward != canGoForward) {
      _canGoForward = canGoForward;
      changed = true;
    }

    if (currentUrl != null && _currentUrl != currentUrl) {
      _currentUrl = currentUrl;
      changed = true;
    }

    if (changed) {
      notifyListeners();
    }
  }

  /// Reset navigation callbacks when WebView is disposed
  void resetNavigationCallbacks() {
    onGoBack = null;
    onGoForward = null;
    onReload = null;
    _canGoBack = false;
    _canGoForward = false;
    _currentUrl = null;
  }
}
