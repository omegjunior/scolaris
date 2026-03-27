# Dossier de cadrage métier à envoyer au métier

## 1. Objet du document

Ce document a pour but de préparer la phase de cadrage métier du module `Scolaris` avant tout développement complémentaire.

Il doit permettre :

- d'identifier les incohérences présentes dans les fichiers manuels actuels ;
- de lister tous les arbitrages métier à prendre ;
- de normaliser le référentiel pédagogique ;
- de formaliser les règles de calcul académiques ;
- de sécuriser le paramétrage du module pour ne pas reproduire les incohérences existantes.

## 2. Résultat attendu du cadrage

À l'issue du cadrage métier, l'établissement doit avoir validé :

- un référentiel pédagogique unique et officiel ;
- des codes et libellés de matières stabilisés ;
- une règle de calcul des moyennes et des crédits univoque ;
- une règle de gestion des rattrapages, absences, compensations et mentions ;
- une décision claire sur ce qui est publié à l'étudiant et à quel moment ;
- une matrice claire des rôles et habilitations.

Sans cette validation, le risque principal est d'automatiser des erreurs ou des divergences déjà présentes dans les feuilles manuelles.

## 3. Documents de référence analysés

- `2025-2026 REPARTITION DES MATIERES PAR TYPOLOGIES DE COURS ET SUIVANT LES SEMESTRES.docx`
- `GDPMIS_2022-2023_Notes_Semestre 1.xlsx`
- `RELEVE DE NOTES.xlsx`

## 4. Constats et incohérences déjà détectés

### 4.1 Incohérences de crédits

#### Semestre 1

Le document Word de répartition 2025-2026 indique pour le `Semestre 1` :

- `MPF = 14 crédits`
- `MPOC = 6 crédits`
- `MCO = 3 crédits`
- `LOS = 5 crédits`
- `MOP/MOO = 0 crédit`
- `Total affiché = 30 crédits`

Or la somme détaillée visible des crédits du document aboutit à `28 crédits` et non `30`.

#### Semestre 4

Le document Word indique pour le `Semestre 4` :

- `MPF = 20 crédits`
- `MPOC = 9 crédits`
- `LOS = 5 crédits` sur la ligne de total
- `MCO = 0 crédit`
- `Total affiché = 34 crédits`

Mais les matières LOS visibles totalisent `4 crédits` et non `5`, ce qui rend le total global ambigu.

#### Semestre 1 dans le modèle Excel de relevé

Le modèle `RELEVE DE NOTES.xlsx` montre pour le `Semestre 1` :

- un `TOTAL GENERAL` à `12` coefficients ;
- un `TOTAL CREDITS VALIDES` à `31`.

Cela contredit à la fois :

- l'objectif global de `180 crédits` sur 6 semestres ;
- le document Word de répartition 2025-2026 ;
- la composition détaillée des matières du `Semestre 1`.

### 4.2 Incohérences de référentiel pédagogique

Les documents ne sont pas parfaitement alignés sur les matières d'un même semestre.

Exemples constatés :

- le `Semestre 1` du relevé Excel contient `Communication sociale I` dans `MCO`, alors que le document Word du référentiel 2025-2026 du `Semestre 1` n'affiche que `Psychologie I` et `Latin` dans cette typologie ;
- certains libellés diffèrent selon les documents :
  - `Propédeutique philosophique`
  - `Propédeutique de la Philosophie`
- les codes de typologie ne sont pas parfaitement stabilisés :
  - `MOP`
  - `MOO`
  - `Matières d'orientation propre`
  - `Matières d'ouverture optionnelle`

### 4.3 Incohérences de calcul

Les classeurs Excel utilisent une logique implicite qui doit être validée métier avant implémentation :

- si la note de devoir est vide, la moyenne de matière reprend la note d'examen ;
- sinon la moyenne de matière observée dans les feuilles est calculée avec une formule du type :
  - `((examen * coefficient_matiere) + devoir) / (coefficient_matiere + 1)`
- la `moyenne coefficientée` est calculée comme :
  - `moyenne_matiere * coefficient_matiere`

