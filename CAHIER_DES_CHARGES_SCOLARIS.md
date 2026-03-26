# Cahier des charges du module Dolibarr `Scolaris`

## 1. Objet du projet

Mettre en place, au sein de Dolibarr, un module custom nommé `Scolaris` pour la gestion académique d'un séminaire de philosophie. Le module doit couvrir la structuration du référentiel pédagogique, la saisie et la validation des notes, le calcul des résultats académiques, l'édition des relevés/bulletins PDF et la consultation en ligne par les étudiants séminaristes.

Le module doit être compatible avec les mécanismes standards de Dolibarr et ne jamais modifier le core, sauf en cas d'impossibilité de faire autrement.

## 2. Contexte métier

Le séminaire gère aujourd'hui les notes à l'aide de feuilles Excel et produit les relevés à partir d'un modèle tabulaire. Les documents fournis confirment les caractéristiques suivantes :

- les notes sont sur 20 ;
- la moyenne de validation est de 10/20 ;
- le cursus licence couvre 6 semestres pour un objectif global de 180 crédits ;
- les enseignements sont structurés par année académique, niveau, semestre, typologie de cours et matière ;
- le relevé présente au minimum : matière, coefficient, note de devoir, note d'examen, moyenne de matière, moyenne coefficiée et crédits validés ;
- certaines matières d'orientation propre sont à 0 FCFA pour la consultation/téléchargement si l'établissement le décide.

Les feuilles actuelles montrent aussi une logique de calcul implicite à formaliser dans le module :

- moyenne de matière calculée à partir de `devoir` et `examen` ;
- moyenne coefficiée calculée comme `moyenne_matiere * coefficient_matiere` ;
- moyenne semestrielle calculée comme somme des moyennes coefficiées divisée par la somme des coefficients ;
- crédits validés affichés par matière et totalisés au semestre.

## 3. Périmètre fonctionnel

### 3.1 Inclus

- gestion des années académiques ;
- gestion des niveaux `Licence 1`, `Licence 2`, `Licence 3` ;
- gestion des semestres `S1` à `S6` ;
- gestion des typologies de cours ;
- gestion des matières avec code, libellé, coefficient, crédits, semestre et typologie ;
- affectation des enseignants/formateurs par matière ;
- inscription académique des étudiants par année et niveau ;
- saisie des notes par type d'évaluation ;
- gestion des absences, notes manquantes, rattrapages et validations ;
- historisation complète des saisies et validations ;
- calcul des résultats par matière, typologie et semestre ;
- génération PDF des relevés/bulletins ;
- génération par lot pour une classe ou un semestre ;
- publication des notes et bulletins aux étudiants ;
- contrôle d'accès par rôle, matière et semestre ;
- prise en compte d'un paiement éventuel avant téléchargement.

### 3.2 Hors périmètre initial

- gestion complète des emplois du temps ;
- gestion de bibliothèque ;
- gestion pédagogique détaillée des présences en cours ;
- LMS complet de diffusion de contenus pédagogiques ;
- mobile app native.

## 4. Acteurs

- `Administrateur Dolibarr` : active le module, paramètre les référentiels, gère les droits et les constantes.
- `Direction des études` : administre les années académiques, valide les notes, clôture les semestres, édite les bulletins.
- `Secrétariat académique` : inscrit les étudiants, prépare les listes, relance les saisies, lance les éditions par lot.
- `Enseignant/Formateur` : saisit ou importe les notes des matières qui lui sont affectées.
- `Comptable/Caissier` : gère les factures ou paiements éventuels liés à la délivrance des bulletins.
- `Étudiant séminariste` : consulte ses notes et télécharge ses bulletins si autorisé.

## 5. Exigences fonctionnelles détaillées

### 5.1 Référentiel pédagogique

Le module doit permettre de paramétrer :

