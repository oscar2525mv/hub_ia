import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/service_provider.dart';
import '../loading/shimmer_loader.dart';

/// WebView implementation for Windows using webview_windows
/// WebView2 automatically persists cookies/localStorage in app data folder
class WindowsWebView extends StatefulWidget {
  final String url;
  final String serviceId;

  const WindowsWebView({super.key, required this.url, required this.serviceId});

  @override
  State<WindowsWebView> createState() => _WindowsWebViewState();
}

class _WindowsWebViewState extends State<WindowsWebView> {
  final _controller = WebviewController();
  bool _isInitialized = false;
  String? _errorMessage;
  bool _canGoBack = false;
  bool _canGoForward = false;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    try {
      // WebView2 automatically persists cookies and localStorage
      // in the app's local data folder
      await _controller.initialize();

      final provider = context.read<ServiceProvider>();

      // Register navigation callbacks
      provider.onGoBack = goBack;
      provider.onGoForward = goForward;
      provider.onReload = reload;

      // Set up URL listener
      _controller.url.listen((url) {
        if (!mounted) return;
        _currentUrl = url;
        _updateNavigationState();
      });

      // Set up history listener
      _controller.historyChanged.listen((_) {
        if (!mounted) return;
        _updateNavigationState();
      });

      _controller.loadingState.listen((state) {
        if (!mounted) return;

        switch (state) {
          case LoadingState.loading:
            provider.setLoading(true);
            break;
          case LoadingState.navigationCompleted:
            provider.onLoadComplete();
            _updateNavigationState();
            break;
          case LoadingState.none:
            break;
        }
      });

      // Configure the WebView settings
      await _controller.setBackgroundColor(AppTheme.backgroundPrimary);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);

      // Load the initial URL
      await _controller.loadUrl(widget.url);

      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      debugPrint('WindowsWebView initialization error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize WebView: $e';
        });
        context.read<ServiceProvider>().setError(_errorMessage!);
      }
    }
  }

  @override
  void didUpdateWidget(WindowsWebView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Load new URL if the service changed
    if (oldWidget.url != widget.url && _isInitialized) {
      _controller.loadUrl(widget.url);
    }
  }

  @override
  void dispose() {
    // Reset navigation callbacks before disposing
    if (mounted) {
      try {
        context.read<ServiceProvider>().resetNavigationCallbacks();
      } catch (_) {}
    }
    _controller.dispose();
    super.dispose();
  }

  // ============== NAVIGATION METHODS ==============

  /// Navigate back in the WebView history
  void goBack() {
    if (_isInitialized && _canGoBack) {
      _controller.goBack();
    }
  }

  /// Navigate forward in the WebView history
  void goForward() {
    if (_isInitialized && _canGoForward) {
      _controller.goForward();
    }
  }

  /// Reload the current page
  void reload() {
    if (_isInitialized) {
      _controller.reload();
    }
  }

  /// Update the navigation state and notify the provider
  /// Note: webview_windows doesn't expose canGoBack/canGoForward, so we track via history
  Future<void> _updateNavigationState() async {
    if (!_isInitialized || !mounted) return;

    try {
      // Track that we have history when URL changes (after initial load)
      // This is a workaround since webview_windows doesn't expose canGoBack/canGoForward
      _canGoBack = _currentUrl != null && _currentUrl != widget.url;

      context.read<ServiceProvider>().updateNavigationState(
        canGoBack: _canGoBack,
        canGoForward: _canGoForward,
        currentUrl: _currentUrl,
      );
    } catch (e) {
      debugPrint('Failed to update navigation state: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    if (!_isInitialized) {
      return _buildLoadingWidget();
    }

    return Webview(
      _controller,
      permissionRequested: (url, permissionKind, isUserInitiated) async {
        // Allow camera, microphone for AI services that may need it
        return WebviewPermissionDecision.allow;
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: AppTheme.backgroundPrimary,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerLoader(
              width: 200,
              height: 24,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            SizedBox(height: 16),
            ShimmerLoader(
              width: 300,
              height: 16,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            SizedBox(height: 8),
            ShimmerLoader(
              width: 250,
              height: 16,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppTheme.backgroundPrimary,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppTheme.error.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load WebView',
              style: AppTheme.heading.copyWith(color: AppTheme.error),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error',
              style: AppTheme.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                  _isInitialized = false;
                });
                _initializeWebView();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
