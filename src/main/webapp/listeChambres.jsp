<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Chambres Disponibles</title>
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
            font-size: 2rem;
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
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        th:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Style pour les boutons de sélection */
        .custom-radio {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 120px;
            height: 50px;
            border: 2px solid #3b5bdb;
            border-radius: 8px;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            cursor: pointer;
            transition: transform 0.2s ease, background 0.3s ease;
        }

        .custom-radio.selected {
            background: linear-gradient(to right, #3b5bdb, #6a8dff);
        }

        .custom-radio:hover {
            transform: scale(1.05);
            background: linear-gradient(to right, #3b5bdb, #6a8dff);
        }

        .custom-radio input[type="radio"] {
            display: none;
        }

        .custom-radio div {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: #fff;
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Style pour le bouton "Valider la réservation" */
        .custom-button {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1rem;
            transition: background 0.3s ease, transform 0.2s ease;
            margin: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: none;
            cursor: pointer;
        }

        .custom-button:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
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
    <!-- En-tête avec titre et barre de recherche -->
    <div class="header">
        <h1>Liste des Chambres Disponibles</h1>
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Rechercher par numéro ou taille..." oninput="filterChambres()">
            <button type="button">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>

    <!-- Afficher un message d'erreur ou de succès -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>
    <% if (request.getAttribute("successMessage") != null) { %>
    <div class="success-message">
        <%= request.getAttribute("successMessage") %>
    </div>
    <% } %>

    <!-- Formulaire pour envoyer la sélection -->
    <form action="${pageContext.request.contextPath}/ReserverChambreServlet" method="post">
        <!-- Tableau des chambres -->
        <table border="1">
            <thead>
            <tr>
                <th>ID</th>
                <th>Numéro</th>
                <th>Taille</th>
                <th>Équipements</th>
                <th>Prix Mensuel</th>
                <th>Étage</th>
                <th>Description</th>
                <th>Sélectionner</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM chambres WHERE statut = 'disponible'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String numeroChambre = rs.getString("numero_chambre");
                        String taille = rs.getString("taille");
                        String equipements = rs.getString("equipements");
                        double prixMensuel = rs.getDouble("prix_mensuel");
                        int etage = rs.getInt("etage");
                        String description = rs.getString("description");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= numeroChambre %></td>
                <td><%= taille %></td>
                <td><%= equipements %></td>
                <td><%= prixMensuel %> MAD</td>
                <td><%= etage %></td>
                <td><%= description %></td>
                <td>
                    <label class="custom-radio">
                        <input type="radio" name="chambreId" value="<%= id %>" required>
                        <div>Sélectionner</div>
                    </label>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
            </tbody>
        </table>

        <!-- Bouton Valider la réservation -->
        <div class="links-container">
            <button type="submit" class="custom-button">Valider la réservation</button>
        </div>
    </form>
</main>

<!-- Script pour la recherche en temps réel -->
<script>
    function filterChambres() {
        const input = document.getElementById("searchInput").value.toLowerCase();
        const rows = document.querySelectorAll("table tbody tr");

        rows.forEach(row => {
            const numeroChambre = row.cells[1].textContent.toLowerCase();
            const taille = row.cells[2].textContent.toLowerCase();

            if (numeroChambre.includes(input) || taille.includes(input)) {
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