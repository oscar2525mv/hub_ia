import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/service_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/sidebar/service_sidebar.dart';
import '../widgets/webview/platform_webview.dart';
import '../widgets/webview/webview_toolbar.dart';
import '../widgets/loading/shimmer_loader.dart';

/// Main screen of the Hub IA application
/// Contains the sidebar for service selection and the WebView container
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize services when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().initialize();
      // Request focus for keyboard shortcuts
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final serviceProvider = context.read<ServiceProvider>();
    final themeProvider = context.read<ThemeProvider>();

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        // Ctrl+1 to Ctrl+6 for AI service selection
        const SingleActivator(LogicalKeyboardKey.digit1, control: true): () =>
            serviceProvider.selectServiceByIndex(0),
        const SingleActivator(LogicalKeyboardKey.digit2, control: true): () =>
            serviceProvider.selectServiceByIndex(1),
        const SingleActivator(LogicalKeyboardKey.digit3, control: true): () =>
            serviceProvider.selectServiceByIndex(2),
        const SingleActivator(LogicalKeyboardKey.digit4, control: true): () =>
            serviceProvider.selectServiceByIndex(3),
        const SingleActivator(LogicalKeyboardKey.digit5, control: true): () =>
            serviceProvider.selectServiceByIndex(4),
        const SingleActivator(LogicalKeyboardKey.digit6, control: true): () =>
            serviceProvider.selectServiceByIndex(5),
        // Ctrl+Left/Right for previous/next service
        const SingleActivator(
          LogicalKeyboardKey.arrowLeft,
          control: true,
        ): () =>
            serviceProvider.previousService(),
        const SingleActivator(
          LogicalKeyboardKey.arrowRight,
          control: true,
        ): () =>
            serviceProvider.nextService(),
        // Ctrl+T for theme toggle
        const SingleActivator(LogicalKeyboardKey.keyT, control: true): () =>
            themeProvider.cycleTheme(),
        // Ctrl+R for reload WebView
        const SingleActivator(LogicalKeyboardKey.keyR, control: true): () =>
            serviceProvider.onReload?.call(),
      },
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme.getBackgroundGradient(isDark),
            ),
            child: Row(
              children: [
                // Sidebar
                const ServiceSidebar()
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.2, end: 0),

                // Main content area
                Expanded(child: _buildMainContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) {
        final activeService = provider.activeService;

        if (activeService == null) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            // Top bar with service info
            _buildTopBar(provider),

            // WebView container
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: activeService.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: activeService.primaryColor.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // WebView
                      PlatformWebView(
                        key: ValueKey(activeService.id),
                        url: activeService.url,
                        serviceId: activeService.id,
                        serviceName: activeService.name,
                      ).animate().fadeIn(duration: 300.ms),

                      // Linear loading indicator at top
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: WebViewLoadingIndicator(
                          isLoading: provider.isLoading,
                          accentColor: activeService.primaryColor,
                        ),
                      ),

                      // Error overlay
                      if (provider.hasError)
                        _buildErrorOverlay(provider, activeService),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTopBar(ServiceProvider provider) {
    final activeService = provider.activeService!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(right: 12, top: 12, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Service indicator
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: activeService.gradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: AppTheme.glowShadow(activeService.primaryColor),
            ),
            child: Icon(activeService.icon, size: 18, color: Colors.white),
          ).animate().scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 200.ms,
          ),

          const SizedBox(width: 12),

          // Service name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                activeService.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: activeService.primaryColor,
                ),
              ),
              Text(
                activeService.url,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: activeService.primaryColor.withOpacity(0.7),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.1, end: 0),

          const Spacer(),

          // WebView navigation toolbar
          WebViewToolbar(
            canGoBack: provider.canGoBack,
            canGoForward: provider.canGoForward,
            isLoading: provider.isLoading,
            currentUrl: provider.currentUrl ?? activeService.url,
            accentColor: activeService.primaryColor,
            onBack: provider.onGoBack,
            onForward: provider.onGoForward,
            onReload: provider.onReload,
          ),

          const SizedBox(width: 16),

          // Loading state indicator
          if (provider.isLoading)
            const LoadingDots().animate().fadeIn(duration: 200.ms),

          // Navigation buttons
          const SizedBox(width: 16),
          _buildNavButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Previous Service',
            onTap: () => provider.previousService(),
            accentColor: activeService.primaryColor,
          ),
          const SizedBox(width: 8),
          _buildNavButton(
            icon: Icons.arrow_forward_rounded,
            tooltip: 'Next Service',
            onTap: () => provider.nextService(),
            accentColor: activeService.primaryColor,
          ),

          // Divider before theme toggle
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 1,
            height: 24,
            color: colorScheme.outline.withOpacity(0.3),
          ),

          // Theme toggle button
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Tooltip(
                message: themeProvider.themeTooltip,
                child: Material(
                  color: Colors.transparent,
                  child:
                      InkWell(
                            onTap: () => themeProvider.cycleTheme(),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: activeService.primaryColor.withOpacity(
                                    0.5,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                themeProvider.themeIcon,
                                size: 18,
                                color: activeService.primaryColor,
                              ),
                            ),
                          )
                          .animate(key: ValueKey(themeProvider.themeMode))
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1.0, 1.0),
                            duration: 200.ms,
                          )
                          .fadeIn(duration: 200.ms),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    required Color accentColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
            ),
            child: Icon(icon, size: 16, color: accentColor),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
                Icons.hub_rounded,
                size: 80,
                color: AppTheme.primary.withOpacity(0.3),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
                duration: 2000.ms,
              ),
          const SizedBox(height: 24),
          Text(
            'Welcome to Hub IA',
            style: AppTheme.heading,
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
                'Select an AI service from the sidebar to get started',
                style: AppTheme.body,
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildErrorOverlay(ServiceProvider provider, activeService) {
    return Container(
      color: AppTheme.backgroundPrimary.withOpacity(0.95),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppTheme.error.withOpacity(0.7),
            ).animate().shake(duration: 500.ms),
            const SizedBox(height: 16),
            Text(
              'Failed to load ${activeService.name}',
              style: AppTheme.heading.copyWith(color: AppTheme.error),
            ),
            const SizedBox(height: 8),
            Text(
              provider.errorMessage ?? 'Unknown error occurred',
              style: AppTheme.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                provider.clearError();
                provider.selectService(activeService);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: activeService.primaryColor,
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
    ).animate().fadeIn(duration: 200.ms);
  }
}
