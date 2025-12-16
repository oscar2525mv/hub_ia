import 'package:flutter/material.dart';
import '../core/theme/service_colors.dart';

/// Represents an AI service that can be displayed in the hub
class AIService {
  /// Unique identifier for the service
  final String id;

  /// Display name of the service
  final String name;

  /// URL to load in the WebView
  final String url;

  /// Short description or tagline
  final String description;

  /// Icon to display (Material icon)
  final IconData icon;

  /// Whether the service is currently active/selected
  bool isActive;

  AIService({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.icon,
    this.isActive = false,
  });

  /// Get the primary color for this service
  Color get primaryColor => ServiceColors.getPrimary(id);

  /// Get the accent color for this service
  Color get accentColor => ServiceColors.getAccent(id);

  /// Get the gradient for this service
  LinearGradient get gradient => ServiceColors.getGradient(id);

  /// Creates a copy of this service with optional new values
  AIService copyWith({
    String? id,
    String? name,
    String? url,
    String? description,
    IconData? icon,
    bool? isActive,
  }) {
    return AIService(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIService && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Predefined list of AI services
class AIServices {
  AIServices._();

  static List<AIService> get all => [
    AIService(
      id: 'chatgpt',
      name: 'ChatGPT',
      url: 'https://chat.openai.com',
      description: 'OpenAI\'s conversational AI',
      icon: Icons.chat_bubble_outline_rounded,
    ),
    AIService(
      id: 'gemini',
      name: 'Gemini',
      url: 'https://gemini.google.com',
      description: 'Google\'s multimodal AI',
      icon: Icons.auto_awesome_rounded,
    ),
    AIService(
      id: 'claude',
      name: 'Claude',
      url: 'https://claude.ai',
      description: 'Anthropic\'s AI assistant',
      icon: Icons.psychology_rounded,
    ),
    AIService(
      id: 'copilot',
      name: 'Copilot',
      url: 'https://copilot.microsoft.com',
      description: 'Microsoft\'s AI companion',
      icon: Icons.flight_takeoff_rounded,
    ),
    AIService(
      id: 'perplexity',
      name: 'Perplexity',
      url: 'https://www.perplexity.ai',
      description: 'AI-powered answer engine',
      icon: Icons.search_rounded,
    ),
    AIService(
      id: 'mistral',
      name: 'Mistral',
      url: 'https://chat.mistral.ai',
      description: 'Mistral AI\'s chat interface',
      icon: Icons.air_rounded,
    ),
  ];

  static AIService getById(String id) {
    return all.firstWhere(
      (service) => service.id == id,
      orElse: () => all.first,
    );
  }
}
