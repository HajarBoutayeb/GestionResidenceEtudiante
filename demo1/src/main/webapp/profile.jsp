<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Résident</title>
    <!-- Lien vers Google Fonts pour la police Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <!-- Lien vers Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Style général de la page */
        body {
            font-family: 'Poppins', sans-serif;
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
            background: #3b5bdb;
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
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            transition: background 0.3s ease, transform 0.2s ease;
            font-size: 0.9rem;
            max-width: 100%;
        }

        aside .sidebar a:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        aside .sidebar a span {
            margin-right: 10px;
        }

        /* Contenu principal */
        main {
            flex: 1;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        /* Conteneur du profil */
        .profile-container {
            max-width: 800px;
            width: 100%;
            background: #fff;
            padding: 40px;
            border-radius: 20px;
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
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: 600;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

        h1::after {
            content: '';
            display: block;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #6a8dff, #3b5bdb);
            position: absolute;
            bottom: 0;
            left: 0;
            border-radius: 2px;
        }

        /* Section des informations du profil */
        .profile-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .profile-info p {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            font-size: 1rem;
            color: #555;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .profile-info p strong {
            color: #3b5bdb;
            font-weight: 600;
            margin-right: 10px;
        }

        .profile-info p i {
            margin-right: 10px;
            color: #6a8dff;
        }

        /* Style pour le lien de téléchargement de la carte étudiante */
        .profile-info a {
            color: #6a8dff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .profile-info a:hover {
            color: #3b5bdb;
            text-decoration: underline;
        }

        /* Bouton de modification */
        .edit-button-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .edit-button {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .edit-button i {
            margin-right: 8px;
        }

        /* Effet de survol pour le bouton */
        .edit-button:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
        }

        /* Style pour les messages d'erreur */
        .error-message {
            color: #ff4d4d;
            font-size: 0.9rem;
            margin-top: 10px;
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            aside {
                width: 100%;
                height: auto;
                padding: 10px;
                text-align: center;
            }

            aside .sidebar {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            aside .sidebar a {
                margin: 10px;
            }

            main {
                padding: 10px;
            }

            .profile-container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            .profile-info {
                grid-template-columns: 1fr;
            }

            .edit-button-container {
                justify-content: center;
            }

            .edit-button {
                width: 100%;
                justify-content: center;
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
            <i class="fas fa-chevron-left"></i>
        </div>
    </div>
    <div class="sidebar">
        <a href="profile.jsp">
            <span>👤</span>
            <h3>Profil</h3>
        </a>
        <a href="listeChambres.jsp">
            <span>🛏️</span>
            <h3>Chambres</h3>
        </a>
        <a href="paiementResident.jsp">
            <span>💳</span>
            <h3>Paiements</h3>
        </a>
        <a href="maintenance.jsp">
            <span>🔧</span>
            <h3>Maintenance</h3>
        </a>
        <a href="index.jsp">
            <span>🚪</span>
            <h3>Déconnexion</h3>
        </a>
    </div>
</aside>

<!-- Contenu principal -->
<main>
    <div class="profile-container">
        <h1>Profil Résident</h1>
        <%
            String email = (String) session.getAttribute("email");
            if (email == null) {
                response.sendRedirect("loginResident.jsp");
                return;
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@")) {
                    String sql = "SELECT * FROM residents WHERE email = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, email);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            String nom = rs.getString("nom");
                            String prenom = rs.getString("prenom");
                            String cne = rs.getString("CNE");
                            String statut = rs.getString("statut");
                            int chambreId = rs.getInt("chambre_id");
                            String carteEtudiant = rs.getString("carte_etudiant");
        %>
        <div class="profile-info">
            <p><i class="fas fa-user"></i><strong>Nom :</strong> <%= nom %></p>
            <p><i class="fas fa-user"></i><strong>Prénom :</strong> <%= prenom %></p>
            <p><i class="fas fa-id-card"></i><strong>CNE :</strong> <%= cne %></p>
            <p><i class="fas fa-envelope"></i><strong>Email :</strong> <%= email %></p>
            <p><i class="fas fa-info-circle"></i><strong>Statut :</strong> <%= statut %></p>
            <p><i class="fas fa-door-open"></i><strong>Chambre ID :</strong> <%= chambreId %></p>
            <p><i class="fas fa-id-badge"></i><strong>Carte Étudiant :</strong>
                <% if (carteEtudiant != null && !carteEtudiant.isEmpty()) { %>
                <a href="<%= carteEtudiant %>" download="carte_etudiant.pdf">Télécharger la carte</a>
                <% } else { %>
                Non fournie
                <% } %>
            </p>
        </div>
        <div class="edit-button-container">
            <a href="updateProfile.jsp" class="edit-button"><i class="fas fa-edit"></i> Modifier</a>
        </div>
        <%
                        } else {
                            out.println("<p class='error-message'>Aucun résident trouvé pour cet email.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p class='error-message'>Erreur : " + e.getMessage() + "</p>");
            }
        %>
    </div>
</main>

<!-- Script pour fermer/réduire le menu latéral -->
<script>
    document.getElementById("close-btn").addEventListener("click", function () {
        const sidebar = document.getElementById("sidebar");
        sidebar.classList.toggle("collapsed");
    });
</script>
</body>
</html>