- une année académique avec date de début, date de fin, statut et année courante ;
- des niveaux d'études ;
- des semestres rattachés à un niveau ;
- des typologies de cours ;
- des matières avec :
  - code matière ;
  - libellé ;
  - typologie ;
  - semestre ;
  - coefficient ;
  - nombre de crédits ;
  - enseignant principal ;
  - ordre d'affichage ;
  - caractère obligatoire, optionnel ou propre à l'orientation ;
  - statut actif/inactif.

Le référentiel doit être historisable. Une matière d'une année donnée ne doit pas être modifiée rétroactivement si des notes existent déjà ; une nouvelle version du référentiel doit être créée.

### 5.2 Gestion des étudiants

Le module doit permettre :

- la création d'un dossier étudiant avec matricule, identité, date et lieu de naissance ;
- l'affectation à un niveau et à une année académique ;
- le suivi du statut académique : inscrit, redoublant, suspendu, abandonné, diplômé ;
- la liaison éventuelle à un compte utilisateur Dolibarr/extranet ;
- la consultation d'historique de résultats par semestre.

### 5.3 Saisie des notes

Le module doit permettre :

- de définir des types d'évaluation : devoir, examen, rattrapage, oral, autre ;
- de créer une ou plusieurs sessions d'évaluation pour une matière ;
- de saisir les notes individuellement ou par grille ;
- d'importer les notes depuis Excel/CSV ;
- d'enregistrer les absences avec distinction `justifiée` / `non justifiée` ;
- de gérer le cas `note non encore saisie` ;
- de verrouiller une session après validation ;
- de conserver l'auteur, la date de création, le dernier modificateur et le validateur.

### 5.4 Validation et clôture

Le module doit permettre :

- une validation en deux temps : saisie enseignant puis validation direction des études ;
- le rejet d'une session avec motif ;
- la clôture d'une matière ;
- la clôture d'un semestre ;
- la régénération des résultats si une note validée est corrigée par exception ;
- la conservation d'un journal des recalculs et éditions.

### 5.5 Calculs académiques

Le moteur de calcul doit produire :

- la moyenne par matière ;
- la moyenne coefficientée par matière ;
- la moyenne par typologie ;
- la moyenne semestrielle pondérée ;
- le total des crédits validés ;
- la décision académique semestrielle ;
- les mentions éventuelles ;
- le cumul de crédits au parcours.

Les règles doivent être paramétrables. Le comportement observé dans les feuilles actuelles devra être repris comme règle initiale de référence puis validé métier :

- si la note de devoir est absente, la moyenne de matière prend la note d'examen ;
- sinon la moyenne de matière est calculée selon la formule observée dans le classeur ;
- la moyenne semestrielle est une moyenne pondérée par les coefficients des matières ;
- les crédits sont capitalisés au moins à partir d'un seuil de 10/20.

Les points suivants doivent être confirmés par la direction des études avant développement final :

- crédit validé si moyenne de matière >= 10 ou selon compensation semestrielle ;
- règles de rattrapage ;
- gestion des mentions ;
- existence ou non d'un classement ;
- impact des matières à 0 crédit sur la moyenne ;
- impact des matières optionnelles gratuites sur la publication du bulletin.

### 5.6 Bulletins et relevés PDF

Le module doit générer des relevés conformes au modèle fourni, avec :

- identité de l'étudiant ;
- année académique ;
- niveau ;
- semestre ;
- tableau des matières regroupées par typologie ;
- colonnes `coef`, `devoir`, `examen`, `moyenne`, `moyenne coefficientée`, `crédits validés` ;
- totaux par typologie ;
- total général ;
- moyenne semestrielle ;
- total crédits validés ;
- décision ou mention si prévue ;
- numéro/version d'édition et date.

Le module doit aussi produire :

- édition individuelle ;
- édition par lot ;
- archivage documentaire ;
- réédition avec versionnement.

### 5.7 Portail étudiant et paiement

Le module doit permettre à l'étudiant :

