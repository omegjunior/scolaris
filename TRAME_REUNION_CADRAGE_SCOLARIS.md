# Trame de réunion / compte-rendu de cadrage métier `Scolaris`

## 1. Informations générales

- Projet : `Scolaris` - gestion académique des notes et bulletins
- Objet de la réunion : cadrage métier et validation des règles de référence
- Date :
- Heure :
- Lieu / visioconférence :
- Animateur :
- Rédacteur du compte-rendu :

## 2. Participants

| Nom | Fonction | Présent | Rôle dans la décision |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## 3. Objectif de la séance

Valider les éléments métier indispensables avant développement :

- référentiel pédagogique officiel ;
- règles de calcul des notes et crédits ;
- gestion du rattrapage ;
- règles de validation et de publication ;
- accès étudiant et éventuel paiement ;
- rôles et habilitations.

## 4. Documents support examinés

- [DOSSIER_CADRAGE_METIER_SCOLARIS.md](c:/xampp/htdocs/dolibarr-22.0.0/htdocs/custom/scolaris/DOSSIER_CADRAGE_METIER_SCOLARIS.md)
- `2025-2026 REPARTITION DES MATIERES PAR TYPOLOGIES DE COURS ET SUIVANT LES SEMESTRES.docx`
- `GDPMIS_2022-2023_Notes_Semestre 1.xlsx`
- `RELEVE DE NOTES.xlsx`

## 5. Rappel des anomalies déjà détectées

- `S1` : incohérence entre le total affiché des crédits et la somme détaillée.
- `S4` : incohérence entre le total LOS et le total global affiché.
- Relevé Excel `S1` : total crédits validés à `31`, incohérent avec les autres sources.
- Divergence de matières et de libellés entre le référentiel Word et les feuilles Excel.
- Règles de calcul implicites dans Excel non formalisées officiellement.

## 6. Ordre du jour proposé

### 6.1 Référentiel pédagogique

- validation du document de référence qui fait foi ;
- validation des niveaux, semestres et typologies ;
- validation des matières, coefficients et crédits ;
- validation de la codification officielle.

### 6.2 Règles académiques

- validation de la formule de calcul par matière ;
- validation du rôle du coefficient ;
- validation de l'acquisition des crédits ;
- validation de la compensation ;
- validation du rattrapage ;
- validation des arrondis et mentions.

### 6.3 Processus de gestion

- validation du workflow de saisie ;
- validation du workflow de contrôle et de validation ;
- validation des règles de clôture ;
- validation des règles de publication.

### 6.4 Portail étudiant et paiement

- consultation des notes ;
- téléchargement des bulletins ;
- gratuité et paiement éventuel ;
- moment d'ouverture de l'accès étudiant.

### 6.5 Sécurité et habilitations

- périmètre de saisie des enseignants ;
- rôle de la direction des études ;
- rôle du secrétariat ;
- rôle de la comptabilité ;
- rôle de l'administrateur.

## 7. Questions à trancher pendant la réunion

### 7.1 Référentiel

- Quel document fait foi si plusieurs sources divergent ?
- Le total officiel du cycle est-il bien de `180 crédits` ?
- Quels sont les crédits officiels de `S1` et `S4` ?
- Quelle nomenclature officielle retenir pour `MOP` / `MOO` ?
- Quelle codification matière doit devenir la référence ?

### 7.2 Calcul

- Quelle formule officielle utiliser pour la moyenne matière ?
- Le coefficient de matière sert-il aussi à pondérer l'examen ?
- En absence de devoir, quelle règle appliquer ?
- Quand un crédit est-il acquis ?
- Les matières à `0 crédit` comptent-elles dans la moyenne ?
- Existe-t-il une compensation ? Si oui, à quel niveau ?
- Le rattrapage remplace-t-il l'examen, la moyenne, ou la meilleure note est-elle conservée ?

### 7.3 Validation et publication

- Qui valide officiellement la note ?
- À quel moment la note devient-elle visible pour l'étudiant ?
- À quel moment le bulletin devient-il téléchargeable ?
- Une réédition doit-elle créer une nouvelle version du bulletin ?

### 7.4 Accès et sécurité

- Quels profils peuvent saisir ?
- Quels profils peuvent valider ?
- Quels profils peuvent publier ?
- Quels profils peuvent voir toutes les notes ?
- Le téléchargement du bulletin est-il payant, gratuit, ou configurable ?

## 8. Tableau de décisions prises pendant la séance

| ID | Sujet | Décision retenue | Responsable validation | Commentaire |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

## 9. Arbitrages refusés ou reportés

| Sujet | Raison du report | Action complémentaire attendue | Responsable | Échéance |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |

## 10. Actions à engager après la réunion

| Action | Responsable | Échéance | Statut |
|---|---|---|---|
| Consolider le référentiel officiel |  |  |  |
| Formaliser les règles de calcul |  |  |  |
| Valider le modèle officiel du bulletin |  |  |  |
| Valider la matrice des rôles |  |  |  |

## 11. Synthèse finale à compléter

- Référentiel pédagogique validé : Oui / Non
- Règles de calcul validées : Oui / Non
- Workflow de validation validé : Oui / Non
- Règles de publication validées : Oui / Non
- Conditions d'accès étudiant validées : Oui / Non
- Développement autorisé à reprendre : Oui / Non

## 12. Compte-rendu final

### Décisions confirmées

- 

### Points restant à arbitrer

- 

### Risques si non-tranchés

- incohérences de crédits ;
- incohérences de calcul ;
- bulletins divergents ;
- impossibilité de figer le paramétrage.

### Recommandation

Le développement ne doit reprendre que sur la base d'un référentiel et de règles explicitement approuvés par le métier.