Cette logique pose une question métier importante :

- le `coefficient de la matière` sert-il seulement à la pondération semestrielle ;
- ou sert-il aussi de poids de l'épreuve `examen` dans la moyenne de matière ?

Ce point ne doit pas être laissé implicite dans le module.

### 4.4 Incohérences de publication

Les feuilles actuelles ne permettent pas d'établir clairement :

- quand une note devient officielle ;
- qui valide la note ;
- si un étudiant peut voir une note avant validation ;
- si les crédits affichés sont des crédits calculés automatiquement ou saisis manuellement.

## 5. Décisions métier à obtenir avant tout développement supplémentaire

## 5.1 Référentiel pédagogique

### DM-REF-01

- Sujet : référentiel officiel
- Question : quel document fait foi en cas de divergence entre le Word de répartition, la feuille de notes et le modèle de relevé ?
- Choix à valider :
  - le Word 2025-2026 fait foi ;
  - le relevé Excel fait foi ;
  - un nouveau référentiel consolidé doit être produit.

### DM-REF-02

- Sujet : total des crédits
- Question : confirmer officiellement la cible de `180 crédits` sur l'ensemble des `6 semestres`.

### DM-REF-03

- Sujet : crédits par semestre
- Question : confirmer les crédits cibles de chaque semestre, en particulier `S1` et `S4`.

### DM-REF-04

- Sujet : codes de typologie
- Question : quelle nomenclature officielle retenir ?
- Choix à valider :
  - `MPF`, `MPOC`, `MCO`, `LOS`, `MOP`
  - ou autre nomenclature officielle.

### DM-REF-05

- Sujet : matières optionnelles / orientation propre
- Question : faut-il distinguer fonctionnellement :
  - matières obligatoires ;
  - matières optionnelles ;
  - matières propres à l'orientation ;
  - matières sans crédits ;
  - matières non prises en compte dans la moyenne.

### DM-REF-06

- Sujet : codification des matières
- Question : faut-il un code unique stable par matière sur tout le cycle ou un code contextualisé par semestre ?
- Choix possibles :
  - code unique par matière ;
  - code composé `niveau-semestre-typologie-ordre`.

### DM-REF-07

- Sujet : versionnement du référentiel
- Question : à partir de quand une modification de matière, coefficient ou crédit doit-elle créer une nouvelle version du référentiel ?

## 5.2 Gestion des étudiants et du parcours

### DM-PAR-01

- Sujet : identité de l'étudiant
- Question : quelles informations sont obligatoires dans le dossier étudiant ?
- Liste à confirmer :
  - matricule ;
  - nom ;
  - prénoms ;
  - date de naissance ;
  - lieu de naissance ;
  - niveau ;
  - année académique ;
  - statut.

### DM-PAR-02

- Sujet : statut académique
- Question : quels statuts métier doivent être gérés ?
- Proposition :
  - inscrit ;
  - redoublant ;
  - suspendu ;
  - abandonné ;
  - diplômé.

### DM-PAR-03

- Sujet : redoublement
- Question : comment gérer un étudiant qui refait une année ou un semestre ?
- Points à valider :
  - conservation de l'historique ;
  - nouvelle inscription ;
  - reprise partielle de matières ;
  - reprise partielle de crédits.

## 5.3 Saisie des notes

### DM-NOT-01

- Sujet : types d'évaluation
- Question : quels types d'évaluation doivent être supportés en v1 ?
- Proposition :
  - devoir ;
  - examen ;
  - rattrapage ;
  - oral ;
  - autre.

### DM-NOT-02

- Sujet : nombre d'évaluations par matière
- Question : une matière peut-elle avoir plusieurs devoirs, plusieurs examens, ou seulement un devoir et un examen ?

### DM-NOT-03

- Sujet : note absente
- Question : comment distinguer :
  - note non encore saisie ;
  - absence ;
  - absence justifiée ;
  - absence non justifiée ;
  - note annulée.

### DM-NOT-04