- de se connecter ;
- de consulter ses notes publiées ;
- de télécharger ses bulletins autorisés ;
- d'accéder gratuitement ou après paiement selon la configuration de l'établissement.

Le paiement doit réutiliser autant que possible les modules standards Dolibarr :

- produit/service `Bulletin semestriel` ;
- facture ;
- paiement ;
- état `gratuit` via prix à `0`.

## 6. Exigences non fonctionnelles

### 6.1 Traçabilité

- journaliser toute création, modification, validation, annulation et édition ;
- stocker `créé_par`, `modifié_par`, `validé_par`, dates et motifs ;
- historiser les anciennes valeurs de notes et décisions.

### 6.2 Sécurité

- accès restreint par rôle ;
- restriction complémentaire par matière et semestre ;
- confidentialité stricte des notes ;
- séparation entre saisie, validation et consultation ;
- publication des résultats seulement après validation.

### 6.3 Compatibilité Dolibarr

- aucune modification du core ;
- usage des classes `CommonObject`, des hooks, des permissions standard, des dictionnaires, des modèles PDF et des cronjobs ;
- compatibilité ascendante avec les upgrades Dolibarr visés par le module.

### 6.4 Performance

- saisie fluide sur des classes complètes ;
- recalcul rapide des résultats ;
- génération PDF par lot ;
- limitation des requêtes redondantes ;
- indexation adaptée sur année, semestre, étudiant, matière et statut.

### 6.5 Qualité

- tests unitaires sur les règles de calcul ;
- jeux d'essai réalistes ;
- contrôle de non-régression sur les exports et PDF ;
- documentation d'administration et d'exploitation.

## 7. Pertinence du choix de Dolibarr

### 7.1 Pourquoi Dolibarr est pertinent

- Dolibarr fournit déjà la base applicative : utilisateurs, droits, menus, documents, modules, événements, extranet, facturation, paiements et journalisation minimale.
- Le moteur documentaire de Dolibarr est utile pour stocker et versionner les bulletins PDF.
- Le modèle de module custom permet de rester compatible upgrade.
- La gestion native des produits, factures et paiements répond bien au besoin de consultation/téléchargement payant ou gratuit.
- Les mécanismes de permissions et de groupes sont suffisants pour le socle sécurité.
- Le coût et le délai d'amorçage sont plus faibles qu'un développement ex nihilo.

### 7.2 Limites à anticiper

- Dolibarr n'est pas un SIS/LMS académique natif ; le domaine `gestion pédagogique` devra être modélisé presque entièrement en tables custom.
- La granularité standard des droits Dolibarr n'est pas assez fine pour porter seule une sécurité par matière et semestre ; un sous-système ACL spécifique sera requis.
- La notion de calcul académique complexe n'existe pas en standard.
- Le portail étudiant exigera une conception propre du cycle de publication.

### 7.3 Conclusion

Le choix de Dolibarr est pertinent si l'objectif est de bâtir un module académique intégré à un socle ERP existant, avec besoin de gestion documentaire, droits, extranet et paiements. Ce choix est moins pertinent si l'établissement attend à court terme un système universitaire complet incluant pédagogie avancée, planning, LMS et scolarité multi-campus. Pour le besoin exprimé, Dolibarr constitue une base pragmatique et économiquement rationnelle.

## 8. Modèle conceptuel de données

### 8.1 Entités principales

#### `AcademicYear`

- `id`
- `code`
- `label`
- `date_start`
- `date_end`
- `is_current`
- `status`

#### `AcademicLevel`

- `id`
- `code` : `L1`, `L2`, `L3`
- `label`
- `cycle_order`

#### `Semester`

- `id`
- `code` : `S1` ... `S6`
- `label`
- `level_id`
- `semester_number`
- `target_credits`
- `display_order`

#### `TeachingTypology`

- `id`
- `code` : `MPF`, `MPOC`, `MCO`, `LOS`, `MOP`, `MPC`, `TFC`
- `label`
- `display_order`
- `counts_for_average`
- `counts_for_credit`

