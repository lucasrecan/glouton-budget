# 📱 Formulaire technique – Mini-projet Flutter

### Nom de l’application

**Glouton Budget**

### Membres du binôme

**shn4606a / rcl4463a**

---

# Présentation de l’application

## Objectif de l’application

Application mobile permettant aux étudiants de suivre leurs dépenses quotidiennes, notamment les repas CROUS, afin de mieux gérer leur budget de manière simple et rapide.

---

## Fonctionnalités principales

* Ajout rapide de repas (boursier ou non boursier)
* Ajout de dépenses personnalisées
* Affichage du total des dépenses
* Consultation de l’historique
* Suppression de dépenses (glissement)
* Gestion des préférences (thème, statut boursier)

---

# Architecture de l’application

## Liste des écrans

| Écran          | Description                                            |
| -------------- | ------------------------------------------------------ |
| HomeScreen     | Affiche le total des dépenses et permet l’ajout rapide |
| AjouterDepense | Formulaire pour ajouter une dépense                    |
| Historique     | Liste des dépenses avec suppression                    |
| Parametres     | Gestion du thème et du statut boursier                 |

---

## Navigation entre écrans

| Élément          | Description                        |
| ---------------- | ---------------------------------- |
| Écran de départ  | HomeScreen                         |
| Écran cible      | Parametres                         |
| Donnée transmise | Statut boursier                    |
| Donnée renvoyée  | Valeur modifiée du statut boursier |
| Fichier          | main.dart                          |

---

## Gestion d’état locale

| Élément          | Description                                           |
| ---------------- | ----------------------------------------------------- |
| Widget concerné  | HomeScreen                                            |
| Rôle de cet état | Stocker la période sélectionnée (semaine, mois, etc.) |
| Effet visible    | Mise à jour du total affiché                          |
| Fichier          | main.dart                                             |

---

## Données partagées dans l’application

| Élément          | Description                                     |
| ---------------- | ----------------------------------------------- |
| Donnée partagée  | Liste des dépenses                              |
| Écrans concernés | HomeScreen, Historique, AjouterDepense          |
| Pourquoi         | Synchroniser les données entre plusieurs écrans |
| Fichier          | depense_model.dart                              |

---

## Saisie utilisateur et traitement métier

| Élément       | Description                                       |
| ------------- | ------------------------------------------------- |
| Donnée saisie | Titre, description, montant                       |
| Écran         | AjouterDepense                                    |
| Traitement    | Création d’un objet Depense et ajout via Provider |
| Résultat      | Mise à jour de l’historique et du total           |
| Fichier       | ajoute_depense.dart                               |

---

## Liste dynamique

| Élément | Description                    |
| ------- | ------------------------------ |
| Type    | Liste de dépenses              |
| Ajout   | Via formulaire ou bouton repas |
| Écran   | Historique                     |
| Fichier | historique.dart                |

---

## Persistance des données

| Élément  | Description                                            |
| -------- | ------------------------------------------------------ |
| Données  | Liste des dépenses et préférences                      |
| Pourquoi | Conserver les données après fermeture de l’application |
| Fichier  | depense_model.dart, preferences_provider.dart          |

---

## Internationalisation

| Élément | Description           |
| ------- | --------------------- |
| Langues | Français              |
| Exemple | Textes de l’interface |
| Fichier | Widgets               |

---

## Orientation de l’écran

| Élément    | Description                       |
| ---------- | --------------------------------- |
| Différence | Interface optimisée pour portrait |
| Écran      | Tous                              |
| Fichier    | Global                            |

---

## Accès secondaire aux fonctionnalités

| Élément         | Description                  |
| --------------- | ---------------------------- |
| Type            | BottomNavigationBar / Drawer |
| Fonctionnalités | Navigation entre écrans      |
| Écran           | Tous                         |

---

## Éléments supplémentaires

| Élément    | Description                              |
| ---------- | ---------------------------------------- |
| Widget     | Dismissible                              |
| Rôle       | Suppression d’une dépense par glissement |
| Pertinence | Améliore l’expérience utilisateur        |
| Fichier    | historique.dart                          |
