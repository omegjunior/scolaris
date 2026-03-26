# Backlog technique v1 du module `Scolaris`

## 1. Objectif du backlog v1

Ce backlog v1 couvre le socle nécessaire pour obtenir une première version exploitable du module :

- paramétrage du référentiel académique ;
- gestion des étudiants et inscriptions ;
- saisie et validation des notes ;
- calcul des résultats semestriels ;
- génération du bulletin PDF individuel ;
- base d'audit et de sécurité ;
- préparation du portail étudiant et du paiement.

## 2. Principes de priorisation

- `P0` : indispensable à une v1 exploitable.
- `P1` : très utile, peut arriver juste après la mise en service initiale.
- `P2` : amélioration ou industrialisation.

## 3. Epic 0 - Architecture et conventions

### T0.1 - Finaliser les règles métier ambiguës

- Priorité : `P0`
- Livrable : note d'arbitrage métier
- Points à trancher :
  - formule exacte de moyenne matière ;
  - règle d'acquisition des crédits ;
  - compensation ou non ;
  - rattrapage ;
  - mentions ;
  - classement ;
  - cohérence des 180 crédits.

### T0.2 - Stabiliser le schéma SQL v1

- Priorité : `P0`
- Livrable : dossier `sql/` éclaté par table et fichier `.key.sql`
- Dépendance : `T0.1`

### T0.3 - Définir les conventions de code

- Priorité : `P0`
- Livrable : conventions de nommage des classes, pages, droits, menus et modèles PDF
- Règles :
  - une table `llx_scolaris_*` par objet métier ;
  - une classe `class/*.class.php` par table principale ;
  - aucun code métier dans les pages d'UI ;
  - services dédiés pour calcul, permissions et génération PDF.

## 4. Epic 1 - Socle module Dolibarr

### T1.1 - Compléter le descripteur du module

- Priorité : `P0`
- Fichiers cibles :
  - [`core/modules/modScolaris.class.php`](c:/xampp/htdocs/dolibarr-22.0.0/htdocs/custom/scolaris/core/modules/modScolaris.class.php)
- Travail :
  - ajouter permissions ;
  - ajouter menus ;
  - ajouter répertoires documents ;
  - déclarer éventuellement hooks et modèles.

### T1.2 - Préparer les scripts SQL d'installation et upgrade

- Priorité : `P0`
- Fichiers cibles :
  - fichiers `sql/llx_scolaris_*.sql`
  - fichiers `sql/llx_scolaris_*.key.sql`
  - [`sql/dolibarr_allversions.sql`](c:/xampp/htdocs/dolibarr-22.0.0/htdocs/custom/scolaris/sql/dolibarr_allversions.sql)
- Travail :
  - installer les tables ;
  - prévoir les migrations futures.

### T1.3 - Créer les constantes d'administration

- Priorité : `P0`
- Exemples :
  - `SCOLARIS_DEFAULT_RULE_PROFILE`
  - `SCOLARIS_PASS_MARK`
  - `SCOLARIS_ENABLE_STUDENT_PORTAL`
  - `SCOLARIS_BULLETIN_PRODUCT_ID`
  - `SCOLARIS_DEFAULT_CURRENCY`

## 5. Epic 2 - Référentiel académique

### T2.1 - Implémenter les objets métier de base

- Priorité : `P0`
- Classes à créer :
  - `AcademicYear`
  - `Level`
  - `Semester`
  - `Typology`
  - `RuleProfile`
  - `Course`

### T2.2 - Développer les écrans d'administration du référentiel

- Priorité : `P0`
- Écrans :
  - années académiques ;
  - niveaux ;
  - semestres ;
  - typologies ;
  - profils de calcul ;
  - matières.

### T2.3 - Gérer les affectations enseignants-matières

- Priorité : `P0`
- Objets :
  - `CourseAssignment`
- Écrans :
  - affectation simple ;
  - vue par enseignant ;
  - vue par matière.

### T2.4 - Seed initial du référentiel philosophie