#### `Course`

- `id`
- `semester_id`
- `typology_id`
- `code`
- `label`
- `coefficient`
- `credits`
- `is_optional`
- `is_orientation_specific`
- `active`

#### `CourseAssignment`

- `id`
- `course_id`
- `user_id`
- `role`
- `academic_year_id`

#### `Student`

- `id`
- `student_number`
- `firstname`
- `lastname`
- `birthdate`
- `birthplace`
- `dolibarr_user_id` optionnel
- `dolibarr_member_id` optionnel
- `status`

#### `Enrollment`

- `id`
- `student_id`
- `academic_year_id`
- `level_id`
- `group_code`
- `status`
- `is_repeating`

#### `Assessment`

- `id`
- `course_id`
- `academic_year_id`
- `assessment_type`
- `session_type` : normale, rattrapage
- `label`
- `date_assessment`
- `max_score`
- `weight`
- `status`

#### `Grade`

- `id`
- `assessment_id`
- `student_id`
- `score`
- `absence_status`
- `is_excused`
- `comment`
- `entered_by`
- `entered_at`
- `validated_by`
- `validated_at`
- `status`

#### `CourseResult`

- `id`
- `student_id`
- `enrollment_id`
- `course_id`
- `session_type`
- `average_score`
- `weighted_score`
- `credits_attempted`
- `credits_earned`
- `decision`
- `calculation_snapshot_json`
- `published_at`

#### `TypologyResult`

- `id`
- `student_id`
- `enrollment_id`
- `semester_id`
- `typology_id`
- `average_score`
- `weighted_score_total`
- `credits_earned`

#### `SemesterResult`

- `id`
- `student_id`
- `enrollment_id`
- `semester_id`
- `total_coefficients`
- `weighted_total`
- `semester_average`
- `credits_target`
- `credits_earned`
- `decision`
- `mention`
- `rank`
- `published_at`
- `locked_at`

#### `Bulletin`

- `id`
- `semester_result_id`
- `document_ref`
- `document_path`
- `version_number`
- `generated_by`
- `generated_at`
- `publication_status`
- `invoice_id` optionnel
- `payment_status`

#### `AuditLog`

- `id`
- `object_type`
- `object_id`
- `action`
- `old_value_json`
- `new_value_json`
- `done_by`
- `done_at`
- `reason`

#### `UserCoursePermission`

- `id`
- `user_id`
- `academic_year_id`
- `semester_id`
- `course_id`
- `can_enter`
- `can_validate`
- `can_publish`

### 8.2 Relations clés

- une `AcademicYear` possède plusieurs `Enrollment`, `Assessment` et `CourseAssignment` ;
- un `AcademicLevel` possède plusieurs `Semester` ;
- un `Semester` possède plusieurs `Course` ;
- une `TeachingTypology` possède plusieurs `Course` ;
- un `Course` possède plusieurs `Assessment` et plusieurs `CourseAssignment` ;
- un `Student` possède plusieurs `Enrollment`, `Grade`, `CourseResult`, `SemesterResult` ;
- un `Assessment` possède plusieurs `Grade` ;
- un `SemesterResult` possède plusieurs `CourseResult` et peut produire plusieurs versions de `Bulletin`.

### 8.3 Principes de modélisation

- ne pas stocker seulement des colonnes figées `devoir` et `examen` dans la table matière ; stocker des évaluations paramétrables ;
- matérialiser les résultats calculés dans des tables de résultats pour audit, édition PDF et performance ;
- conserver un `snapshot` JSON de calcul pour expliquer a posteriori le résultat publié ;
- isoler les droits fins dans une table dédiée et ne pas dépendre uniquement des droits globaux de module.

## 9. User stories

### 9.1 Administration et paramétrage

