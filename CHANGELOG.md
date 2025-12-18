# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.9.0] - 2025-12-17

### Ajouté
- **Réorganisation des IAs** par drag & drop
  - Méthode `reorderService()` dans ServiceProvider
  - Ordre persistant entre sessions

## [1.8.0] - 2025-12-17

### Ajouté
- **Export/Import configuration** (section Données dans paramètres)
  - `exportConfigToJson()` : Copier config dans presse-papiers
  - `importConfigFromJson()` : Importer depuis presse-papiers

## [1.7.0] - 2025-12-17

### Ajouté
- **Layout responsive** adaptatif pour mobile
  - Sidebar devient Drawer sur mobile
  - TopBar adaptatif mobile/desktop
- Détection automatique taille écran

## [1.6.0] - 2025-12-17

### Ajouté
- **Persistance sessions WebView** (cookies et localStorage)
  - WebView2 (Windows) utilise stockage automatique
- Ajout dépendance `path_provider`

## [1.5.0] - 2025-12-17

### Ajouté
- **Persistance des données** via SharedPreferences
  - Favoris sauvegardés entre sessions
  - Visibilité des IAs persistante
  - IAs personnalisées persistantes
- Initialisation asynchrone des providers dans `main.dart`

## [1.4.0] - 2025-12-16

### Ajouté
- **Écran de paramètres** (icône ⚙️ dans le header sidebar)
  - Sélecteur de thème (Clair/Sombre/Système)
  - Visibilité des IAs (activer/désactiver chaque IA)
  - Formulaire d'ajout d'IA personnalisée
- **Favoris** : étoile ⭐ sur les cards pour marquer les IAs favorites (triées en premier)
- **Recherche rapide** (`Ctrl+K`) : dialogue de recherche pour sélectionner une IA
- **Aide clavier** (`F1`) : overlay listant tous les raccourcis

### Modifié
- Le menu latéral filtre maintenant les IAs désactivées
- Ajout de méthodes `toggleServiceVisibility()`, `toggleFavorite()`, `addCustomService()` dans ServiceProvider

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

## [1.0.0] - 2025-12-15

### Ajouté
- **Hub centralisé** pour accéder à plusieurs services IA (ChatGPT, Gemini, Claude, Copilot, Perplexity, Mistral)
- **Sidebar** pour navigation entre les services
- **WebViews persistantes** conservant l'état lors du changement d'onglet
- **Thème sombre** par défaut avec design premium
- Support Windows, Android et iOS
