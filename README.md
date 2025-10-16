# Atelier de Développement Mobile Flutter - UX/UI Frontend

## Thème : Les fondamentaux du Material Design 3 de Google

Ce projet contient deux ateliers pratiques pour apprendre Material Design 3 avec Flutter.

## Structure du Projet

```
Atelier1/
├── lib/
│   ├── main.dart           # Point d'entrée de l'application
│   ├── atelier1.dart       # Page de profil utilisateur (Material 3)
│   └── atelier2.dart       # Liste de produits (Material 3)
├── images/
│   └── person1.png         # Image de profil (à ajouter)
└── pubspec.yaml            # Configuration du projet
```

## Installation

1. Assurez-vous d'avoir Flutter installé (version 3.0+)
2. Clonez ce projet
3. Ajoutez une image `person1.png` dans le dossier `images/`
4. Exécutez les commandes suivantes :

```bash
flutter pub get
flutter run
```

## Ateliers

### Atelier 1 : Page de profil utilisateur
- Photo de profil circulaire avec badge de vérification
- Typographie Material 3
- Statistiques avec chips
- Carte "À propos"
- Bouton flottant étendu

### Atelier 2 : Liste de produits
- Cards Material 3
- Badges "NEW" conditionnels
- Images réseau
- Notation par étoiles
- Boutons d'action

## Changer d'atelier

Dans `lib/main.dart`, modifiez la ligne `home:` :

```dart
// Pour l'atelier 1
home: const ProfilePageM3(),

// Pour l'atelier 2
home: const ProductListPageM3(),
```

## Ressources

- [Material 3 pour Flutter](https://m3.material.io/develop/flutter)
- [Widgets Material](https://docs.flutter.dev/ui/widgets/material)
- [Widgets de Layout](https://docs.flutter.dev/ui/widgets/layout)
