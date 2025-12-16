import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/service_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HubIAApp());
}

/// Hub IA - Centralized AI Services Hub
/// A premium Flutter application for accessing multiple AI services
/// from a single, elegant interface.
class HubIAApp extends StatelessWidget {
  const HubIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ServiceProvider())],
      child: MaterialApp(
        title: 'Hub IA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