- Sujet : note maximale
- Question : toutes les évaluations sont-elles toujours notées sur `20` ou certaines évaluations peuvent-elles avoir une autre base puis être ramenées sur 20 ?

### DM-NOT-05

- Sujet : arrondis
- Question : quelles règles d'arrondi faut-il appliquer ?
- Points à valider :
  - nombre de décimales de saisie ;
  - nombre de décimales de calcul ;
  - nombre de décimales d'affichage ;
  - méthode d'arrondi.

## 5.4 Règles de calcul des moyennes

### DM-CAL-01

- Sujet : formule de moyenne matière
- Question : quelle est la formule officielle de calcul de la moyenne d'une matière ?
- Choix à valider :
  - formule Excel actuelle ;
  - moyenne pondérée par poids d'évaluations explicites ;
  - autre formule officielle.

### DM-CAL-02

- Sujet : rôle du coefficient de matière
- Question : le coefficient de matière :
  - sert-il uniquement à la moyenne semestrielle ;
  - sert-il aussi à pondérer l'examen dans la moyenne de matière ;
  - sert-il aux deux.

### DM-CAL-03

- Sujet : absence de devoir
- Question : en absence de note de devoir, faut-il :
  - reprendre la note d'examen ;
  - mettre zéro ;
  - rendre la moyenne non calculable ;
  - appliquer une autre règle.

### DM-CAL-04

- Sujet : moyenne par typologie
- Question : la moyenne par typologie doit-elle être :
  - une moyenne pondérée par coefficient ;
  - une simple moyenne des matières ;
  - un indicateur affiché sans effet sur la décision.

### DM-CAL-05

- Sujet : moyenne semestrielle
- Question : confirmer que la moyenne semestrielle est bien :
  - `somme(moyennes_coefficiees) / somme(coefficients)`

### DM-CAL-06

- Sujet : seuil de validation
- Question : confirmer officiellement que le seuil de validation est `10/20`.

### DM-CAL-07

- Sujet : crédits acquis
- Question : un crédit est-il acquis :
  - uniquement si la matière atteint `10/20` ;
  - ou via compensation semestrielle ;
  - ou via une autre règle.

### DM-CAL-08

- Sujet : matières à 0 crédit
- Question : les matières à `0 crédit` comptent-elles :
  - dans la moyenne ;
  - dans la décision ;
  - uniquement à titre informatif ;
  - dans aucun calcul.

### DM-CAL-09

- Sujet : compensation
- Question : existe-t-il une compensation :
  - entre matières ;
  - au sein d'une typologie ;
  - au niveau du semestre ;
  - aucune compensation.

### DM-CAL-10

- Sujet : mention
- Question : faut-il calculer une mention ?
- Si oui :
  - sur la moyenne de semestre ;
  - sur la moyenne annuelle ;
  - avec quels seuils.

### DM-CAL-11

- Sujet : classement
- Question : faut-il produire un classement des étudiants ?

## 5.5 Rattrapage

### DM-RAT-01

- Sujet : existence du rattrapage
- Question : le rattrapage existe-t-il pour toutes les matières ou seulement certaines ?

### DM-RAT-02

- Sujet : règle de remplacement
- Question : après rattrapage, faut-il :
  - remplacer la note d'examen ;
  - remplacer la moyenne finale ;
  - conserver la meilleure note ;
  - conserver les deux à l'historique mais n'en publier qu'une.

### DM-RAT-03

- Sujet : crédits après rattrapage
- Question : les crédits acquis au rattrapage sont-ils identiques à ceux d'une session normale ?

## 5.6 Validation, clôture et publication

### DM-VAL-01

- Sujet : acteur valideur
- Question : qui valide officiellement une note ?
- Choix possibles :
  - enseignant seul ;
  - direction des études ;
  - validation à deux niveaux.

### DM-VAL-02

- Sujet : visibilité des notes
- Question : à partir de quel moment l'étudiant peut-il consulter :
  - une note de matière ;
  - la moyenne de semestre ;
  - le bulletin PDF.

### DM-VAL-03

