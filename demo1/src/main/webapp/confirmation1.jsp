<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation</title>
    <!-- Lien vers Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4ff; /* Fond bleu clair */
            display: flex;
            min-height: 100vh;
            color: #3b5bdb;
        }

        /* Menu latéral */
        aside {
            width: 250px;
            background: #3b5bdb; /* Retour à la couleur précédente */
            color: white;
            padding: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: width 0.3s ease;
        }

        aside .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 30px;
        }

        aside .logo {
            display: flex;
            align-items: center;
        }

        aside .logo img {
            height: 40px;
            margin-right: 10px;
        }

        aside .logo h2 {
            font-size: 1.5rem;
            margin: 0;
            color: white;
        }

        aside .close {
            cursor: pointer;
            color: white;
            font-size: 1.5rem;
        }

        aside .sidebar {
            width: 100%;
        }

        aside .sidebar a {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            padding: 12px 16px;
            margin: 8px 0;
            border-radius: 8px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb); /* Dégradé linéaire */
            transition: background 0.3s ease, transform 0.2s ease; /* Transition pour le dégradé */
            font-size: 0.9rem;
            max-width: 100%;
        }

        aside .sidebar a:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff); /* Inverser le dégradé au survol */
            transform: translateY(-2px); /* Effet de soulèvement */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Ombre au survol */
        }

        aside .sidebar a span {
            margin-right: 10px;
        }

        aside .sidebar a .message-count {
            margin-left: auto;
            background: #ff4d4d;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 0.8rem;
        }

        /* Contenu principal */
        .container {
            flex: 1;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .confirmation-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
            animation: fadeIn 0.5s ease-in-out;
        }

        .confirmation-container i {
            font-size: 4rem;
            color: #4caf50; /* Vert pour le succès */
            margin-bottom: 20px;
            animation: bounce 1s infinite;
        }

        .confirmation-container h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #3b5bdb;
        }

        .confirmation-container p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #6a8dff;
        }

        .confirmation-container a {
            display: inline-block;
            background: linear-gradient(90deg, #3b5bdb, #6a8dff);
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .confirmation-container a:hover {
            background: linear-gradient(90deg, #2a4cb3, #4f7dcd);
            transform: translateY(-2px);
        }

        /* Animation d'apparition */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Animation de rebond pour l'icône */
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
    </style>
</head>
<body>
<!-- Menu latéral -->
<aside id="sidebar">
    <div class="top">
        <div class="logo">
            <img src="images/logo.png" alt="Logo">
            <h2>Student<span class="danger">Space</span></h2>
        </div>
        <div class="close" id="close-btn">
            <i class="fas fa-chevron-left"></i> <!-- Nouvelle icône de fermeture -->
        </div>
    </div>
    <div class="sidebar">
        <a href="dashboard.html">
            <span>🏠</span>
            <h3>Vue d’Ensemble</h3>
        </a>
        <a href="listeAdmin.jsp">
            <span>👨‍💼</span> <!-- Icône pour Admin -->
            <h3>Admin</h3>
        </a>
        <a href="indexResidents.jsp">
            <span>👤</span>
            <h3>Résidents</h3>
        </a>
        <a href="index1.jsp">
            <span>🛏️</span>
            <h3>Chambres</h3>
        </a>
        <a href="listePaiements.jsp">
            <span>💳</span>
            <h3>Paiement</h3>
        </a>
        <a href="listeIncidents1.jsp">
            <span>🔧</span>
            <h3>Requêtes de Maintenance</h3>
        </a>
        <a href="indexTechniciens.jsp">
            <span>👨‍🔧</span>
            <h3>Technicien</h3>
        </a>
        <a href="ajouter-rejeter-residents.jsp">
            <span>📝</span>
            <h3>Demande d'Inscription</h3>
        </a>
        <a href="index.jsp">
            <span>🚪</span>
            <h3>Déconnexion</h3>
        </a>
    </div>
</aside>

<!-- Contenu principal -->
<div class="container">
    <div class="confirmation-container">
        <i class="fas fa-check-circle"></i> <!-- Icône de succès -->
        <h1>Administrateur Modifié</h1>
        <p>Les informations de l'administrateur ont été modifiées avec succès.</p>
        <a href="listeAdmin.jsp">Retour à la gestion des administrateurs</a>
    </div>
</div>

<!-- Script pour fermer/réduire le menu latéral -->
<script>
    document.getElementById("close-btn").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("collapsed");
    });
</script>
</body>
</html>