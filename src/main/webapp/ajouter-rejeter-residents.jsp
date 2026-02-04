<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des inscriptions</title>
    <!-- Intégration de Font Awesome -->
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

        h1 {
            color: #3b5bdb;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Style du tableau */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Ombre */
            border-radius: 8px; /* Bordures arrondies */
            overflow: hidden; /* Pour que les bordures arrondies s'appliquent correctement */
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd; /* Bordure inférieure pour les cellules */
        }

        th {
            background: linear-gradient(135deg, #6a8dff, #3b5bdb); /* Dégradé linéaire */
            color: white; /* Texte en blanc */
            font-weight: bold; /* Texte en gras */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* Fond alterné pour les lignes paires */
        }

        tr:hover {
            background-color: #f1f1f1; /* Effet de survol */
        }

        .action-links {
            white-space: nowrap;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            border: 2px solid #3b5bdb;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            background-color: transparent;
            color: #3b5bdb;
            margin: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background-color: #3b5bdb;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn i {
            margin-right: 5px;
        }

        .btn-validate i {
            color: #28a745;
        }

        .btn-reject i {
            color: #dc3545;
        }

        /* Style pour le bouton de téléchargement */
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
            <i class="fas fa-chevron-left"></i>
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
    <h1>Demandes d'inscription</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>CNE</th>
            <th>Email</th>
            <th>Statut</th>
            <th>Carte Étudiant</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
                stmt = conn.createStatement();
                String sql = "SELECT * FROM residents WHERE statut = 'en attente'";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String id = rs.getString("id");
                    String nom = rs.getString("nom");
                    String prenom = rs.getString("prenom");
                    String cne = rs.getString("CNE");
                    String email = rs.getString("email");
                    String statut = rs.getString("statut");
                    String carteEtudiant = rs.getString("carte_etudiant");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= nom %></td>
            <td><%= prenom %></td>
            <td><%= cne %></td>
            <td><%= email %></td>
            <td><%= statut %></td>
            <td>
                <% if (carteEtudiant != null && !carteEtudiant.isEmpty()) { %>
                <a href="uploads/<%= carteEtudiant %>" class="download-link" download>
                    <i class="fas fa-file-download"></i> Télécharger
                </a>
                <% } else { %>
                Aucun fichier
                <% } %>
            </td>
            <td>
                <form action="UpdateResidentStatus" method="post">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="email" value="<%= email %>"> <!-- E-mail du résident -->
                    <input type="hidden" name="nom" value="<%= nom %>"> <!-- Nom du résident -->
                    <input type="hidden" name="prenom" value="<%= prenom %>"> <!-- Prénom du résident -->
                    <button type="submit" name="action" value="valider" class="btn btn-validate">
                        <i class="fas fa-check-circle"></i> Valider
                    </button>
                    <button type="submit" name="action" value="rejeter" class="btn btn-reject">
                        <i class="fas fa-times-circle"></i> Rejeter
                    </button>
                </form>
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
    </table>
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