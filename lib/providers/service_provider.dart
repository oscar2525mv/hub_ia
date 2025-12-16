import 'package:flutter/material.dart';
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

  // ============== INITIALIZATION ==============

  /// Initialize with default services
  void initialize() {
    _services = AIServices.all;
    if (_services.isNotEmpty) {
      selectService(_services.first);
    }
    notifyListeners();
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
