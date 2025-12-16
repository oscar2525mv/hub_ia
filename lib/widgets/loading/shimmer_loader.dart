import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

/// Shimmer loading effect widget
/// Displays an animated loading state while content is loading
class ShimmerLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ShimmerLoader({super.key, this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: const Duration(milliseconds: 1500),
          color: AppTheme.surfaceVariant.withOpacity(0.5),
        );
  }
}

/// Full page loading overlay with animated indicator
class LoadingOverlay extends StatelessWidget {
  final String? message;
  final Color? accentColor;

  const LoadingOverlay({super.key, this.message, this.accentColor});

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppTheme.primary;

    return Container(
      color: AppTheme.backgroundPrimary.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated loading indicator
            _buildLoadingIndicator(color),
            if (message != null) ...[
              const SizedBox(height: 24),
              Text(
                message!,
                style: AppTheme.body.copyWith(color: color),
              ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(Color color) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          // Outer ring
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.2), width: 3),
            ),
          ),
          // Animated arc
          SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .rotate(duration: 1000.ms, curve: Curves.linear),
          // Center dot
          Center(
            child:
                Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.glowShadow(color),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2),
                      duration: 800.ms,
                    ),
          ),
        ],
      ),
    );
  }
}

/// Inline loading dot animation
class LoadingDots extends StatelessWidget {
  final Color? color;
  final double size;

  const LoadingDots({super.key, this.color, this.size = 8});

  @override
  Widget build(BuildContext context) {
    final dotColor = color ?? AppTheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
              margin: EdgeInsets.symmetric(horizontal: size / 4),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            )
            .animate(
              delay: Duration(milliseconds: index * 150),
              onPlay: (c) => c.repeat(reverse: true),
            )
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.0, 1.0),
              duration: 400.ms,
            )
            .fadeIn();
      }),
    );
  }
}