- En tant qu'administrateur, je veux créer une année académique afin d'ouvrir la campagne de saisie.
- En tant qu'administrateur, je veux paramétrer les typologies, matières, coefficients et crédits afin de refléter le référentiel officiel.
- En tant qu'administrateur, je veux versionner le référentiel pédagogique afin de préserver l'historique des années antérieures.
- En tant qu'administrateur, je veux attribuer des droits par matière et semestre afin de limiter l'accès aux seules personnes autorisées.

### 9.2 Direction des études

- En tant que directeur des études, je veux inscrire les étudiants à un niveau et une année afin de préparer les campagnes de notes.
- En tant que directeur des études, je veux valider ou rejeter des notes saisies afin de contrôler la qualité académique.
- En tant que directeur des études, je veux clôturer un semestre afin d'empêcher toute modification non autorisée.
- En tant que directeur des études, je veux régénérer un bulletin après correction validée afin de publier une nouvelle version traçable.

### 9.3 Enseignants

- En tant qu'enseignant, je veux voir uniquement les matières qui me sont affectées afin d'éviter toute erreur de saisie.
- En tant qu'enseignant, je veux saisir les notes d'une classe sur une grille unique afin d'aller vite.
- En tant qu'enseignant, je veux importer un fichier Excel/CSV afin d'éviter les ressaisies.
- En tant qu'enseignant, je veux signaler une absence ou un rattrapage afin que le calcul prenne en compte la bonne session.

### 9.4 Secrétariat académique

- En tant que secrétaire, je veux lancer la génération des relevés pour une classe entière afin de gagner du temps.
- En tant que secrétaire, je veux consulter l'état d'avancement des saisies par matière afin de relancer les enseignants retardataires.
- En tant que secrétaire, je veux rechercher un étudiant par matricule afin d'éditer rapidement son bulletin.

### 9.5 Comptabilité

- En tant que comptable, je veux associer un produit de type bulletin à une facture afin de contrôler l'accès au téléchargement.
- En tant que comptable, je veux gérer les cas gratuits à 0 FCFA afin que certains bulletins restent librement accessibles.

### 9.6 Étudiants

- En tant qu'étudiant, je veux consulter mes notes publiées par semestre afin de suivre ma progression.
- En tant qu'étudiant, je veux télécharger mon bulletin PDF afin de l'imprimer ou le transmettre.
- En tant qu'étudiant, je veux être bloqué si le bulletin est payant et non réglé afin de respecter les règles administratives.

## 10. Modélisation détaillée sur le moteur Dolibarr

### 10.1 Objets Dolibarr à réutiliser

- `llx_user` pour les acteurs internes ;
- groupes et permissions Dolibarr pour les droits globaux ;
- extranet/utilisateurs liés pour les étudiants ayant accès au portail ;
- `llx_product` ou service pour les frais de bulletin ;
- `llx_facture` et paiements pour la monétisation des téléchargements ;
- gestion documentaire native pour l'archivage des PDF ;
- cronjobs pour les traitements batch ;
- modèles PDF et conventions de modules pour l'édition.

### 10.2 Objets custom à créer

Le coeur métier doit être porté par des objets custom `CommonObject`, chacun avec sa table :

- `ScolarisAcademicYear`
- `ScolarisSemester`
- `ScolarisTypology`
- `ScolarisCourse`
- `ScolarisStudent`
- `ScolarisEnrollment`
- `ScolarisAssessment`
- `ScolarisGrade`
- `ScolarisCourseResult`
- `ScolarisSemesterResult`
- `ScolarisBulletin`
- `ScolarisAudit`
- `ScolarisPermission`

### 10.3 Représentation des étudiants dans Dolibarr

Deux stratégies sont possibles :

#### Option A : étudiant comme objet custom principal, avec lien facultatif vers `user`

Avantages :

- modèle académique propre ;
- pas de détournement sémantique des tiers ou adhérents ;
- meilleure maîtrise des règles métier.

Inconvénients :

- nécessite plus de développement pour l'accès extranet.

#### Option B : étudiant adossé à `Adherent` ou `Thirdparty`