- Sujet : réouverture
- Question : qui peut rouvrir une note ou un semestre déjà validé ?

### DM-VAL-04

- Sujet : édition du bulletin
- Question : le bulletin doit-il être :
  - généré à la demande ;
  - généré à la validation ;
  - généré en lot par promotion.

### DM-VAL-05

- Sujet : versionnement
- Question : faut-il conserver plusieurs versions d'un bulletin lorsqu'une correction intervient après publication ?

## 5.7 Paiement et accès étudiant

### DM-ACC-01

- Sujet : condition de téléchargement
- Question : un étudiant peut-il télécharger son bulletin :
  - toujours ;
  - uniquement si le bulletin est publié ;
  - uniquement si publié et payé ;
  - gratuitement pour certains cas.

### DM-ACC-02

- Sujet : gratuité
- Question : la gratuité à `0 FCFA` s'applique-t-elle :
  - à certains bulletins ;
  - à certaines catégories d'étudiants ;
  - à certaines périodes ;
  - à tous les bulletins.

### DM-ACC-03

- Sujet : consultation des notes
- Question : la consultation simple des notes est-elle toujours gratuite, même si le PDF du bulletin est payant ?

## 5.8 Sécurité et habilitations

### DM-SEC-01

- Sujet : saisie par matière
- Question : un enseignant peut-il saisir uniquement ses matières ou aussi celles de sa typologie ou de son niveau ?

### DM-SEC-02

- Sujet : séparation des rôles
- Question : faut-il séparer strictement :
  - saisie ;
  - validation ;
  - publication ;
  - édition PDF ;
  - administration du référentiel.

### DM-SEC-03

- Sujet : consultation interne
- Question : quels profils peuvent consulter les notes de tous les étudiants ?

## 5.9 Documents et rendu du bulletin

### DM-DOC-01

- Sujet : modèle officiel
- Question : le modèle Excel fourni est-il le modèle officiel cible ou seulement un exemple de travail ?

### DM-DOC-02

- Sujet : champs obligatoires du bulletin
- Question : quels champs sont obligatoires sur le PDF final ?
- Proposition :
  - identité ;
  - matricule ;
  - année académique ;
  - niveau ;
  - semestre ;
  - disciplines ;
  - coefficients ;
  - notes ;
  - moyennes ;
  - crédits ;
  - décision ;
  - mention ;
  - signatures ou visas.

### DM-DOC-03

- Sujet : signatures
- Question : le bulletin doit-il comporter :
  - signature manuscrite scannée ;
  - signature électronique ;
  - simple nom/fonction ;
  - cachet.

## 6. Normalisations proposées pour le référentiel pédagogique

Les points ci-dessous sont proposés pour éviter la dérive du référentiel dans le temps.

### 6.1 Unicité des dictionnaires

Le métier doit valider un dictionnaire unique pour :

- années académiques ;
- niveaux ;
- semestres ;
- typologies ;
- matières ;
- types d'évaluation ;
- statuts de notes ;
- codes d'absence ;
- décisions ;
- mentions.

### 6.2 Codification normalisée

Il est recommandé de retenir :

- un code stable de typologie : `MPF`, `MPOC`, `MCO`, `LOS`, `MOP` ;
- un code stable de semestre : `S1` à `S6` ;
- un code stable de niveau : `L1`, `L2`, `L3` ;
- un code matière stable et unique par occurrence de matière dans un semestre.

Recommandation de codification matière :

- format `Lx-Sy-TYP-nn`
- exemple : `L1-S1-MPF-01`

Cette codification évite les collisions de type `MPF1` réutilisé dans plusieurs semestres.

### 6.3 Versionnement du référentiel

Toute modification de :

- libellé ;
- coefficient ;
- crédit ;
- typologie ;
- règle de calcul ;
- rattachement au semestre

doit être traitée comme une nouvelle version du référentiel si des résultats existent déjà.

### 6.4 Libellé canonique

Chaque matière doit avoir :

