# Historique des Versions - Hub IA

## Changelog Complet

Ce document retrace l'évolution du projet Hub IA à travers ses différentes versions.

---

## v1.0.0 - Fondation
**Date**: 16 Décembre 2024

### Nouveautés
- 🎉 Création initiale du projet Flutter
- 📁 Structure de base des dossiers
- 🎨 Système de thème avec mode sombre
- 📦 Configuration des dépendances

### Fichiers Créés
- `pubspec.yaml`
- `lib/main.dart`
- `lib/core/theme/app_theme.dart`

---

## v1.1.0 - Modèles de Données
**Date**: 16 Décembre 2024

### Nouveautés
- 📊 Modèle `AIService` avec propriétés complètes
- 🔄 `ServiceProvider` pour la gestion d'état
- 🤖 7 services IA pré-configurés

### Services Ajoutés
| Service | Icône | Couleur Primaire |
|---------|-------|------------------|
| ChatGPT | 🟢 | #10a37f |
| Gemini | 🔵 | #4285f4 |
| Claude | 🟠 | #cc785c |
| Copilot | 🔷 | #0078d4 |
| Perplexity | 🔹 | #20b2aa |
| DeepSeek | 🟣 | #5b5fc7 |
| Mistral | 🟧 | #f54e00 |

---

## v1.2.0 - Composants UI
**Date**: 16 Décembre 2024

### Nouveautés
- 🃏 `ServiceCard` avec effets visuels
- 📱 `ServiceCardCompact` pour vue condensée
- 📐 `ServiceSidebar` avec animation d'expansion

### Caractéristiques
- Effet de survol (hover)
- Bordure lumineuse (glow)
- Animation de pulsation pour l'élément actif

---

## v1.3.0 - Intégration WebView
**Date**: 16 Décembre 2024

### Nouveautés
- 🌐 `PlatformWebView` multiplateforme
- 🧭 `WebViewToolbar` avec navigation
- ⏳ Indicateur de chargement linéaire
- ❌ Gestion des erreurs de chargement

### Boutons de Navigation
- ← Précédent
- → Suivant
- 🔄 Recharger
- 🔗 Ouvrir dans le navigateur

---

## v1.4.0 - Écran des Paramètres
**Date**: 16 Décembre 2024

### Nouveautés
- ⚙️ `SettingsScreen` complet
- 📋 Liste de tous les services
- ℹ️ Section "À propos"

---

## v1.5.0 - Système de Favoris
**Date**: 16 Décembre 2024

### Nouveautés
- ⭐ Propriété `isFavorite` sur les services
- 🔘 Bouton étoile sur chaque carte
- 💾 Persistance avec `SharedPreferences`

```dart
// Toggle favori
void toggleFavorite(String serviceId) {
  final index = _services.indexWhere((s) => s.id == serviceId);
  if (index != -1) {
    _services[index] = _services[index].copyWith(
      isFavorite: !_services[index].isFavorite,
    );
    _saveFavorites();
    notifyListeners();
  }
}
```

---

## v1.6.0 - Activation des Services
**Date**: 16 Décembre 2024

### Nouveautés
- ✅ Propriété `isEnabled` par service
- 🔀 Toggle dans les paramètres
- 🚫 Filtrage des services désactivés

---

## v1.7.0 - Layout Responsive
**Date**: 16 Décembre 2024

### Nouveautés
- 📱 Détection automatique mobile (< 600px)
- 🍔 Menu hamburger pour mobile
- 📥 Sidebar en `Drawer`
- 📐 Marges adaptatives

```dart
// Breakpoint responsive
final isMobile = constraints.maxWidth < 600;
```

---

## v1.8.0 - Animations Avancées
**Date**: 16 Décembre 2024

### Nouveautés
- ✨ Package `flutter_animate` intégré
- 🎬 Animations d'entrée (fade + slide)
- 💫 `LoadingDots` animé
- 💓 Pulsation sur l'indicateur actif

---

## v1.9.0 - Drag & Drop
**Date**: 17 Décembre 2024

### Nouveautés
- 🔀 `ReorderableListView` dans le sidebar
- ✋ Icône de poignée de déplacement
- 💾 Persistance de l'ordre

```dart
ReorderableListView.builder(
  onReorder: (oldIndex, newIndex) {
    provider.reorderService(oldIndex, newIndex);
  },
  ...
)
```

---

## v1.10.0 - Polissage Final
**Date**: 17 Décembre 2024

### Corrections
- 🧹 Nettoyage du TopBar (boutons redondants supprimés)
- 📏 Taille minimale de fenêtre: 420×280
- 🔧 Correction `Scaffold.of(context)` avec `GlobalKey`
- ➡️ Alignement des boutons à droite
- 📐 Marges correctes en mode mobile

### Changement Technique Important
```dart
// Avant (erreur)
Scaffold.of(context).openDrawer();

// Après (correct)
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
_scaffoldKey.currentState?.openDrawer();
```

---

## Résumé des Versions

| Version | Fonctionnalité Principale |
|---------|---------------------------|
| 1.0.0 | Fondation du projet |
| 1.1.0 | Modèles et Provider |
| 1.2.0 | Composants UI |
| 1.3.0 | WebView |
| 1.4.0 | Paramètres |
| 1.5.0 | Favoris |
| 1.6.0 | Activation services |
| 1.7.0 | Responsive |
| 1.8.0 | Animations |
| 1.9.0 | Drag & Drop |
| 1.10.0 | Polissage |
