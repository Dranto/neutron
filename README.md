# Neutron Skate

Un jeu de skate pour mobile, en version web : tu rides un skatepark qui se construit au fil de tes améliorations. Il se joue dans Safari ou Chrome, sans rien installer.

## Le ride

Le rider avance tout seul, en vue de côté.

- **Tape** : ollie (aussi pour sortir d'un grind).
- **Glisse en l'air** dans une direction : la figure apprise pour cette direction (← Kickflip, → Heelflip, ↓ Pop Shove-it, ↑ Indy Grab, ↙ 360 Flip, ↘ Hardflip, ↖ Impossible, ↗ 900). Glisser depuis le sol fait l'ollie et la figure d'un seul geste.
- **Barres et ledges** : retombe dessus pour grinder.
- **Kickers et rampes** : ils t'envoient en l'air pour enchaîner plusieurs figures.
- **Gaps** : franchis le trou en l'air pour un bonus.
- **Réception** : si la figure n'est pas terminée quand tu touches le sol ou la barre, tu tombes et tu perds le combo.
- **Combo** : points × nombre d'éléments enchaînés, encaissés après un court moment de roule au sol. Un saut sans figure rapporte ses points directement.
- **Lettres S-K-A-T-E** et **planches dorées** à attraper en l'air pour des bonus.
- Clavier sur ordinateur : espace, flèches, Q/E/A/D pour les diagonales.

## Les améliorations

Le panneau du bas se **glisse** (ou se touche) pour l'agrandir, le réduire ou le masquer presque entièrement.

- **Figures** : nouvelles figures et nouvelles directions.
- **Park** : chaque module construit apparaît sur le parcours (kicker, ledge, funbox avec rail, escalier et rampe, gap, grosse rampe, méga rampe) et donne +10 % de points en ride.
- **Matos** : grip (points des figures), planche pro (hauteur d'ollie), roulements (vitesse, couleur des roues), wax (grinds), chaussures (réceptions plus tolérantes).
- **Crew** : production passive de style ; chaque membre apparaît dans le décor (potes qui filment au bord des modules, likes Insta, skateshop, filmeur qui te suit, pros au fond, panneau de ta marque, gradins et confettis du contest).
- **Rangs** : de Débutant à Icône, chacun donne +15 % de style, change le soleil et la couleur du dessous de la planche.

La partie est sauvegardée dans le navigateur. Pendant ton absence, le crew gagne 50 % de sa production (8 h maximum).

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `index.html` | Le jeu complet (HTML, CSS et JavaScript dans un seul fichier, sans dépendance) |
| `manifest.webmanifest` | Permet d'ajouter le jeu à l'écran d'accueil, où il s'ouvre comme une app |
| `icons/` | Icônes de l'app |

Les valeurs d'équilibrage sont regroupées en haut du script : `TRICKS`, `PARK`, `GEAR`, `CREW`, `RANKS`.

## Tester en local

```sh
python3 -m http.server 8000
```

puis ouvre http://localhost:8000.

## Mettre en ligne (GitHub Pages)

Dans les réglages du dépôt GitHub : *Settings → Pages → Deploy from a branch*, branche `main`, dossier `/ (root)`.
Ouvre ensuite l'adresse indiquée dans Safari sur l'iPhone, puis *Partager → Sur l'écran d'accueil*.