Avantages :

- réutilisation plus forte de l'existant Dolibarr ;
- lien plus simple avec la facturation et certains écrans standards.

Inconvénients :

- sémantique moins propre pour la scolarité ;
- risque de confusion entre relation commerciale et dossier académique.

#### Recommandation

Utiliser un objet custom `Student` comme source de vérité académique, avec :

- lien optionnel vers `llx_user` pour l'accès au portail ;
- lien optionnel vers `llx_societe` ou `llx_adherent` seulement si requis pour des besoins administratifs ou financiers.

### 10.4 Gestion des notes

La modélisation recommandée est la suivante :

1. Le référentiel pédagogique décrit les matières offertes par semestre.
2. Chaque matière reçoit une ou plusieurs évaluations.
3. Chaque évaluation reçoit une note par étudiant.
4. Un moteur de calcul consolide les notes en résultats de matière.
5. Les résultats de matière sont agrégés en résultats de typologie.
6. Les résultats de typologie alimentent le résultat semestriel.
7. Le résultat semestriel alimente le bulletin.

Cette modélisation évite de figer le système à un simple couple `devoir/examen`. Elle permet :

- d'ajouter un rattrapage ;
- de différencier plusieurs devoirs ;
- de faire évoluer les règles sans casser le modèle.

### 10.5 Règles de calcul paramétrables

Il faut séparer :

- le `coefficient académique de la matière`, utilisé pour la pondération semestrielle ;
- le `poids des évaluations`, utilisé dans le calcul de la moyenne de matière.

Les feuilles Excel actuelles semblent réutiliser le coefficient de matière dans la formule de calcul de la moyenne de matière. Cette logique doit être configurable, mais ne doit pas être codée en dur comme seule possibilité.

Règle recommandée :

- table ou configuration de profil de calcul par semestre ou année ;
- poids par type d'évaluation ;
- stratégie de remplacement au rattrapage ;
- stratégie de capitalisation des crédits ;
- stratégie de compensation.

### 10.6 Sécurité applicative

La sécurité doit combiner :

- droits module globaux Dolibarr ;
- table custom de permissions fines ;
- contrôles dans chaque écran et action ;
- filtrage des listes SQL par utilisateur ;
- masquage des documents non publiés ;
- contrôle de paiement avant téléchargement si applicable.

### 10.7 Édition PDF

Le moteur PDF doit :

- charger le résultat semestriel matérialisé ;
- regrouper les lignes par typologie ;
- afficher les colonnes du modèle ;
- afficher les totaux et crédits ;
- conserver un numéro de version ;
- enregistrer le PDF dans l'espace documentaire du module.

### 10.8 Batch et clôture

Pour la performance et l'exploitation :

- les recalculs massifs doivent être batchés ;
- la génération de 30 à 100 bulletins doit pouvoir passer par un cronjob ou une file simple ;
- la clôture d'un semestre doit figer les résultats publiés ;
- toute réouverture doit être exceptionnelle et auditée.

## 11. Points d'attention relevés dans les documents source

Les documents fournis montrent des incohérences à arbitrer avant paramétrage définitif :

- le total global annoncé par le besoin est de `180 crédits` sur 6 semestres ;
- la répartition Word extraite montre un `Semestre 4` à `34 crédits`, ce qui conduirait à `184 crédits` sur l'ensemble du cycle si tous les autres semestres restent à `30` ;
- certaines lignes de total intermédiaire du document source semblent incohérentes avec la somme détaillée des matières ;
- le classeur de notes et le modèle de relevé n'utilisent pas exactement les mêmes intitulés de matières dans tous les cas.

Une réunion de validation du référentiel pédagogique est donc indispensable avant gel du modèle de données.

## 12. Plan d'implémentation étape par étape

### Phase 1. Cadrage métier

