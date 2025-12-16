import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/service_provider.dart';
import '../../models/ai_service.dart';

/// Quick search dialog for AI services
/// Opened with Ctrl+K
class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => const SearchDialog(),
    );
  }

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.watch<ServiceProvider>();
    final services = provider.services
        .where(
          (s) =>
              s.isEnabled &&
              (s.name.toLowerCase().contains(_query.toLowerCase()) ||
                  s.description.toLowerCase().contains(_query.toLowerCase())),
        )
        .toList();

    return Dialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search field
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Rechercher une IA...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
              ),
              onChanged: (value) => setState(() => _query = value),
              onSubmitted: (_) {
                if (services.isNotEmpty) {
                  _selectService(services.first);
                }
              },
            ),
            const SizedBox(height: 16),

            // Results list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceItem(service, provider);
                },
              ),
            ),

            // Keyboard hint
            const SizedBox(height: 12),
            Text(
              '↵ Entrée pour sélectionner • Échap pour fermer',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(AIService service, ServiceProvider provider) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = provider.activeService?.id == service.id;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: service.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(service.icon, color: service.primaryColor, size: 20),
      ),
      title: Text(
        service.name,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        service.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: isActive
          ? Icon(Icons.check_circle_rounded, color: service.primaryColor)
          : service.isFavorite
          ? const Icon(Icons.star_rounded, color: Colors.amber, size: 18)
          : null,
      onTap: () => _selectService(service),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  void _selectService(AIService service) {
    context.read<ServiceProvider>().selectService(service);
    Navigator.pop(context);
  }
}
