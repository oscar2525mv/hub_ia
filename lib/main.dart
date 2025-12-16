import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/service_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize providers before running app
  final themeProvider = ThemeProvider();
  await themeProvider.initialize();

  final serviceProvider = ServiceProvider();
  await serviceProvider.initialize();

  runApp(
    HubIAApp(themeProvider: themeProvider, serviceProvider: serviceProvider),
  );
}

/// Hub IA - Centralized AI Services Hub
/// A premium Flutter application for accessing multiple AI services
/// from a single, elegant interface.
class HubIAApp extends StatelessWidget {
  final ThemeProvider themeProvider;
  final ServiceProvider serviceProvider;

  const HubIAApp({
    super.key,
    required this.themeProvider,
    required this.serviceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: serviceProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Hub IA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.flutterThemeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