- Priorité : `P0`
- Livrable :
  - données initiales 2025-2026 après arbitrage métier
- Point de vigilance :
  - ne rien charger avant validation des incohérences de crédits.

## 6. Epic 3 - Étudiants et inscriptions

### T3.1 - Implémenter l'objet étudiant

- Priorité : `P0`
- Classe à créer :
  - `Student`
- Fonctionnalités :
  - matricule ;
  - identité ;
  - lien optionnel vers compte utilisateur Dolibarr.

### T3.2 - Implémenter l'inscription académique

- Priorité : `P0`
- Classe à créer :
  - `Enrollment`
- Fonctionnalités :
  - inscription par année ;
  - niveau ;
  - statut ;
  - redoublement.

### T3.3 - Lier un étudiant à un accès portail

- Priorité : `P1`
- Dépendance :
  - `T3.1`
- Travail :
  - liaison à `llx_user` ;
  - gestion des comptes externes.

### T3.4 - Préparer l'import initial des étudiants

- Priorité : `P1`
- Formats :
  - CSV ;
  - Excel converti en CSV.

## 7. Epic 4 - Notes et évaluations

### T4.1 - Implémenter les objets d'évaluation et de note

- Priorité : `P0`
- Classes à créer :
  - `Assessment`
  - `Grade`
  - `GradeHistory`

### T4.2 - Créer la grille de saisie des notes

- Priorité : `P0`
- Fonctionnalités :
  - liste des étudiants inscrits ;
  - saisie par matière ;
  - types `devoir`, `examen`, `rattrapage` ;
  - absences et commentaires.

### T4.3 - Implémenter le workflow de validation

- Priorité : `P0`
- États attendus :
  - brouillon ;
  - saisi ;
  - validé ;
  - verrouillé ;
  - publié.

### T4.4 - Import Excel/CSV des notes

- Priorité : `P1`
- Dépendance :
  - `T4.1`
  - `T4.2`

### T4.5 - Historisation complète des modifications

- Priorité : `P0`
- Mécanisme :
  - journal applicatif ;
  - table `GradeHistory` ;
  - table `Audit`.

## 8. Epic 5 - Moteur de calcul académique

### T5.1 - Implémenter le service de calcul des résultats de matière

- Priorité : `P0`
- Sorties :
  - moyenne matière ;
  - moyenne coefficientée ;
  - crédits acquis.

### T5.2 - Implémenter l'agrégation par typologie

- Priorité : `P0`
- Sorties :
  - moyenne de typologie ;
  - crédits validés par typologie.

### T5.3 - Implémenter le calcul semestriel

- Priorité : `P0`
- Sorties :
  - moyenne semestrielle ;
  - total coefficients ;
  - total crédits validés ;
  - décision ;
  - mention optionnelle.

### T5.4 - Matérialiser les résultats

- Priorité : `P0`
- Tables cibles :
  - `CourseResult`
  - `TypologyResult`
  - `SemesterResult`

### T5.5 - Gérer les recalculs et verrouillages

- Priorité : `P0`
- Cas à traiter :
  - correction exceptionnelle ;
  - republication ;
  - audit du recalcul.

### T5.6 - Ajouter les règles avancées

- Priorité : `P1`
- Contenu :
  - compensation ;
  - rattrapage configurable ;
  - classement ;
  - mentions.

## 9. Epic 6 - PDF bulletin

### T6.1 - Concevoir le modèle PDF v1

- Priorité : `P0`
- Basé sur :
  - modèle Excel fourni
- Colonnes minimales :
  - matière ;
  - coef ;
  - devoir ;
  - examen ;
  - moyenne ;
  - moyenne coefficientée ;
  - crédits validés.

### T6.2 - Implémenter la génération individuelle

- Priorité : `P0`
- Dépendance :
  - `T5.3`
- Sortie :
  - un bulletin PDF archivé dans l'espace documentaire du module.

### T6.3 - Versionner les bulletins

- Priorité : `P0`
- Besoin :
  - nouvelle version en cas de recalcul après correction.

### T6.4 - Génération batch

