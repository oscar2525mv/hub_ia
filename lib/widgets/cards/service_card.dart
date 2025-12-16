import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../models/ai_service.dart';

/// Card widget representing an AI service in the sidebar
/// Features hover effects, glow animations, and service-specific colors
class ServiceCard extends StatefulWidget {
  final AIService service;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.service.primaryColor;
    final accentColor = widget.service.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.symmetric(
            horizontal: widget.isExpanded ? 12 : 8,
            vertical: 4,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isExpanded ? 16 : 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            // Background with gradient when selected
            gradient: widget.isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.2),
                      accentColor.withOpacity(0.1),
                    ],
                  )
                : null,
            color: widget.isSelected
                ? null
                : _isHovered
                ? AppTheme.surfaceVariant
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            // Glowing border when selected
            border: Border.all(
              color: widget.isSelected
                  ? primaryColor.withOpacity(0.6)
                  : _isHovered
                  ? AppTheme.border.withOpacity(0.8)
                  : Colors.transparent,
              width: widget.isSelected ? 1.5 : 1,
            ),
            // Glow shadow when selected
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: widget.isExpanded
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              // Service icon
              _buildIcon(primaryColor, accentColor),

              // Service name and description (only when expanded)
              if (widget.isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.service.name,
                        style: AppTheme.title.copyWith(
                          fontSize: 14,
                          color: widget.isSelected
                              ? accentColor
                              : AppTheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.service.description,
                        style: AppTheme.caption.copyWith(
                          fontSize: 11,
                          color: widget.isSelected
                              ? accentColor.withOpacity(0.7)
                              : AppTheme.textMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // Active indicator
                if (widget.isSelected)
                  Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.2, 1.2),
                        duration: 1000.ms,
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color primaryColor, Color accentColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: widget.isSelected
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, accentColor],
              )
            : null,
        color: widget.isSelected ? null : AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.isSelected ? Colors.transparent : AppTheme.border,
          width: 1,
        ),
      ),
      child: Icon(
        widget.service.icon,
        size: 20,
        color: widget.isSelected
            ? Colors.white
            : _isHovered
            ? primaryColor
            : AppTheme.textSecondary,
      ),
    );
  }
}

/// Compact version of service card for collapsed sidebar
class ServiceCardCompact extends StatefulWidget {
  final AIService service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceCardCompact({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ServiceCardCompact> createState() => _ServiceCardCompactState();
}

class _ServiceCardCompactState extends State<ServiceCardCompact> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.service.primaryColor;
    final accentColor = widget.service.accentColor;

    return Tooltip(
      message: widget.service.name,
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              gradient: widget.isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [primaryColor, accentColor],
                    )
                  : null,
              color: widget.isSelected
                  ? null
                  : _isHovered
                  ? AppTheme.surfaceVariant
                  : AppTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isSelected
                    ? Colors.transparent
                    : _isHovered
                    ? primaryColor.withOpacity(0.5)
                    : AppTheme.border,
                width: 1,
              ),
              boxShadow: widget.isSelected
                  ? AppTheme.glowShadow(primaryColor)
                  : null,
            ),
            child: Icon(
              widget.service.icon,
              size: 18,
              color: widget.isSelected
                  ? Colors.white
                  : _isHovered
                  ? primaryColor
                  : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
