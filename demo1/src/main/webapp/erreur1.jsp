<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Erreur</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Style général de la page */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f4f4f9, #e0e0f5);
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
        }

        /* Menu latéral */
        aside {
            width: 250px;
            background: #3b5bdb;
            color: white;
            padding: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        aside .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        aside .logo img {
            height: 40px;
            margin-right: 10px;
        }

        aside .logo h2 {
            font-size: 1.5rem;
            margin: 0;
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
            transition: background 0.3s ease;
            font-size: 0.9rem;
            max-width: 100%;
        }

        aside .sidebar a:hover {
            background: rgba(255, 255, 255, 0.1);
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

        .error-container {
            max-width: 600px;
            width: 100%;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
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

        /* Titre de la page */
        h1 {
            color: #ff4d4d;
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Message d'erreur */
        .error-message {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 30px;
        }

        /* Bouton de retour */
        .back-link {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .back-link:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<!-- Menu latéral -->
<aside>
    <div class="logo">
        <img src="images/logo.png" alt="Logo">
        <h2>Student<span class="danger">Space</span></h2>
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
            <h3>Maintenance</h3>
        </a>
        <a href="indexTechniciens.jsp">
            <span>👨‍🔧</span>
            <h3>Technicien</h3>
        </a>
        <a href="#">
            <span>🔔</span>
            <h3>Notifications</h3>
            <span class="message-count">21</span>
        </a>
        <a href="ajouter-rejeter-residents.jsp">
            <span>📝</span>
            <h3>Demande d'Inscription</h3>
        </a>
        <a href="#">
            <span>📊</span>
            <h3>Rapports</h3>
        </a>
        <a href="#">
            <span>⚙️</span>
            <h3>Paramètres</h3>
        </a>
        <a href="#">
            <span>🚪</span>
            <h3>Déconnexion</h3>
        </a>
    </div>
</aside>

<!-- Contenu principal -->
<div class="container">
    <div class="error-container">
        <h1><i class="fas fa-exclamation-triangle"></i> Erreur</h1>
        <div class="error-message">
            <%
                // Récupérer le message d'erreur depuis la requête
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
                    out.println(errorMessage);
                } else {
                    out.println("Une erreur inattendue s'est produite lors de la modification de l'administrateur.");
                }
            %>
        </div>
        <a href="listeAdmin.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la gestion des administrateurs
        </a>
    </div>
</div>
</body>
</html>