- valider le référentiel officiel des 6 semestres ;
- arbitrer toutes les incohérences de coefficients et crédits ;
- valider les règles de calcul, rattrapage, compensation, mentions et publication ;
- définir les profils d'utilisateurs et la matrice d'habilitation.

### Phase 2. Conception fonctionnelle détaillée

- produire les maquettes des écrans de paramétrage, saisie et consultation ;
- valider la structure du bulletin PDF ;
- figer les statuts des objets métier ;
- décrire les workflows de validation et clôture.

### Phase 3. Conception technique

- définir les tables SQL custom ;
- définir les classes `CommonObject` ;
- définir les menus, permissions et constantes ;
- définir les hooks et points d'intégration avec la facturation et l'extranet ;
- définir les index et la stratégie d'audit.

### Phase 4. Socle module

- compléter `modScolaris.class.php` ;
- créer les tables SQL d'installation et migration ;
- créer les objets métier ;
- créer les droits de module ;
- créer les pages d'administration.

### Phase 5. Référentiel académique

- développer les écrans années, niveaux, semestres, typologies et matières ;
- développer l'affectation enseignants-matières ;
- développer l'inscription des étudiants.

### Phase 6. Saisie et validation des notes

- développer les objets `Assessment` et `Grade` ;
- développer la grille de saisie ;
- développer l'import Excel/CSV ;
- développer le workflow de validation ;
- implémenter l'audit trail.

### Phase 7. Moteur de calcul

- développer les calculateurs de résultats matière, typologie et semestre ;
- matérialiser les résultats dans des tables dédiées ;
- écrire les tests unitaires sur les règles de calcul ;
- tester les cas d'absence, de note manquante et de rattrapage.

### Phase 8. Bulletins PDF

- développer le modèle PDF conforme au relevé cible ;
- développer l'édition unitaire et batch ;
- stocker et versionner les documents générés ;
- intégrer la publication portail.

### Phase 9. Portail étudiant et paiement

- lier les étudiants aux comptes d'accès ;
- afficher notes et bulletins publiés ;
- contrôler l'accès par paiement ou gratuité ;
- tester le parcours complet étudiant.

### Phase 10. Recette et déploiement

- constituer des jeux d'essai sur les 6 semestres ;
- faire une recette métier sur cas réels ;
- corriger les écarts ;
- documenter l'administration et l'exploitation ;
- déployer en préproduction puis en production.

## 13. Recommandations de lotissement

Pour réduire le risque, le projet peut être livré en 3 lots :

### Lot 1

- référentiel pédagogique ;
- étudiants et inscriptions ;
- saisie simple des notes ;
- calculs de base ;
- relevé semestriel unitaire.

### Lot 2

- validation hiérarchique ;
- audit complet ;
- génération batch ;
- portail étudiant ;
- paiement et gratuité.

### Lot 3

- règles avancées de compensation ;
- statistiques ;
- classement ;
- exports avancés ;
- optimisation et industrialisation.

## 14. Critères d'acceptation

Le module sera considéré conforme si :

- le référentiel des 6 semestres est paramétrable sans toucher au code ;
- un enseignant ne peut saisir que les notes des matières qui lui sont attribuées ;
- les calculs produits par le module reproduisent les règles validées ;
- les bulletins PDF correspondent au modèle attendu ;
- les éditions par lot sont réalisables sur une promotion ;
- toute modification de note est tracée ;
- l'étudiant voit uniquement ses propres résultats ;
- le téléchargement payant ou gratuit fonctionne selon la configuration.

## 15. Recommandation finale

Le projet doit commencer par la normalisation du référentiel pédagogique et des règles de calcul. Sans cette étape, le risque principal n'est pas technique mais métier : reproduire dans le module des incohérences déjà présentes dans les feuilles manuelles.

La bonne approche consiste à faire de `Scolaris` un module Dolibarr spécialisé, centré sur des objets académiques custom, tout en réutilisant Dolibarr pour les utilisateurs, la sécurité globale, les documents, les paiements et l'extranet.
