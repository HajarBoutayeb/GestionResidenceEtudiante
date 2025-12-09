# 📘 Application Web de Gestion des Résidences Étudiantes

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![Servlets](https://img.shields.io/badge/Servlets-5382A1?style=for-the-badge&logo=java&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![HTML](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![PDF](https://img.shields.io/badge/iTextPDF-CC0000?style=for-the-badge&logo=adobeacrobatreader&logoColor=white)

---

## 📝 Description

Ce projet est une **application web Java EE (JSP/Servlets)** développée dans le cadre du cursus universitaire à la  
**Faculté des Sciences Ben M’Sik – Université Hassan II de Casablanca**.

Elle vise à **automatiser la gestion des résidences étudiantes**, en offrant deux principales interfaces :

* **Interface Administrateur** : gestion des chambres, des résidents, des paiements, des requêtes de maintenance, des techniciens et des statistiques globales.  
* **Interface Résident** : gestion du profil, suivi des paiements, soumission et suivi des requêtes de maintenance.

L’objectif est d’assurer une **gestion centralisée, efficace et transparente** des opérations liées à la résidence universitaire.

---

## 🚀 Fonctionnalités

### 👩‍💼 Côté Administrateur :

* 🏠 **Gestion des chambres** : ajout, modification, suppression, visualisation de la disponibilité.  
* 👩‍🎓 **Gestion des résidents** : validation des préinscriptions, attribution des chambres, mise à jour des données.  
* 💳 **Gestion des paiements** : suivi des statuts (payé, en retard, en attente), envoi de rappels, génération de **reçus PDF**.  
* 🔧 **Gestion des requêtes de maintenance** : attribution de techniciens, suivi du statut (nouvelle, en cours, résolue).  
* 👷 **Gestion des techniciens** : ajout, modification, activation/désactivation.  
* 🧑‍💼 **Gestion des administrateurs secondaires** : ajout ou suppression d’administrateurs.  
* 📊 **Tableau de bord** : visualisation des statistiques générales (occupation, paiements, maintenance, etc.).

### 🧑‍🎓 Côté Résident :

* 👤 **Préinscription et connexion** avec validation par l’administrateur.  
* 🛏️ **Consultation des chambres disponibles** et soumission de demandes de réservation.  
* 💰 **Consultation de l’historique des paiements** et téléchargement de reçus.  
* 🛠️ **Soumission et suivi des requêtes de maintenance**.  
* 🧾 **Mise à jour du profil personnel** (coordonnées, mot de passe).  

---

## 🛠️ Technologies utilisées

* **Back-end** : Java EE (Servlets, JSP)  
* **Serveur** : Apache Tomcat 9 / 10  
* **Base de données** : MySQL 8.0  
* **Front-end** : HTML5, CSS3, JavaScript  
* **Bibliothèques** : JDBC, iTextPDF  
* **IDE** : IntelliJ IDEA / Eclipse  
* **Modélisation UML** : StarUML / Draw.io  

---

## 📂 Structure du projet

```bash
GestionResidenceUniversitaire/
│── src/                  # Code source Java (Models, DAO, Controllers)
│── webapp/               # JSP, CSS, JS, Images
│── WEB-INF/              # Fichier de configuration web.xml
│── database/             # Scripts SQL pour la création de la base de données
│── docs/                 # Documentation, diagrammes UML
│── screenshots/          # Captures d’écran
│── README.md             # Description du projet

⚙️ Installation et Exécution

Cloner le projet

git clone https://github.com/HajarBoutayeb/GestionResidenceUniversitaire.git


Ouvrir le projet dans IntelliJ IDEA ou Eclipse en tant que projet web dynamique.

Configurer la base de données MySQL

Créez une base de données nommée residence_db.

Importez le fichier SQL se trouvant dans le dossier /database.

Mettez à jour les identifiants de connexion dans le fichier DBConnection.java.

Déployer le projet sur Apache Tomcat

Utilisez Tomcat 9 ou 10 comme serveur d’exécution.

Lancez l’application.

Accéder à l’application web

http://localhost:8080/GestionResidenceUniversitaire

## 📊 Screenshots

1. Accueil
![accueil](img/accueil.png)

2. Tableau de bord
![tableau de bord](img/tableau de bord.png)

3. Interface demandes d'inscription
![demandes d'inscription](img/demandes d'inscription.png)

4. Formulaire d'inscription
![Formulaire d'inscription](img/Formulaire d'inscription.png)

5. Mise à jour profile
![mise a jour profile](img/mise a jour profile.png)

6. Signalement de maintenance
![signalement de maintenance](img/signalement de maintenance.png)

---


📖 Documentation

📑 Spécifications et cahier des charges

📐 Diagrammes UML (cas d’utilisation, classes, séquences)

🧠 Conception et implémentation du système

🧭 Manuel d’utilisation (facultatif)

👥 Auteur

Hajar Boutayeb – Étudiante en Master Big Data & Data Science
Faculté des Sciences Ben M’Sik – Université Hassan II de Casablanca
Encadré par : M. Abdessamad Belangour
Année universitaire : 2024/2025