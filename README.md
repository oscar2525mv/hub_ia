# 🧠 Hub IA

**Application Flutter centralisée pour accéder à vos services d'intelligence artificielle préférés.**

---

## 📝 Description

**Hub IA** est une application multiplateforme (Windows, Android, iOS) développée avec Flutter. Elle agit comme un navigateur spécialisé, regroupant les assistants IA les plus performants (ChatGPT, Gemini, Claude, etc.) dans une interface unifiée, moderne et fluide.

Ce projet a été entièrement conçu et développé avec l'assistance d'une intelligence artificielle, démontrant la capacité de l'IA à créer des solutions logicielles complètes et fonctionnelles.

---

## ✨ Fonctionnalités Clés

- **🎯 Hub Centralisé** : Accès rapide à 7 services IA majeurs pré-configurés.
- **🎨 Interface Premium** : Design soigné avec mode sombre par défaut, effets de glassmorphism et animations fluides (60fps).
- **🌗 Thème Adaptatif** : La couleur de l'interface s'adapte dynamiquement au service IA sélectionné.
- **⭐ Gestion des Favoris** : Marquez vos outils préférés pour y accéder plus rapidement.
- **📱 Responsive Design** : Interface optimisée pour Desktop (avec sidebar complet) et Mobile (avec menu tiroir).
- **🕹️ Personnalisation** : Réorganisez l'ordre des services par simple glisser-déposer (Drag & Drop) et activez/désactivez ceux que vous n'utilisez pas.
- **🔄 Navigation Web** : Fonctionnalités de navigateur intégrées (précédent, suivant, recharger) avec persistance de l'état.

---

## 🤖 Services Intégrés

| Service | Description |
|---------|-------------|
| **ChatGPT** | L'assistant conversationnel de référence par OpenAI. |
| **Gemini** | Le modèle multimodal avancé de Google. |
| **Claude** | L'IA d'Anthropic, reconnue pour sa capacité d'analyse et de rédaction. |
| **Copilot** | L'assistant de Microsoft intégré à l'écosystème Bing. |
| **Perplexity** | Moteur de recherche conversationnel puissant. |
| **DeepSeek** | Modèle de langage performant axé sur le code. |
| **Mistral** | L'IA open-weights française de haute performance. |

---

## 🛠️ Stack Technique

- **Framework** : Flutter (Dart)
- **Gestion d'État** : Provider
- **Composants Web** : `webview_flutter`, `webview_windows`
- **Animations** : `flutter_animate`
- **Persistance** : `shared_preferences`

---

## 🚀 Installation et Utilisation

### Prérequis

- Flutter SDK installé
- Environnement de développement (VS Code, Android Studio)

### Lancer l'application

1.  **Cloner le projet** :
    ```bash
    git clone https://github.com/votre-utilisateur/hub_ia.git
    cd hub_ia
    ```

2.  **Installer les dépendances** :
    ```bash
    flutter pub get
    ```

3.  **Lancer (Desktop)** :
    ```bash
    flutter run -d windows
    ```

4.  **Lancer (Mobile)** :
    Connectez un appareil Android ou lancez un émulateur.
    ```bash
    flutter run
    ```

---

## 📂 Structure du Projet

```
lib/
├── core/
│   └── theme/          # Configuration du thème (couleurs, styles)
├── models/             # Modèles de données (AIService)
├── providers/          # Gestion d'état de l'application
├── screens/            # Écrans principaux (Home, Settings)
├── widgets/            # Composants réutilisables (Cards, Sidebar, WebView)
└── main.dart           # Point d'entrée
```

---

## ⚠️ Avertissement

Cette application utilise des WebViews pour afficher des services tiers. Vous devez disposer d'un compte valide pour chaque service (OpenAI, Google, etc.) pour les utiliser. Cette application n'est pas affiliée aux fournisseurs de services IA intégrés.
