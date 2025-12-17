# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.10.0] - 2025-12-17

### Modifié
- **Nettoyage complet de la TopBar**
  - Suppression des boutons de navigation entre IAs (précédent/suivant)
  - Suppression du toggle de thème de la TopBar (disponible dans Paramètres)
  - WebViewToolbar correctement alignée à droite
- **Améliorations responsive mobile**
  - WebView avec marge gauche en mode mobile
  - Texte avec ellipsis pour éviter le débordement
  - Icônes adaptatives selon la taille d'écran
- **Taille minimale de fenêtre réduite de 30%** : 420x280 (avant 600x400)

## [1.9.0] - 2025-12-16

### Ajouté
- **Réorganisation des IAs** par drag & drop
  - ReorderableListView dans le sidebar
  - Poignées de drag cachées en mode compact
  - Mappage d'indices filtrés vers globaux  
  - Ordre persistant entre sessions

## [1.8.0] - 2025-12-16

### Ajouté
- **Export/Import configuration** (section Données dans paramètres)
  - `exportConfigToJson()` : Copier config dans presse-papiers
  - `importConfigFromJson()` : Importer depuis presse-papiers

## [1.7.0] - 2025-12-16

### Ajouté
- **Layout responsive** adaptatif pour mobile
  - Sidebar devient Drawer sur mobile
  - TopBar adaptatif mobile/desktop
- Détection automatique taille écran

## [1.6.0] - 2025-12-16

### Ajouté
- **Persistance sessions WebView** (cookies et localStorage)
  - WebView2 (Windows) utilise stockage automatique
- Ajout dépendance `path_provider`

## [1.5.0] - 2025-12-16

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
  - Gestion des favoris
  - Gestion de la visibilité des IAs
  - Gestion des IAs personnalisées
  - Export/Import de configuration
- **Recherche rapide** avec Ctrl+K
- **Aide contextuelle** avec F1

## [1.3.0] - 2025-12-15

### Ajouté
- **Raccourcis clavier**
  - Ctrl+K : Recherche rapide
  - F1 : Aide
  - Ctrl+1-9 : Sélection rapide d'IA
  - Ctrl+Left/Right : Navigation entre IAs

## [1.2.0] - 2025-12-15

### Ajouté
- **Système de thèmes** complet (clair/sombre/système)
- Provider de thème avec persistance

## [1.1.0] - 2025-12-15

### Ajouté
- **Contrôles de navigation WebView** dans TopBar
  - Boutons retour/avant
  - Bouton recharger
  - Bouton ouvrir dans navigateur
- État de navigation (canGoBack/canGoForward)

## [1.0.0] - 2025-12-15

### Première version
- Hub centralisé pour services IA (ChatGPT, Gemini, Claude, etc.)
- Interface WebView multiplateforme
- Sidebar avec liste de services
- Navigation entre services
- Design moderne avec Material 3
