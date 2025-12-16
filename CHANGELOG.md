# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2025-12-16

### Ajouté
- **Raccourcis clavier** pour power users
  - `Ctrl+1` à `Ctrl+6` : Sélection rapide de l'IA
  - `Ctrl+←/→` : Service précédent/suivant
  - `Ctrl+T` : Toggle thème
  - `Ctrl+R` : Recharger WebView
- Méthode `selectServiceByIndex` dans ServiceProvider

## [1.2.0] - 2025-12-16

### Ajouté
- **Gestion des thèmes** : Light, Dark, et System avec persistance
- **ThemeProvider** pour la gestion centralisée du thème avec `shared_preferences`
- Bouton de toggle de thème dans la TopBar avec animation

### Modifié
- Tous les éléments UI utilisent maintenant `Theme.of(context).colorScheme` au lieu de couleurs hardcodées
- TopBar affiche le nom et les boutons avec la couleur de l'IA sélectionnée
- Cards sidebar affichent les couleurs d'accent de chaque IA en mode clair
- Toolbar WebView utilise la couleur de l'IA active pour les icônes

## [1.1.0] - 2025-12-16

### Ajouté
- **Barre d'outils de navigation WebView** avec boutons Précédent, Suivant, Recharger
- **Bouton "Ouvrir dans le navigateur"** pour ouvrir l'URL actuelle dans le navigateur système
- **Indicateur de chargement linéaire** visible en haut de la WebView
- Support de l'état de navigation (`canGoBack`, `canGoForward`) dans le provider

### Modifié
- Amélioration de la TopBar avec intégration de la toolbar de navigation
- `WindowsWebView` expose maintenant les méthodes de navigation
- `MobileWebView` expose maintenant les méthodes de navigation avec support natif

## [1.0.0] - 2025-12-16

### Ajouté
- **Hub centralisé** pour accéder à plusieurs services IA (ChatGPT, Gemini, Claude, Copilot, Perplexity, Mistral)
- **Sidebar** pour navigation entre les services
- **WebViews persistantes** conservant l'état lors du changement d'onglet
- **Thème sombre** par défaut avec design premium
- Support Windows, Android et iOS
