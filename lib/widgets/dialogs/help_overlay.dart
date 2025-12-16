import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Help overlay showing all keyboard shortcuts
/// Displayed when user presses F1
class HelpOverlay extends StatelessWidget {
  const HelpOverlay({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => const HelpOverlay(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.keyboard_rounded, color: colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Raccourcis Clavier',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Shortcuts list
            _buildSection('Navigation', [
              _ShortcutItem('Ctrl + 1-6', 'Sélectionner une IA'),
              _ShortcutItem('Ctrl + ←/→', 'IA précédente/suivante'),
              _ShortcutItem('Ctrl + K', 'Rechercher'),
            ]),
            const SizedBox(height: 16),

            _buildSection('Actions', [
              _ShortcutItem('Ctrl + R', 'Recharger la page'),
              _ShortcutItem('Ctrl + T', 'Changer de thème'),
              _ShortcutItem('F1', 'Afficher cette aide'),
            ]),
            const SizedBox(height: 16),

            _buildSection('WebView', [
              _ShortcutItem('Ctrl + ←/→', 'Navigation historique'),
            ]),

            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<_ShortcutItem> items) {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        item.shortcut,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShortcutItem {
  final String shortcut;
  final String description;

  _ShortcutItem(this.shortcut, this.description);
}
