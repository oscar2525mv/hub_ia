import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

/// Toolbar for WebView navigation controls
/// Provides back, forward, reload, and open in browser buttons
class WebViewToolbar extends StatelessWidget {
  final bool canGoBack;
  final bool canGoForward;
  final bool isLoading;
  final String? currentUrl;
  final Color accentColor;
  final VoidCallback? onBack;
  final VoidCallback? onForward;
  final VoidCallback? onReload;

  const WebViewToolbar({
    super.key,
    required this.canGoBack,
    required this.canGoForward,
    required this.isLoading,
    this.currentUrl,
    required this.accentColor,
    this.onBack,
    this.onForward,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Back button
          _ToolbarButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Précédent',
            enabled: canGoBack,
            onPressed: onBack,
            accentColor: accentColor,
          ),
          const SizedBox(width: 4),

          // Forward button
          _ToolbarButton(
            icon: Icons.arrow_forward_rounded,
            tooltip: 'Suivant',
            enabled: canGoForward,
            onPressed: onForward,
            accentColor: accentColor,
          ),
          const SizedBox(width: 4),

          // Reload button
          _ToolbarButton(
            icon: isLoading ? Icons.close_rounded : Icons.refresh_rounded,
            tooltip: isLoading ? 'Arrêter' : 'Recharger',
            enabled: true,
            onPressed: onReload,
            accentColor: accentColor,
            isLoading: isLoading,
          ),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 1,
            height: 20,
            color: AppTheme.border.withOpacity(0.5),
          ),

          // Open in browser button
          _ToolbarButton(
            icon: Icons.open_in_new_rounded,
            tooltip: 'Ouvrir dans le navigateur',
            enabled: currentUrl != null && currentUrl!.isNotEmpty,
            onPressed: () => _openInBrowser(currentUrl),
            accentColor: accentColor,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.1, end: 0);
  }

  Future<void> _openInBrowser(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Individual toolbar button widget
class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool enabled;
  final VoidCallback? onPressed;
  final Color accentColor;
  final bool isLoading;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    this.onPressed,
    required this.accentColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: enabled
                  ? AppTheme.surface.withOpacity(0.8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: enabled
                  ? (isLoading ? accentColor : AppTheme.textSecondary)
                  : AppTheme.textSecondary.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}

/// Linear progress indicator for WebView loading state
class WebViewLoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Color accentColor;

  const WebViewLoadingIndicator({
    super.key,
    required this.isLoading,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isLoading ? 3 : 0,
      child: isLoading
          ? LinearProgressIndicator(
              backgroundColor: accentColor.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            )
          : const SizedBox.shrink(),
    );
  }
}
