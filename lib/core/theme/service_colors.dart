import 'package:flutter/material.dart';

/// Color definitions for each AI service
/// Each service has a unique color identity for easy recognition
class ServiceColors {
  // Private constructor
  ServiceColors._();

  // ============== CHATGPT ==============
  static const Color chatgptPrimary = Color(0xFF10A37F);
  static const Color chatgptAccent = Color(0xFF1ED79C);
  static const Color chatgptSurface = Color(0xFF0D2A23);

  static LinearGradient get chatgptGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [chatgptPrimary, chatgptAccent],
  );

  // ============== GEMINI ==============
  static const Color geminiPrimary = Color(0xFF4285F4);
  static const Color geminiAccent = Color(0xFF8AB4F8);
  static const Color geminiSurface = Color(0xFF102A4C);

  static LinearGradient get geminiGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [geminiPrimary, geminiAccent],
  );

  // ============== CLAUDE ==============
  static const Color claudePrimary = Color(0xFFD97706);
  static const Color claudeAccent = Color(0xFFFBBF24);
  static const Color claudeSurface = Color(0xFF2D1F0D);

  static LinearGradient get claudeGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [claudePrimary, claudeAccent],
  );

  // ============== COPILOT ==============
  static const Color copilotPrimary = Color(0xFF0078D4);
  static const Color copilotAccent = Color(0xFF60CDFF);
  static const Color copilotSurface = Color(0xFF0D1E2D);

  static LinearGradient get copilotGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [copilotPrimary, copilotAccent],
  );

  // ============== PERPLEXITY ==============
  static const Color perplexityPrimary = Color(0xFF20B2AA);
  static const Color perplexityAccent = Color(0xFF5CFFAD);
  static const Color perplexitySurface = Color(0xFF0D2D2A);

  static LinearGradient get perplexityGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [perplexityPrimary, perplexityAccent],
  );

  // ============== MISTRAL ==============
  static const Color mistralPrimary = Color(0xFFFF6B35);
  static const Color mistralAccent = Color(0xFFFFB088);
  static const Color mistralSurface = Color(0xFF2D1A10);

  static LinearGradient get mistralGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mistralPrimary, mistralAccent],
  );

  /// Get gradient by service ID
  static LinearGradient getGradient(String serviceId) {
    switch (serviceId) {
      case 'chatgpt':
        return chatgptGradient;
      case 'gemini':
        return geminiGradient;
      case 'claude':
        return claudeGradient;
      case 'copilot':
        return copilotGradient;
      case 'perplexity':
        return perplexityGradient;
      case 'mistral':
        return mistralGradient;
      default:
        return geminiGradient;
    }
  }

  /// Get primary color by service ID
  static Color getPrimary(String serviceId) {
    switch (serviceId) {
      case 'chatgpt':
        return chatgptPrimary;
      case 'gemini':
        return geminiPrimary;
      case 'claude':
        return claudePrimary;
      case 'copilot':
        return copilotPrimary;
      case 'perplexity':
        return perplexityPrimary;
      case 'mistral':
        return mistralPrimary;
      default:
        return geminiPrimary;
    }
  }

  /// Get accent color by service ID
  static Color getAccent(String serviceId) {
    switch (serviceId) {
      case 'chatgpt':
        return chatgptAccent;
      case 'gemini':
        return geminiAccent;
      case 'claude':
        return claudeAccent;
      case 'copilot':
        return copilotAccent;
      case 'perplexity':
        return perplexityAccent;
      case 'mistral':
        return mistralAccent;
      default:
        return geminiAccent;
    }
  }
}
