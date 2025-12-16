import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';

import '../../providers/service_provider.dart';
import '../cards/service_card.dart';

/// Sidebar widget for navigating between AI services
/// Uses AnimationController to detect when animation is complete
/// Only shows expanded content after animation finishes to prevent overflow
class ServiceSidebar extends StatefulWidget {
  const ServiceSidebar({super.key});

  @override
  State<ServiceSidebar> createState() => _ServiceSidebarState();
}

class _ServiceSidebarState extends State<ServiceSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  // Track if we should show expanded content (only after animation completes)
  bool _showExpandedContent = false;
  bool _isExpanded = false;

  static const double _collapsedWidth = 80.0;
  static const double _expandedWidth = 280.0;
  static const Duration _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: _collapsedWidth, end: _expandedWidth)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Listen to animation status
    _animationController.addStatusListener(_onAnimationStatusChanged);
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed && _isExpanded) {
      // Animation finished opening - now show expanded content
      setState(() => _showExpandedContent = true);
    } else if (status == AnimationStatus.dismissed && !_isExpanded) {
      // Animation finished closing - ensure compact content
      setState(() => _showExpandedContent = false);
    }
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationStatusChanged);
    _animationController.dispose();
    super.dispose();
  }

  void _handleExpansionChange(bool isExpanded) {
    if (_isExpanded == isExpanded) return;

    setState(() {
      _isExpanded = isExpanded;
      // Immediately hide expanded content when starting to close
      if (!isExpanded) {
        _showExpandedContent = false;
      }
    });

    if (isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) {
        // Sync with provider state
        if (provider.isSidebarExpanded != _isExpanded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _handleExpansionChange(provider.isSidebarExpanded);
          });
        }

        return AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            final colorScheme = Theme.of(context).colorScheme;
            final isDark = Theme.of(context).brightness == Brightness.dark;

            return SizedBox(
              width: _widthAnimation.value,
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.backgroundSecondary.withOpacity(0.7)
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      // Header - only show expanded when animation is done
                      _buildHeader(provider),
                      const Divider(height: 1),
                      // Service list
                      Expanded(child: _buildServiceList(provider)),
                      const Divider(height: 1),
                      // Footer
                      _buildFooter(provider),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(ServiceProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _showExpandedContent ? 16 : 6,
        vertical: 12,
      ),
      child: _showExpandedContent
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildLogo(true),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Hub IA',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                          .animate()
                          .fadeIn(duration: 200.ms)
                          .slideX(begin: -0.2, end: 0),
                      Text(
                            'AI Services Hub',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                          .animate()
                          .fadeIn(duration: 200.ms, delay: 100.ms)
                          .slideX(begin: -0.2, end: 0),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: _buildLogo(false)),
    );
  }

  Widget _buildLogo(bool expanded) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: expanded ? 40 : 32,
      height: expanded ? 40 : 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primary, AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(expanded ? 10 : 8),
        boxShadow: AppTheme.glowShadow(AppTheme.primary),
      ),
      child: Icon(
        Icons.hub_rounded,
        color: Colors.white,
        size: expanded ? 22 : 16,
      ),
    );
  }

  Widget _buildServiceList(ServiceProvider provider) {
    final services = provider.services;
    final activeService = provider.activeService;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: _showExpandedContent ? 0 : 8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        final isSelected = activeService?.id == service.id;

        if (_showExpandedContent) {
          return ServiceCard(
                service: service,
                isSelected: isSelected,
                isExpanded: true,
                onTap: () => provider.selectService(service),
              )
              .animate()
              .fadeIn(
                duration: 200.ms,
                delay: Duration(milliseconds: 50 * index),
              )
              .slideX(begin: -0.1, end: 0);
        } else {
          return Center(
            child: ServiceCardCompact(
              service: service,
              isSelected: isSelected,
              onTap: () => provider.selectService(service),
            ),
          );
        }
      },
    );
  }

  Widget _buildFooter(ServiceProvider provider) {
    return ClipRect(
      child: Padding(
        padding: EdgeInsets.all(_showExpandedContent ? 12 : 8),
        child: _showExpandedContent
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${provider.services.length} services',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(duration: 200.ms),
                  ),
                  _ToggleButton(
                    isExpanded: _isExpanded,
                    onTap: () => provider.toggleSidebar(),
                  ),
                ],
              )
            : Center(
                child: _ToggleButton(
                  isExpanded: _isExpanded,
                  onTap: () => provider.toggleSidebar(),
                ),
              ),
      ),
    );
  }
}

/// Animated toggle button for sidebar expansion
class _ToggleButton extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const _ToggleButton({required this.isExpanded, required this.onTap});

  @override
  State<_ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<_ToggleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _isHovered
                ? colorScheme.surfaceContainerHighest
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? colorScheme.primary.withOpacity(0.5)
                  : colorScheme.outline.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 300),
            turns: widget.isExpanded ? 0 : 0.5,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 18,
              color: _isHovered
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
