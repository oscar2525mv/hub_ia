# Défis et Difficultés Rencontrés par l'IA

## Introduction

Ce document détaille les problèmes les plus significatifs rencontrés lors du développement par IA, ainsi que les temps de résolution. Ces défis illustrent les limites actuelles de l'intelligence artificielle dans un contexte de développement réel.

---

## 🔴 Défi 1: Perte de Code après Git Rebase (CRITIQUE)

### Problème
Après une opération `git rebase`, plusieurs commits (v1.4.0 à v1.9.0) ont été complètement perdus. L'IA n'avait pas correctement sauvegardé les changements avant l'opération.

### Impact
- Perte massive de fonctionnalités développées sur plusieurs heures
- Nécessité de retrouver le code via `git reflog`
- Reconstruction partielle de certaines fonctionnalités

### Temps de Résolution
⏱️ **~2 heures** - Recherche dans l'historique git, identification des commits perdus, et restauration manuelle.

---

## 🟠 Défi 2: Erreurs d'Overflow lors du Redimensionnement du Sidebar

### Problème
Lorsque le sidebar de gauche était rétréci ou en mode compact, des erreurs d'overflow apparaissaient:
```
A RenderFlex overflowed by X pixels
```

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
- Erreurs de contexte Flutter (`Scaffold.of()`)
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
Le conteneur parent ne prenait pas la largeur complète, empêchant le `Spacer()` de fonctionner correctement.

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

Ces observations suggèrent que l'IA est un **outil d'assistance puissant** mais nécessite une **supervision humaine constante** pour éviter les erreurs critiques et valider les résultats visuels.
