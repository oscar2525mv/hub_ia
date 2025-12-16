import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'mobile_webview.dart';
import 'windows_webview.dart';

/// Platform-aware WebView widget
/// Automatically selects the appropriate WebView implementation based on platform
class PlatformWebView extends StatelessWidget {
  final String url;
  final String serviceId;
  final String serviceName;

  const PlatformWebView({
    super.key,
    required this.url,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    // Select platform-specific implementation
    if (Platform.isWindows) {
      return WindowsWebView(url: url, serviceId: serviceId);
    } else if (Platform.isAndroid || Platform.isIOS) {
      return MobileWebView(url: url, serviceId: serviceId);
    } else {
      // Fallback for unsupported platforms
      return WebViewPlaceholder(serviceName: serviceName, url: url);
    }
  }
}

/// Factory method for creating platform-specific WebView
Widget buildPlatformWebView({
  required String url,
  required String serviceId,
  required String serviceName,
}) {
  return PlatformWebView(
    url: url,
    serviceId: serviceId,
    serviceName: serviceName,
  );
}
