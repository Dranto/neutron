# Neutron

Un petit jeu d'arcade pour mobile, en version web. Il se joue directement dans Safari ou Chrome, sans rien installer.

Tu guides un **neutron** (n⁰, bleu) à travers une chambre à bulles :

- **Glisse ton doigt** n'importe où sur l'écran : le neutron suit le mouvement, sans que ton doigt le cache.
- **Évite les protons** (p⁺, rouges) : un seul contact et la partie est finie.
- **Attrape les photons** (γ, jaunes) : +25 MeV chacun.
- Ton énergie (le score, en MeV) augmente avec le temps, et les particules tombent de plus en plus vite.
- Ton record est enregistré dans le navigateur.
- Il y a un bouton pause, et le jeu se met en pause tout seul si tu quittes l'onglet.
- Sur ordinateur, tu peux jouer avec les flèches du clavier ; Échap met en pause.

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `index.html` | Le jeu complet (HTML, CSS et JavaScript dans un seul fichier, sans dépendance) |
| `manifest.webmanifest` | Permet d'ajouter le jeu à l'écran d'accueil, où il s'ouvre en plein écran comme une app |
| `icons/` | Icônes de l'app |

## Tester en local

Ouvre `index.html` dans un navigateur, ou lance un petit serveur :

```sh
python3 -m http.server 8000
```

puis ouvre http://localhost:8000.

## Mettre en ligne (GitHub Pages)

Dans les réglages du dépôt GitHub : *Settings → Pages → Deploy from a branch*, choisis la branche et le dossier `/ (root)`.
Ouvre ensuite l'adresse indiquée dans Safari sur l'iPhone, puis *Partager → Sur l'écran d'accueil*.
