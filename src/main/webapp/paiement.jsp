<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.lang.Exception" %>

<!DOCTYPE html>
<html>
<head>
  <title>Liste des Paiements</title>
  <!-- Intégration de Font Awesome pour les icônes -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Intégration de Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Style général de la page */
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f8f9fa;
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

    aside.collapsed {
      width: 80px;
    }

    aside.collapsed .logo h2,
    aside.collapsed .sidebar h4 {
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
      transition: transform 0.3s ease;
    }

    aside .close:hover {
      transform: rotate(180deg);
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
      background: rgba(255, 255, 255, 0.1);
      transition: background 0.3s ease, transform 0.2s ease;
      font-size: 0.9rem;
      max-width: 100%;
    }

    aside .sidebar a:hover {
      background: rgba(255, 255, 255, 0.2);
      transform: translateX(5px);
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
      font-weight: 700;
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
      transition: box-shadow 0.3s ease;
    }

    .search-bar:focus-within {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
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
      border-radius: 10px;
      overflow: hidden;
    }

    table th,
    table td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    table th {
      background: linear-gradient(135deg, #6a8dff, #3b5bdb);
      color: white;
      font-weight: bold;
    }

    table tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    table tr:hover {
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
      <h4>Vue d’Ensemble</h4>
    </a>
    <a href="listeAdmin.jsp">
      <span>👨‍💼</span>
      <h4>Admin</h4>
    </a>
    <a href="indexResidents.jsp">
      <span>👤</span>
      <h4>Résidents</h4>
    </a>
    <a href="index1.jsp">
      <span>🛏️</span>
      <h4>Chambres</h4>
    </a>
    <a href="paiement.jsp">
      <span>💳</span>
      <h4>Paiement</h4>
    </a>
    <a href="listeIncidents1.jsp">
      <span>🔧</span>
      <h4>Requêtes de Maintenance</h4>
    </a>
    <a href="indexTechniciens.jsp">
      <span>👨‍🔧</span>
      <h4>Technicien</h4>
    </a>
    <a href="ajouter-rejeter-residents.jsp">
      <span>📝</span>
      <h4>Demande d'Inscription</h4>
    </a>
    <a href="index.jsp">
      <span>🚪</span>
      <h4>Déconnexion</h4>
    </a>
  </div>
</aside>

<!-- Contenu principal -->
<main>
  <div class="header">
    <h1>Liste des Paiements</h1>
    <div class="search-bar">
      <input type="text" id="searchInput" placeholder="Rechercher un paiement..." oninput="filterPaiements()">
      <button type="button">
        <i class="fas fa-search"></i>
      </button>
    </div>
  </div>

  <!-- Tableau des paiements -->
  <table border="1">
    <thead>
    <tr>
      <th>ID Paiement</th>
      <th>ID Résident</th>
      <th>Montant Due</th>
      <th>Montant Payé</th>
      <th>Date de Paiement</th>
      <th>Mode de Paiement</th>
      <th>Statut</th>
      <th>Commentaire</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM paiements");

        while (rs.next()) {
          int id = rs.getInt("id");
          int residentId = rs.getInt("resident_id");
          double montantDue = rs.getDouble("montant_due");
          double montantPaye = rs.getDouble("montant_paye");
          String datePaiement = rs.getTimestamp("date_paiement").toString();
          String modePaiement = rs.getString("mode_paiement");
          String statut = rs.getString("statut");
          String commentaire = rs.getString("commentaire");
    %>
    <tr>
      <td><%= id %></td>
      <td><%= residentId %></td>
      <td><%= montantDue %></td>
      <td><%= montantPaye %></td>
      <td><%= datePaiement %></td>
      <td><%= modePaiement %></td>
      <td><%= statut %></td>
      <td><%= commentaire %></td>
      <td class="action-buttons">
        <a href="editPaiementForm.jsp?id=<%= id %>">
          <i class="fas fa-edit"></i>
        </a>
        <a href="SupprimerPaiementServlet?id=<%= id %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce paiement ?');">
          <i class="fas fa-trash"></i>
        </a>
        <a href="${pageContext.request.contextPath}/GenererRecu?id=<%= id %>">
          <i class="fas fa-download"></i>
        </a>
        <a href="javascript:void(0);" onclick="envoyerRappel(<%= id %>)">
          <i class="fas fa-bell"></i>
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

  <!-- Bouton Ajouter un paiement -->
  <div class="links-container">
    <a href="AjouterPaiementServlet.jsp" class="custom-button">Ajouter un paiement</a>
  </div>
</main>

<!-- Scripts JavaScript -->
<script>
  function filterPaiements() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const rows = document.querySelectorAll("table tbody tr");

    rows.forEach(row => {
      const idPaiement = row.cells[0].textContent.toLowerCase();
      const idResident = row.cells[1].textContent.toLowerCase();
      const statut = row.cells[6].textContent.toLowerCase();

      if (idPaiement.includes(input) || idResident.includes(input) || statut.includes(input)) {
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