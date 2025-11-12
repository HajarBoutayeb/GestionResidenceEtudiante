<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Résidents</title>
    <!-- Intégration de Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Style général de la page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
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
        main {
            flex: 1;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        /* En-tête avec titre et barre de recherche */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        h1 {
            color: #3b5bdb;
            margin: 0;
        }

        /* Barre de recherche moderne */
        .search-bar {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 25px;
            padding: 8px 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        .search-bar input {
            border: none;
            outline: none;
            flex: 1;
            font-size: 1rem;
            padding: 8px;
            background: transparent;
        }

        .search-bar button {
            border: none;
            background: transparent;
            cursor: pointer;
            color: #6a8dff;
            transition: color 0.3s ease;
        }

        .search-bar button:hover {
            color: #3b5bdb;
        }

        /* Style du tableau */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background: linear-gradient(135deg, #6a8dff, #3b5bdb); /* Dégradé linéaire */
            color: white;
            font-weight: bold;
            transition: background 0.3s ease; /* Transition pour un effet fluide */
        }

        th:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff); /* Inverser le dégradé au survol */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Style pour les boutons d'action (icônes) */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-buttons a {
            display: inline-block;
            padding: 8px;
            border-radius: 8px;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            color: white;
            text-decoration: none;
            transition: transform 0.2s ease, background 0.3s ease;
        }

        .action-buttons a:hover {
            transform: scale(1.1);
            background: linear-gradient(to right, #3b5bdb, #6a8dff);
        }

        /* Style pour les boutons personnalisés */
        .custom-button {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb); /* Dégradé linéaire */
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1rem;
            transition: background 0.3s ease, transform 0.2s ease; /* Transition pour le dégradé */
            margin: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .custom-button:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff); /* Inverser le dégradé au survol */
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        /* Conteneur pour centrer les boutons */
        .links-container {
            text-align: center;
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        /* Style pour le lien de téléchargement */
        .download-link {
            display: inline-flex;
            align-items: center;
            color: #3b5bdb;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease, transform 0.2s ease;
            padding: 8px 12px;
            border-radius: 8px;
            background-color: rgba(106, 141, 255, 0.1); /* Fond léger */
        }

        .download-link:hover {
            color: #6a8dff;
            background-color: rgba(106, 141, 255, 0.2); /* Fond plus visible au survol */
            transform: translateY(-2px); /* Effet de soulèvement */
        }

        .download-link i {
            margin-right: 8px; /* Espace entre l'icône et le texte */
            font-size: 1.2rem; /* Taille de l'icône */
        }

        /* Style pour le menu latéral réduit */
        aside.collapsed {
            width: 80px;
        }

        aside.collapsed .logo h2,
        aside.collapsed .sidebar h3 {
            display: none;
        }

        aside.collapsed .sidebar a {
            justify-content: center;
        }

        aside.collapsed .sidebar a span {
            margin-right: 0;
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
            <a href="paiement.jsp">
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
        <!-- En-tête avec titre et barre de recherche -->
        <div class="header">
            <h1>Liste des Résidents</h1>
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Rechercher un résident..." oninput="filterResidents()">
                <button type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>

        <!-- Tableau des résidents -->
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>CNE</th>
                    <th>Email</th>
                    <th>Chambre ID</th>
                    <th>Statut</th>
                    <th>Carte d'étudiant</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM residents");

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String nom = rs.getString("nom");
                            String prenom = rs.getString("prenom");
                            String CNE = rs.getString("CNE");
                            String email = rs.getString("email");
                            int chambreId = rs.getInt("chambre_id");
                            String statut = rs.getString("statut");
                            String carteEtudiant = rs.getString("carte_etudiant");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= nom %></td>
                    <td><%= prenom %></td>
                    <td><%= CNE %></td>
                    <td><%= email %></td>
                    <td><%= chambreId %></td>
                    <td><%= statut %></td>
                    <td>
                        <a href="<%= carteEtudiant %>" class="download-link" download>
                            <i class="fas fa-file-download"></i> Télécharger
                        </a>
                    </td>
                    <td class="action-buttons">
                        <a href="ModifierResident.jsp?id=<%= id %>">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="SupprimerResidentServlet?id=<%= id %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce résident ?');">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <!-- Bouton Ajouter un résident -->
        <div class="links-container">
            <a href="ajouterResident.jsp" class="custom-button">Ajouter un résident</a>
        </div>
    </main>

    <!-- Script pour la recherche en temps réel -->
    <script>
        function filterResidents() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("table tbody tr");

            rows.forEach(row => {
                const nom = row.cells[1].textContent.toLowerCase();
                const prenom = row.cells[2].textContent.toLowerCase();
                const CNE = row.cells[3].textContent.toLowerCase();

                if (nom.includes(input) || prenom.includes(input) || CNE.includes(input)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        // Script pour fermer/réduire le menu latéral
        document.getElementById("close-btn").addEventListener("click", function () {
            const sidebar = document.getElementById("sidebar");
            sidebar.classList.toggle("collapsed");
        });
    </script>
</body>
</html>