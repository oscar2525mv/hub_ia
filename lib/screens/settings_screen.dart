import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/service_provider.dart';

/// Settings screen for Hub IA configuration
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Form controllers for adding custom AI
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          _buildSection(
            title: 'Apparence',
            icon: Icons.palette_outlined,
            children: [_buildThemeSelector()],
          ),
          const SizedBox(height: 24),

          // AI Services Section
          _buildSection(
            title: 'Services IA',
            icon: Icons.hub_outlined,
            children: [
              _buildAIServicesList(),
              const SizedBox(height: 16),
              _buildAddCustomAIButton(),
            ],
          ),
          const SizedBox(height: 24),

          // Info Section
          _buildSection(
            title: 'À propos',
            icon: Icons.info_outlined,
            children: [
              ListTile(
                title: const Text('Version'),
                trailing: Text(
                  '1.4.0',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Raccourcis clavier'),
                trailing: const Icon(Icons.keyboard_rounded),
                onTap: () {
                  Navigator.pop(context);
                  // F1 will show help overlay
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          children: [
            RadioListTile<AppThemeMode>(
              title: const Text('Clair'),
              secondary: const Icon(Icons.light_mode_rounded),
              value: AppThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (value) => themeProvider.setThemeMode(value!),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Sombre'),
              secondary: const Icon(Icons.dark_mode_rounded),
              value: AppThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (value) => themeProvider.setThemeMode(value!),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Système'),
              secondary: const Icon(Icons.settings_brightness_rounded),
              value: AppThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (value) => themeProvider.setThemeMode(value!),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAIServicesList() {
    return Consumer<ServiceProvider>(
      builder: (context, provider, child) {
        final services = provider.services;

        return Column(
          children: services.map((service) {
            return SwitchListTile(
              title: Text(service.name),
              subtitle: Text(
                service.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              secondary: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: service.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(service.icon, color: service.primaryColor),
              ),
              value: service.isEnabled,
              onChanged: (value) =>
                  provider.toggleServiceVisibility(service.id),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildAddCustomAIButton() {
    return OutlinedButton.icon(
      onPressed: _showAddCustomAIDialog,
      icon: const Icon(Icons.add_rounded),
      label: const Text('Ajouter une IA personnalisée'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showAddCustomAIDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ajouter une IA'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Ex: My Custom AI',
                  prefixIcon: Icon(Icons.label_outline),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Nom requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL',
                  hintText: 'https://...',
                  prefixIcon: Icon(Icons.link),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'URL requise';
                  if (!Uri.tryParse(value!)!.hasAbsolutePath) {
                    return 'URL invalide';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<ServiceProvider>().addCustomService(
                  name: _nameController.text,
                  url: _urlController.text,
                );
                _nameController.clear();
                _urlController.clear();
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
