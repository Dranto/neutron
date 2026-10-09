# Neutron

Un petit jeu d'arcade pour iPhone, écrit en SwiftUI.

Tu contrôles un **neutron** (bleu) en bas de l'écran :

- **Glisse ton doigt** à gauche / à droite pour le déplacer.
- **Évite les protons** (rouges) : une collision et la partie est finie.
- **Attrape les photons** (jaunes) : +25 points chacun.
- Le score augmente avec le temps, et les particules tombent de plus en plus vite.
- Le meilleur score est sauvegardé sur l'appareil.

## Lancer le jeu

Prérequis : un Mac avec **Xcode 16** ou plus récent (iOS 17 minimum).

1. Ouvrir `Neutron.xcodeproj` dans Xcode.
2. Choisir un simulateur iPhone (ou ton iPhone branché) puis **⌘R**.
3. Pour un vrai iPhone : dans *Signing & Capabilities*, choisir ton équipe
   (un compte Apple gratuit suffit) et, si besoin, changer l'identifiant
   `com.example.neutron` en un identifiant unique.

## Structure

| Fichier | Rôle |
| --- | --- |
| `Neutron/NeutronApp.swift` | Point d'entrée de l'application |
| `Neutron/GameModel.swift` | Logique du jeu : apparition des particules, déplacements, collisions, score |
| `Neutron/ContentView.swift` | Affichage (Canvas), commandes tactiles, menus et retours haptiques |
| `Neutron/Assets.xcassets` | Icône de l'app et couleur d'accent |
