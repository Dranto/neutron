# Neutron Skate

Un jeu incrémental (clicker) de skate pour mobile, en version web. Il se joue dans Safari ou Chrome, sans rien installer.

## Le principe

- **Tape sur la planche** pour faire une figure et gagner des **points de style**.
- **Enchaîne les tapes** pour faire monter le combo (jusqu'à ×1,5 au départ).
- Dépense ton style dans la boutique :
  - **Figures** : Kickflip, Heelflip, 360 Flip, Impossible, 900… Chaque figure apprise multiplie les points de chaque tape.
  - **Matos** : grip (points par tape), roulements (combo max), wax (une partie de la production ajoutée à chaque tape), chaussures (production des automatisations).
  - **Crew** : les automatisations, qui gagnent du style chaque seconde (pote qui filme, skatepark, Insta, sponsor, part vidéo, team pro, marque, contest). Leur production double à 10, 25, 50, 100 et 200 exemplaires. Achat ×1, ×10 ou Max.
- Une **planche dorée** traverse parfois l'écran : attrape-la pour un gros bonus.
- **Rangs** (Débutant → Icône) : chaque rang donne +15 % de style sur tout, change le soleil du spot et le graphisme sous la planche.

## Les améliorations se voient dans le jeu

- **Le spot évolue avec ton crew** : potes caméra au bord, modules de skatepark, téléphone Insta et pluie de likes, skateshop, caméra et projecteur de la part vidéo, pros qui roulent au fond, panneau géant de ta marque, gradins, foule et confettis du contest. Les gains de chaque membre s'envolent au-dessus de lui chaque seconde.
- **La planche évolue avec ton matos** : nouveaux grips (niveaux 5, 15, 40, 100), couleur des roues et étincelles à la réception (roulements), curb qui brille (wax), pieds du rider sur la planche (chaussures).
- La partie est **sauvegardée automatiquement** dans le navigateur. Pendant ton absence, ton crew continue de gagner 50 % de sa production (8 h maximum).

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `index.html` | Le jeu complet (HTML, CSS et JavaScript dans un seul fichier, sans dépendance) |
| `manifest.webmanifest` | Permet d'ajouter le jeu à l'écran d'accueil, où il s'ouvre comme une app |
| `icons/` | Icônes de l'app |

Les valeurs d'équilibrage (prix, gains, multiplicateurs) sont regroupées en haut du script dans `TRICKS`, `GEAR` et `CREW`.

## Tester en local

```sh
python3 -m http.server 8000
```

puis ouvre http://localhost:8000.

## Mettre en ligne (GitHub Pages)

Dans les réglages du dépôt GitHub : *Settings → Pages → Deploy from a branch*, branche `main`, dossier `/ (root)`.
Ouvre ensuite l'adresse indiquée dans Safari sur l'iPhone, puis *Partager → Sur l'écran d'accueil*.
