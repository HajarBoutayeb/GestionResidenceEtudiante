<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Technicien</title>
    <!-- Intégration de Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Style général de la page */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f4f4f9, #e0e0f5);
            margin: 0;
            padding: 0;
            color: #333;
            display: flex;
            min-height: 100vh;
        }

        /* Menu latéral */
        aside {
            width: 250px;
            background: #3b5bdb; /* Couleur de fond du menu latéral */
            color: white;
            padding: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
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
        main {
            flex: 1;
            padding: 20px;
            display: flex;
            justify-content: center; /* Centrer horizontalement */
            align-items: flex-start; /* Aligner en haut */
            transition: margin-left 0.3s ease;
        }

        /* Conteneur principal */
        .container {
            max-width: 600px;
            width: 100%;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
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
            color: #3b5bdb;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: 600;
        }

        /* Style des champs de formulaire */
        form input[type="text"],
        form input[type="email"],
        form input[type="password"],
        form select,
        form textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* Effet de focus sur les champs */
        form input[type="text"]:focus,
        form input[type="email"]:focus,
        form input[type="password"]:focus,
        form select:focus,
        form textarea:focus {
            border-color: #6a8dff;
            box-shadow: 0 0 8px rgba(106, 141, 255, 0.3);
            outline: none;
        }

        /* Style des textarea */
        form textarea {
            resize: vertical;
            min-height: 120px;
        }

        /* Style des boutons */
        form button {
            display: block;
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 20px;
        }

        /* Effet de survol pour le bouton */
        form button:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
        }

        /* Style du lien de retour */
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
            text-align: center;
        }

        /* Effet de survol pour le lien */
        a:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
        }

        /* Style pour les labels */
        form label {
            font-weight: 600;
            margin-top: 10px;
            display: block;
            color: #555;
        }

        /* Style pour les options des select */
        form select option {
            padding: 10px;
        }

        /* Style pour les messages d'erreur (optionnel) */
        .error-message {
            color: #ff4d4d;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        /* Ajout d'une ombre portée au formulaire */
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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
    <main>
        <div class="container">
            <h1>Ajouter un Technicien</h1>
            <form action="AjouterTechnicienServlet" method="post">
                <label for="nom">Nom:</label>
                <input type="text" id="nom" name="nom" required><br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required><br>

                <label for="mot_de_passe">Mot de passe:</label>
                <input type="password" id="mot_de_passe" name="mot_de_passe" required><br>

                <label for="telephone">Téléphone:</label>
                <input type="text" id="telephone" name="telephone" required><br>

                <label for="specialite">Spécialité:</label>
                <select id="specialite" name="specialite" required>
                    <option value="plomberie">Plomberie</option>
                    <option value="électricité">Électricité</option>
                    <option value="maintenance générale">Maintenance Générale</option>
                    <option value="autre">Autre</option>
                </select><br>

                <button type="submit">Ajouter</button>
            </form>
            <a href="indexTechniciens.jsp">Retour à la liste</a>
        </div>
    </main>
</body>
</html>