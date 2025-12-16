import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/service_provider.dart';

/// WebView implementation for Android and iOS using webview_flutter
class MobileWebView extends StatefulWidget {
  final String url;
  final String serviceId;

  const MobileWebView({super.key, required this.url, required this.serviceId});

  @override
  State<MobileWebView> createState() => _MobileWebViewState();
}

class _MobileWebViewState extends State<MobileWebView> {
  late final WebViewController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0F0F1A))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            final provider = context.read<ServiceProvider>();
            provider.setLoading(true);
          },
          onPageFinished: (String url) {
            final provider = context.read<ServiceProvider>();
            provider.onLoadComplete();
          },
          onWebResourceError: (WebResourceError error) {
            final provider = context.read<ServiceProvider>();
            provider.setError('Failed to load: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation within the service domain
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    setState(() => _isInitialized = true);
  }

  @override
  void didUpdateWidget(MobileWebView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Load new URL if the service changed
    if (oldWidget.url != widget.url) {
      _controller.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return WebViewWidget(controller: _controller);
  }
}

/// Placeholder widget when WebView is not available
class WebViewPlaceholder extends StatelessWidget {
  final String serviceName;
  final String url;

  const WebViewPlaceholder({
    super.key,
    required this.serviceName,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.web_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(serviceName, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(url, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          Text(
            'WebView not available on this platform',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
