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
* 🔧 **Gestion des requêtes de maintenance** : attribution de techniciens, suivi du statut.  
* 👷 **Gestion des techniciens** : ajout, modification, activation/désactivation.  
* 📊 **Tableau de bord** : visualisation des statistiques générales.

### 🧑‍🎓 Côté Résident :
* 👤 **Préinscription** et connexion sécurisée.  
* 🛏️ **Réservation** : consultation et soumission de demandes.  
* 💰 **Paiements** : historique et téléchargement de reçus.  
* 🛠️ **Maintenance** : soumission et suivi des requêtes.

---

## 🛠️ Technologies utilisées

* **Back-end** : Java EE (Servlets, JSP)  
* **Serveur** : Apache Tomcat 9 / 10  
* **Base de données** : MySQL 8.0  
* **Front-end** : HTML5, CSS3, JavaScript  
* **Bibliothèques** : JDBC, iTextPDF  

---

## 📂 Structure du projet

```bash
GestionResidenceUniversitaire/
│── src/                  # Code source Java (Models, DAO, Controllers)
│── webapp/               # JSP, CSS, JS, Images
│── WEB-INF/              # Fichier de configuration web.xml
│── database/             # Scripts SQL
│── docs/                 # Documentation & UML
│── screenshots/          # Captures d’écran
└── README.md             # Description du projet

⚙️ Installation et Exécution

Cloner le projet
git clone [https://github.com/HajarBoutayeb/GestionResidenceUniversitaire.git]

Configuration

Ouvrez le projet dans IntelliJ IDEA ou Eclipse.

Créez la base de données residence_db et importez le fichier SQL.

Configurez les identifiants dans DBConnection.java.

Lancement

Déployez sur Apache Tomcat.

URL : http://localhost:8080/GestionResidenceUniversitaire

## 📊 Screenshots

![accueil](img/page-accueil.png)
![tableau-bord](img/tableau-bord.png)
![demandes-inscription](img/demandes-inscription.png)
![formulaire-inscription](img/formulaire-inscription.png)
![mise-a-jour-profil](img/mise-a-jour-profil.png)
![signalement-maintenance](img/signalement-maintenance.png)
---

📖 Documentation

📑 Spécifications et cahier des charges

📐 Diagrammes UML (cas d’utilisation, classes, séquences)

🧠 Conception et implémentation du système

🧭 Manuel d’utilisation (facultatif)

## 👩‍💻 Auteure

**Hajar Boutayeb**  
📧 Email : hajarboutayeb3@gmail.com  
🔗 LinkedIn : https://www.linkedin.com/in/hajar-boutayeb-25bb90303/
