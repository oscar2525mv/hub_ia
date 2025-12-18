// content.js - Preloaded content for Hub IA Pipeline Presentation
// This file contains the markdown content embedded as JavaScript strings
// for faster loading without needing to fetch external files.

window.preloadedContent = {
    "prompt-content": `# Prompt Initial du Projet Hub IA

## Contexte
Ce projet a été entièrement développé par une intelligence artificielle (Claude/Gemini) en réponse à un prompt initial fourni par l'utilisateur.

---

## Prompt Initial (Français)

> **Objectif**: Développer une application Flutter multiplateforme appelée "Hub IA" qui sert de hub centralisé pour différents services d'IA (ChatGPT, Gemini, Claude, Copilot, etc.) utilisant une interface basée sur WebView.
>
> **Exigences principales**:
> - Interface moderne et intuitive avec mode sombre premium
> - Palettes de couleurs différenciées pour chaque service IA
> - Animations subtiles pour une expérience utilisateur fluide
> - Compatible Windows, Android et iOS
> - WebView pour afficher le contenu web des services IA
> - Navigation entre plusieurs URLs
> - Persistance des favoris et URLs récentes
> - Gestion des erreurs de chargement

---

## Prompt Original (Espagnol traduit)

\`\`\`
Desarrolla una aplicación Flutter con Dart que incorpore un WebView para mostrar 
contenido web. La aplicación debe:

1. Permitir cargar y navegar entre múltiples URLs
2. Tener una interfaz moderna con modo oscuro
3. Preservar el estado de los web views cargados
4. Manejar errores de carga graciosamente
5. Implementar persistencia simple para favoritos o URLs recientes
6. Incluir animaciones sutiles para una experiencia pulida

El entregable es código Dart listo para compilar con estructura clara y comentarios.
\`\`\`

---

## Technologies Demandées

| Technologie | Usage |
|-------------|-------|
| **Flutter** | Framework multiplateforme |
| **Dart** | Langage de programmation |
| **WebView** | Affichage du contenu web |
| **Provider** | Gestion d'état |
| **SharedPreferences** | Persistance des données |
| **flutter_animate** | Animations fluides |

---

## Critères de Qualité

1. **Design Premium**: Interface moderne avec glassmorphism et dégradés
2. **Responsive**: Adaptation automatique mobile/desktop
3. **Performance**: Chargement rapide et animations 60fps
4. **UX**: Navigation intuitive et retours visuels
5. **Maintenabilité**: Code structuré et commenté`,

    "tasks-content": `# Tâches du Projet Hub IA

## Vue d'Ensemble

Ce document détaille toutes les tâches réalisées par l'IA pour développer l'application Hub IA, organisées par version.

---

## Phase 1: Structure de Base (v1.0.0 - v1.1.0)

### v1.0.0 - Initialisation du Projet
- [x] Création du projet Flutter
- [x] Configuration des dépendances (\`pubspec.yaml\`)
- [x] Mise en place de la structure des dossiers
- [x] Création du système de thème (\`app_theme.dart\`)

### v1.1.0 - Modèles et Providers
- [x] Définition du modèle \`AIService\` avec couleurs personnalisées
- [x] Implémentation de \`ServiceProvider\` pour la gestion d'état
- [x] Ajout des 7 services IA initiaux (ChatGPT, Gemini, Claude, etc.)

---

## Phase 2: Interface Utilisateur (v1.2.0 - v1.3.0)

### v1.2.0 - Composants UI
- [x] Création de \`ServiceCard\` avec effets de survol et glow
- [x] Implémentation de \`ServiceCardCompact\` pour le mode condensé
- [x] Design du \`ServiceSidebar\` avec animations

### v1.3.0 - WebView Integration
- [x] Configuration de \`webview_windows\` pour Windows
- [x] Création de \`PlatformWebView\` multiplateforme
- [x] Implémentation de la barre d'outils de navigation
- [x] Gestion des états de chargement et erreurs

---

## Phase 3: Fonctionnalités Avancées (v1.4.0 - v1.6.0)

### v1.4.0 - Écran des Paramètres
- [x] Création de \`SettingsScreen\`
- [x] Liste des services disponibles
- [x] Section "À propos" de l'application

### v1.5.0 - Système de Favoris
- [x] Ajout de la propriété \`isFavorite\` au modèle
- [x] Bouton étoile sur chaque carte de service
- [x] Persistance des favoris avec \`SharedPreferences\`

### v1.6.0 - Activation/Désactivation des Services
- [x] Propriété \`isEnabled\` pour chaque service
- [x] Toggle dans les paramètres
- [x] Filtrage des services désactivés dans le sidebar

---

## Phase 4: Expérience Utilisateur (v1.7.0 - v1.9.0)

### v1.7.0 - Layout Responsive
- [x] Détection automatique mobile/desktop (< 600px)
- [x] Sidebar en \`Drawer\` pour mobile
- [x] Menu hamburger fonctionnel
- [x] Adaptation des marges et espacements

### v1.8.0 - Animations et Transitions
- [x] Animations d'entrée avec \`flutter_animate\`
- [x] Effets de fade et slide sur les cartes
- [x] Indicateur de chargement animé (LoadingDots)
- [x] Pulsation sur l'indicateur de service actif

### v1.9.0 - Drag & Drop
- [x] Réorganisation des services par glisser-déposer
- [x] \`ReorderableListView\` dans le sidebar
- [x] Icône de poignée de déplacement
- [x] Persistance de l'ordre des services

---

## Phase 5: Polissage (v1.10.0)

### v1.10.0 - Corrections UI/UX
- [x] Nettoyage du TopBar (suppression boutons nav redondants)
- [x] Taille minimale de fenêtre (420x280)
- [x] Correction du menu hamburger (\`GlobalKey<ScaffoldState>\`)
- [x] Alignement des boutons de navigation à droite
- [x] Marges correctes pour le mode mobile

---

## Statistiques

| Métrique | Valeur |
|----------|--------|
| **Fichiers Dart créés** | ~25 |
| **Lignes de code** | ~3500 |
| **Versions** | 10 |
| **Services IA intégrés** | 7 |
| **Plateformes supportées** | Windows, Android, iOS |`,

    "walkthrough-content": `# Walkthrough du Projet Hub IA

## Introduction

Ce document présente le parcours de développement de l'application Hub IA, une application Flutter développée entièrement par intelligence artificielle.

---

## Architecture du Projet

\`\`\`
lib/
├── main.dart                 # Point d'entrée
├── core/
│   └── theme/
│       └── app_theme.dart    # Système de thème
├── models/
│   └── ai_service.dart       # Modèle de données
├── providers/
│   ├── service_provider.dart # Gestion d'état
│   └── theme_provider.dart   # Gestion du thème
├── screens/
│   ├── home_screen.dart      # Écran principal
│   └── settings_screen.dart  # Paramètres
└── widgets/
│   ├── cards/
│   │   ├── service_card.dart
│   │   └── service_card_compact.dart
│   ├── sidebar/
│   │   └── service_sidebar.dart
│   └── webview/
│       ├── platform_webview.dart
│       └── webview_toolbar.dart
\`\`\`

---

## Fonctionnalités Clés

### 1. Hub Centralisé de Services IA

![Sidebar avec services](file:///c:/Users/martv/Proyect/projet_webview/hub_ia/docs/assets/sidebar.png)

L'application permet d'accéder rapidement à 7 services IA populaires:

| Service | Couleur | URL |
|---------|---------|-----|
| ChatGPT | Vert | chat.openai.com |
| Gemini | Bleu | gemini.google.com |
| Claude | Orange | claude.ai |
| Copilot | Cyan | copilot.microsoft.com |
| Perplexity | Turquoise | perplexity.ai |
| DeepSeek | Violet | chat.deepseek.com |
| Mistral | Orange foncé | chat.mistral.ai |

### 2. Interface Premium

- **Mode sombre** par défaut avec dégradés subtils
- **Glassmorphism** sur les composants
- **Animations fluides** (60fps) sur toutes les interactions
- **Couleurs adaptatives** selon le service sélectionné

### 3. Layout Responsive

\`\`\`dart
// Détection automatique du mode
final isMobile = constraints.maxWidth < 600;

// Sidebar en Drawer pour mobile
drawer: isMobile ? const Drawer(child: ServiceSidebar()) : null,
\`\`\`

### 4. Système de Favoris et Réorganisation

- Marquer les services comme favoris (étoile)
- Réorganiser par drag & drop
- Activer/désactiver les services
- Persistance avec SharedPreferences

---

## Tests et Validation

### Plateformes Testées

| Plateforme | Statut | Notes |
|------------|--------|-------|
| Windows 11 | ✅ Validé | WebView2 requis |
| Android | ✅ Validé | API 21+ |
| iOS | 🔄 Non testé | Devrait fonctionner |

### Points de Validation

1. ✅ Chargement des 7 services IA
2. ✅ Navigation WebView (arrière/avant/recharger)
3. ✅ Persistance des favoris après redémarrage
4. ✅ Responsive: adaptation mobile/desktop
5. ✅ Drag & drop fonctionnel
6. ✅ Animations sans lag

---

## Captures d'Écran

### Mode Desktop
- Sidebar étendu avec toutes les informations
- Barre d'outils de navigation complète
- WebView avec bordure colorée selon le service

### Mode Mobile
- Menu hamburger pour accéder au sidebar
- Interface simplifiée
- Drawer avec liste des services

---

## Conclusion

L'application Hub IA démontre la capacité de l'IA à:
1. Comprendre des exigences complexes
2. Structurer un projet Flutter professionnel
3. Implémenter des patterns modernes (Provider, Responsive)
4. Créer une interface utilisateur premium
5. Gérer les erreurs et cas limites`,

    "versions-content": `# Historique des Versions - Hub IA

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
- \`pubspec.yaml\`
- \`lib/main.dart\`
- \`lib/core/theme/app_theme.dart\`

---

## v1.1.0 - Modèles de Données
**Date**: 16 Décembre 2024

### Nouveautés
- 📊 Modèle \`AIService\` avec propriétés complètes
- 🔄 \`ServiceProvider\` pour la gestion d'état
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
- 🃏 \`ServiceCard\` avec effets visuels
- 📱 \`ServiceCardCompact\` pour vue condensée
- 📐 \`ServiceSidebar\` avec animation d'expansion

### Caractéristiques
- Effet de survol (hover)
- Bordure lumineuse (glow)
- Animation de pulsation pour l'élément actif

---

## v1.3.0 - Intégration WebView
**Date**: 16 Décembre 2024

### Nouveautés
- 🌐 \`PlatformWebView\` multiplateforme
- 🧭 \`WebViewToolbar\` avec navigation
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
- ⚙️ \`SettingsScreen\` complet
- 📋 Liste de tous les services
- ℹ️ Section "À propos"

---

## v1.5.0 - Système de Favoris
**Date**: 16 Décembre 2024

### Nouveautés
- ⭐ Propriété \`isFavorite\` sur les services
- 🔘 Bouton étoile sur chaque carte
- 💾 Persistance avec \`SharedPreferences\`

\`\`\`dart
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
\`\`\`

---

## v1.6.0 - Activation des Services
**Date**: 16 Décembre 2024

### Nouveautés
- ✅ Propriété \`isEnabled\` par service
- 🔀 Toggle dans les paramètres
- 🚫 Filtrage des services désactivés

---

## v1.7.0 - Layout Responsive
**Date**: 16 Décembre 2024

### Nouveautés
- 📱 Détection automatique mobile (< 600px)
- 🍔 Menu hamburger pour mobile
- 📥 Sidebar en \`Drawer\`
- 📐 Marges adaptatives

\`\`\`dart
// Breakpoint responsive
final isMobile = constraints.maxWidth < 600;
\`\`\`

---

## v1.8.0 - Animations Avancées
**Date**: 16 Décembre 2024

### Nouveautés
- ✨ Package \`flutter_animate\` intégré
- 🎬 Animations d'entrée (fade + slide)
- 💫 \`LoadingDots\` animé
- 💓 Pulsation sur l'indicateur actif

---

## v1.9.0 - Drag & Drop
**Date**: 17 Décembre 2024

### Nouveautés
- 🔀 \`ReorderableListView\` dans le sidebar
- ✋ Icône de poignée de déplacement
- 💾 Persistance de l'ordre

\`\`\`dart
ReorderableListView.builder(
  onReorder: (oldIndex, newIndex) {
    provider.reorderService(oldIndex, newIndex);
  },
  ...
)
\`\`\`

---

## v1.10.0 - Polissage Final
**Date**: 17 Décembre 2024

### Corrections
- 🧹 Nettoyage du TopBar (suppression boutons nav redondants)
- 📏 Taille minimale de fenêtre: 420×280
- 🔧 Correction \`Scaffold.of(context)\` avec \`GlobalKey\`
- ➡️ Alignement des boutons à droite
- 📐 Marges correctes en mode mobile

### Changement Technique Important
\`\`\`dart
// Avant (erreur)
Scaffold.of(context).openDrawer();

// Après (correct)
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
_scaffoldKey.currentState?.openDrawer();
\`\`\`

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
| 1.10.0 | Polissage |`,

    "defis-content": `# Défis et Difficultés Rencontrés par l'IA

## Introduction

Ce document détaille les problèmes les plus significatifs rencontrés lors du développement par IA, ainsi que les temps de résolution. Ces défis illustrent les limites actuelles de l'intelligence artificielle dans un contexte de développement réel.

---

## 🔴 Défi 1: Perte de Code après Git Rebase (CRITIQUE)

### Problème
Après une opération \`git rebase\`, plusieurs commits (v1.4.0 à v1.9.0) ont été complètement perdus. L'IA n'avait pas correctement sauvegardé les changements avant l'opération.

### Impact
- Perte massive de fonctionnalités développées sur plusieurs heures
- Nécessité de retrouver le code via \`git reflog\`
- Reconstruction partielle de certaines fonctionnalités

### Temps de Résolution
⏱️ **~2 heures** - Recherche dans l'historique git, identification des commits perdus, et restauration manuelle.

---

## 🟠 Défi 2: Erreurs d'Overflow lors du Redimensionnement du Sidebar

### Problème
Lorsque le sidebar de gauche était rétréci ou en mode compact, des erreurs d'overflow apparaissaient:
\`\`\`
A RenderFlex overflowed by X pixels
\`\`\`

### Cause
Les éléments à l'intérieur du sidebar n'étaient pas contraints correctement et dépassaient de leur conteneur parent.

### Temps de Résolution
⏱️ **~45 minutes**

---

## 🟠 Défi 3: Erreurs d'Overflow lors du Redimensionnement de la Fenêtre

### Problème
En réduisant la taille de la fenêtre de l'application, le TopBar et d'autres composants causaient des erreurs d'overflow, particulièrement sur des écrans < 400px de largeur.

### Cause
Trop d'éléments dans les conteneurs horizontaux sans gestion de la flexibilité et du débordement de texte.

### Temps de Résolution
⏱️ **~30 minutes**

---

## 🟠 Défi 4: Répétition des Mêmes Erreurs

### Problème
L'IA a reproduit les mêmes types d'erreurs à plusieurs reprises au cours du développement, notamment:
- Erreurs de contexte Flutter (\`Scaffold.of()\`)
- Problèmes de layout responsive
- Oubli de sauvegarder avant des opérations git

### Observation
**L'IA ne retient pas les leçons apprises** d'une session à l'autre ou même au sein d'une même session longue. Les mêmes corrections ont dû être appliquées plusieurs fois.

### Temps de Résolution
⏱️ **~1 heure cumulée** sur l'ensemble des répétitions.

---

## 🟠 Défi 5: Alignement des Boutons du TopBar

### Problème
Les boutons de navigation (précédent, suivant, recharger) n'étaient pas correctement alignés à droite du TopBar. Malgré plusieurs tentatives, l'IA peinait à comprendre la cascade de contraintes dans Flutter.

### Cause
Le conteneur parent ne prenait pas la largeur complète, empêchant le \`Spacer()\` de fonctionner correctement.

### Temps de Résolution
⏱️ **~45 minutes**

---

## ⚠️ Problème Majeur: Instabilité des Outils IA

### Contexte
Au-delà des défis techniques du code, le développement a été significativement ralenti par des **problèmes d'infrastructure**:

### Problèmes Rencontrés
1. **Chutes fréquentes d'Antigravity** - L'outil de développement assisté par IA a planté plusieurs fois, causant des pertes de contexte.

2. **Indisponibilité des modèles IA** - Les modèles (Claude, Gemini) étaient parfois saturés ou indisponibles, obligeant à attendre ou changer de modèle.

3. **Perte de contexte** - Après chaque interruption, l'IA devait "réapprendre" l'état du projet, causant des erreurs et des incohérences.

4. **Troncature des conversations** - Les conversations longues étaient tronquées, perdant l'historique des décisions prises.

### Impact sur le Temps
⏱️ **Estimation: ~2 heures perdues** dues aux interruptions, attentes, et reconstructions du contexte.

---

## Statistiques des Difficultés

| Défi | Gravité | Temps de Résolution |
|------|---------|---------------------|
| Perte Git Rebase | 🔴 Critique | ~2 heures |
| Overflow Sidebar | 🟠 Moyen | ~45 minutes |
| Overflow Fenêtre | 🟠 Moyen | ~30 minutes |
| Répétition Erreurs | 🟠 Moyen | ~1 heure |
| Alignement Boutons | 🟠 Moyen | ~45 minutes |
| **Instabilité Outils** | ⚠️ Externe | ~2 heures |

### Temps Total Estimé sur les Problèmes
- **Défis techniques**: ~5 heures
- **Problèmes d'infrastructure**: ~2 heures
- **Total**: ~7 heures de temps perdu

---

## Conclusion

Les principales limitations observées de l'IA:

1. **Pas de mémoire persistante** - L'IA répète les mêmes erreurs car elle ne retient pas les leçons.

2. **Difficulté avec le visuel** - L'IA ne "voit" pas le résultat et dépend du feedback humain.

3. **Gestion Git risquée** - Les opérations destructives peuvent causer des pertes majeures.

4. **Dépendance à l'infrastructure** - Les interruptions de service impactent fortement la productivité.

5. **Complexité Flutter** - Les concepts de contexte et contraintes restent difficiles pour l'IA.

Ces observations suggèrent que l'IA est un **outil d'assistance puissant** mais nécessite une **supervision humaine constante** pour éviter les erreurs critiques et valider les résultats visuels.`
};