- Priorité : `P1`
- Dépendance :
  - `T6.2`
- Cible :
  - promotion complète ;
  - semestre complet.

## 10. Epic 7 - Sécurité et permissions fines

### T7.1 - Définir les droits globaux du module

- Priorité : `P0`
- Droits minimaux :
  - lire ;
  - administrer ;
  - saisir des notes ;
  - valider ;
  - publier ;
  - générer des PDF.

### T7.2 - Implémenter les permissions fines par périmètre

- Priorité : `P0`
- Table cible :
  - `UserScope`
- Règles :
  - par matière ;
  - par semestre ;
  - par année académique.

### T7.3 - Sécuriser l'accès étudiant

- Priorité : `P1`
- Travail :
  - filtrage strict sur ses propres résultats ;
  - blocage des bulletins non publiés ;
  - contrôle de paiement si nécessaire.

## 11. Epic 8 - Portail et paiement

### T8.1 - Exposer les notes publiées dans le portail

- Priorité : `P1`
- Dépendance :
  - `T3.3`
  - `T7.3`

### T8.2 - Exposer les bulletins téléchargeables

- Priorité : `P1`
- Dépendance :
  - `T6.2`

### T8.3 - Brancher la logique de paiement

- Priorité : `P1`
- Réutilisation Dolibarr :
  - produit/service ;
  - facture ;
  - règlement.

### T8.4 - Gérer les cas gratuits à 0 FCFA

- Priorité : `P1`
- Cas :
  - accès libre ;
  - accès facturé ;
  - accès débloqué après paiement.

## 12. Epic 9 - Tests et qualité

### T9.1 - Créer un jeu d'essai académique

- Priorité : `P0`
- Contenu :
  - 6 semestres ;
  - plusieurs typologies ;
  - étudiants avec cas passants, ajournés, absents, rattrapage.

### T9.2 - Écrire les tests unitaires du moteur de calcul

- Priorité : `P0`
- Cas :
  - calcul devoir/examen ;
  - absence de devoir ;
  - rattrapage ;
  - crédits ;
  - moyenne semestrielle.

### T9.3 - Tester la non-régression PDF

- Priorité : `P1`
- Cible :
  - structure du relevé ;
  - cohérence des totaux.

### T9.4 - Préparer la recette métier

- Priorité : `P1`
- Livrable :
  - cahier de recette ;
  - scénarios utilisateurs ;
  - résultats attendus.

## 13. Ordre recommandé d'exécution

### Sprint 1

- `T0.1`
- `T0.2`
- `T1.1`
- `T1.2`
- `T1.3`

### Sprint 2

- `T2.1`
- `T2.2`
- `T2.3`
- `T3.1`
- `T3.2`

### Sprint 3

- `T4.1`
- `T4.2`
- `T4.3`
- `T4.5`

### Sprint 4

- `T5.1`
- `T5.2`
- `T5.3`
- `T5.4`
- `T9.1`
- `T9.2`

### Sprint 5

- `T6.1`
- `T6.2`
- `T6.3`
- `T7.1`
- `T7.2`

### Sprint 6

- `T4.4`
- `T6.4`
- `T8.1`
- `T8.2`
- `T8.3`
- `T8.4`
- `T9.3`
- `T9.4`

## 14. Définition de Done v1

La v1 peut être annoncée comme prête si :

- le référentiel pédagogique est paramétrable ;
- les étudiants sont inscrits par année et niveau ;
- les enseignants saisissent leurs notes sur une grille dédiée ;
- la direction valide et verrouille les notes ;
- les calculs semestriels sont reproductibles ;
- un bulletin PDF individuel fidèle au modèle est généré ;
- les traces de modification sont consultables ;
- les droits empêchent les accès hors périmètre.

## 15. Recommandation d'exécution

Le prochain chantier technique recommandé n'est pas encore l'UI complète, mais l'ossature du module :

- compléter `modScolaris.class.php` ;
- ajouter les classes métier de base ;
- brancher l'installation SQL ;
- écrire les premiers tests du moteur de calcul.