- un libellé canonique officiel ;
- éventuellement un alias historique importé depuis les anciennes feuilles ;
- un seul libellé d'affichage officiel sur les bulletins.

## 7. Règles de calcul à formaliser avant codage

Le métier doit valider une fiche officielle des règles de calcul avec les rubriques suivantes :

### 7.1 Paramètres généraux

- note maximale : `20`
- moyenne de validation : `10`
- nombre de décimales de calcul
- nombre de décimales d'affichage
- méthode d'arrondi

### 7.2 Règles par matière

- liste des évaluations prises en compte ;
- poids de chaque évaluation ;
- traitement des notes manquantes ;
- traitement des absences ;
- traitement du rattrapage ;
- règle d'acquisition des crédits.

### 7.3 Règles par typologie

- simple affichage ;
- calcul d'une moyenne ;
- effet ou non sur la décision.

### 7.4 Règles par semestre

- moyenne semestrielle ;
- seuil de validation ;
- compensation éventuelle ;
- crédits capitalisés ;
- mention ;
- décision finale.

## 8. Tableau de décisions à faire compléter par le métier

| ID | Sujet | Décision attendue | Réponse métier | Statut |
|---|---|---|---|---|
| DM-REF-01 | Référentiel officiel | Quel document fait foi ? |  | À valider |
| DM-REF-02 | Total du cycle | Confirmer `180 crédits` |  | À valider |
| DM-REF-03 | Crédits par semestre | Confirmer `S1` à `S6` |  | À valider |
| DM-REF-04 | Codes de typologie | Nomenclature officielle |  | À valider |
| DM-REF-06 | Codification matière | Format de code officiel |  | À valider |
| DM-NOT-01 | Types d'évaluation | Liste officielle |  | À valider |
| DM-NOT-05 | Arrondis | Règles officielles |  | À valider |
| DM-CAL-01 | Formule matière | Formule officielle |  | À valider |
| DM-CAL-02 | Rôle du coefficient | Pondération officielle |  | À valider |
| DM-CAL-07 | Crédits acquis | Règle d'acquisition |  | À valider |
| DM-CAL-08 | Matières à 0 crédit | Impact dans calcul |  | À valider |
| DM-CAL-09 | Compensation | Oui / Non / Niveau |  | À valider |
| DM-RAT-02 | Rattrapage | Règle de remplacement |  | À valider |
| DM-VAL-01 | Validation | Qui valide ? |  | À valider |
| DM-VAL-02 | Publication | Quand l'étudiant voit ? |  | À valider |
| DM-ACC-01 | Téléchargement | Condition d'accès |  | À valider |
| DM-DOC-01 | Modèle officiel | Le modèle Excel fait-il foi ? |  | À valider |

## 9. Atelier métier recommandé

Il est recommandé d'organiser un atelier de cadrage en 3 séquences :

### Séquence 1 : référentiel pédagogique

- validation des semestres ;
- validation des typologies ;
- validation des matières ;
- validation des coefficients et crédits.

### Séquence 2 : règles académiques

- validation des notes et évaluations ;
- validation des formules de calcul ;
- validation des crédits ;
- validation du rattrapage et de la compensation.

### Séquence 3 : publication et exploitation

- validation des rôles ;
- validation des droits ;
- validation du bulletin ;
- validation du paiement et de la consultation étudiante.

## 10. Livrables métier à obtenir après cadrage

Le développement ne doit reprendre qu'après obtention des livrables suivants :

- un référentiel pédagogique consolidé et signé ;
- une fiche officielle des règles de calcul ;
- une matrice des rôles et habilitations ;
- un modèle officiel du bulletin ;
- une note d'arbitrage sur les incohérences historiques.

## 11. Recommandation finale

Le bon objectif du cadrage n'est pas seulement de répondre aux questions, mais de produire une source de vérité unique.

Le module `Scolaris` doit implémenter :

- un référentiel officiel normalisé ;
- des règles de calcul explicitement approuvées ;
- une traçabilité des validations ;
- un bulletin conforme au modèle validé ;
- et non la simple reproduction mécanique des feuilles Excel existantes.
