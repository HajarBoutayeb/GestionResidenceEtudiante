<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, com.example.demo1.Incident" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des Incidents</title>
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
            width: 600px; /* Barre de recherche plus longue */
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
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Boutons d'action */
        .button-container {
            display: flex;
            gap: 8px;
        }

        .icon-button {
            background-color: #6a8dff;
            border: none;
            border-radius: 4px;
            color: white;
            padding: 8px 12px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .icon-button:hover {
            background-color: #3b5bdb;
        }

        .icon-button i {
            font-size: 16px;
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
    <!-- En-tête avec titre et barre de recherche -->
    <div class="header">
        <h1>Liste des Incidents</h1>
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Rechercher par ID, résident, chambre, description, catégorie ou statut..." oninput="filterIncidents()">
            <button type="button">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>

    <%
        // Formatage des dates
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        // Traitement de la mise à jour du statut
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("action") != null) {
            String action = request.getParameter("action");

            if ("updateStatut".equals(action)) {
                int incidentId = Integer.parseInt(request.getParameter("incident_id"));
                String statut = request.getParameter("statut");

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

                    String sql = "UPDATE incidents SET statut = ? WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, statut);
                    pstmt.setInt(2, incidentId);

                    int rowsUpdated = pstmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<script>alert('Statut mis à jour avec succès !');</script>");
                    } else {
                        out.println("<script>alert('Erreur lors de la mise à jour du statut.');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<script>alert('Une erreur s\'est produite.');</script>");
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }

            // Traitement de l'assignation d'un technicien
            if ("assignTechnicien".equals(action)) {
                int incidentId = Integer.parseInt(request.getParameter("incident_id"));
                int technicienId = Integer.parseInt(request.getParameter("technicien_id"));

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

                    String sql = "UPDATE incidents SET technicien_assigne = ? WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, technicienId);
                    pstmt.setInt(2, incidentId);

                    int rowsUpdated = pstmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<script>alert('Technicien assigné avec succès !');</script>");
                    } else {
                        out.println("<script>alert('Erreur lors de l\'assignation du technicien.');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<script>alert('Une erreur s\'est produite.');</script>");
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Résident</th>
            <th>Chambre</th>
            <th>Description</th>
            <th>Catégorie</th>
            <th>Date Signalement</th>
            <th>Statut</th>
            <th>Technicien Assigné</th>
            <th>Date Résolution</th>
            <th>Commentaire</th>
            <th>Actions</th>
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
                rs = stmt.executeQuery("SELECT * FROM incidents");

                while (rs.next()) {
                    Incident incident = new Incident();
                    incident.setId(rs.getInt("id"));
                    incident.setResidentId(rs.getInt("resident_id"));
                    incident.setChambreId(rs.getInt("chambre_id"));
                    incident.setDescription(rs.getString("description"));
                    incident.setCategorie(rs.getString("categorie"));
                    incident.setDateSignalement(rs.getDate("date_signalement"));
                    incident.setStatut(rs.getString("statut"));
                    incident.setTechnicienAssigne(rs.getInt("technicien_assigne"));
                    incident.setDateResolution(rs.getDate("date_resolution"));
                    incident.setCommentaireResolution(rs.getString("commentaire_resolution"));
        %>
        <tr>
            <td><%= incident.getId() %></td>
            <td><%= incident.getResidentId() %></td>
            <td><%= incident.getChambreId() %></td>
            <td><%= incident.getDescription() %></td>
            <td><%= incident.getCategorie() %></td>
            <td><%= incident.getDateSignalement() != null ? dateFormat.format(incident.getDateSignalement()) : "N/A" %></td>
            <td><%= incident.getStatut() %></td>
            <td><%= incident.getTechnicienAssigne() %></td>
            <td><%= incident.getDateResolution() != null ? dateFormat.format(incident.getDateResolution()) : "N/A" %></td>
            <td><%= incident.getCommentaireResolution() %></td>
            <td>
                <div class="button-container">
                    <form method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="updateStatut">
                        <input type="hidden" name="incident_id" value="<%= incident.getId() %>">
                        <select name="statut" onchange="this.form.submit()">
                            <option value="en attente" <%= "en attente".equals(incident.getStatut()) ? "selected" : "" %>>En attente</option>
                            <option value="en cours" <%= "en cours".equals(incident.getStatut()) ? "selected" : "" %>>En cours</option>
                            <option value="résolu" <%= "résolu".equals(incident.getStatut()) ? "selected" : "" %>>Résolu</option>
                        </select>
                    </form>
                    <form method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="assignTechnicien">
                        <input type="hidden" name="incident_id" value="<%= incident.getId() %>">
                        <input type="text" name="technicien_id" placeholder="ID Technicien" required>
                        <button type="submit" class="icon-button">
                            <i class="fas fa-user-plus"></i>
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        </tbody>
    </table>
</main>

<!-- Script pour la recherche en temps réel -->
<script>
    function filterIncidents() {
        const input = document.getElementById("searchInput").value.toLowerCase();
        const rows = document.querySelectorAll("table tbody tr");

        rows.forEach(row => {
            const id = row.cells[0].textContent.toLowerCase();
            const residentId = row.cells[1].textContent.toLowerCase();
            const chambreId = row.cells[2].textContent.toLowerCase();
            const description = row.cells[3].textContent.toLowerCase();
            const categorie = row.cells[4].textContent.toLowerCase();
            const statut = row.cells[6].textContent.toLowerCase();

            if (
                id.includes(input) ||
                residentId.includes(input) ||
                chambreId.includes(input) ||
                description.includes(input) ||
                categorie.includes(input) ||
                statut.includes(input)
            ) {
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