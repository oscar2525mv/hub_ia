import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/service_provider.dart';
import '../loading/shimmer_loader.dart';

/// WebView implementation for Windows using webview_windows
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

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    try {
      await _controller.initialize();

      // Set up event listeners
      _controller.url.listen((url) {
        debugPrint('WindowsWebView URL changed: $url');
      });

      _controller.loadingState.listen((state) {
        if (!mounted) return;

        final provider = context.read<ServiceProvider>();

        switch (state) {
          case LoadingState.loading:
            provider.setLoading(true);
            break;
          case LoadingState.navigationCompleted:
            provider.onLoadComplete();
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
    _controller.dispose();
    super.dispose();
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
