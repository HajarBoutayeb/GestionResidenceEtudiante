<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modifier un Paiement</title>
  <!-- Intégration de Font Awesome pour les icônes -->
  <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
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

    /* Conteneur du formulaire */
    .form-container {
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 400px;
      max-width: 100%;
      margin: 0 auto;
    }

    .form-container h2 {
      color: #3b5bdb;
      text-align: center;
      margin-bottom: 20px;
    }

    .form-container label {
      font-weight: bold;
      margin-top: 10px;
      display: block;
      color: #555;
    }

    .form-container input[type="text"],
    .form-container input[type="number"],
    .form-container input[type="datetime-local"],
    .form-container select,
    .form-container textarea {
      width: 100%;
      padding: 10px;
      margin: 8px 0;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 0.9rem;
      box-sizing: border-box;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .form-container input[type="text"]:focus,
    .form-container input[type="number"]:focus,
    .form-container input[type="datetime-local"]:focus,
    .form-container select:focus,
    .form-container textarea:focus {
      border-color: #6a8dff;
      box-shadow: 0 0 8px rgba(106, 141, 255, 0.3);
      outline: none;
    }

    .form-container textarea {
      resize: vertical;
      min-height: 100px;
    }

    .form-container input[type="submit"] {
      display: block;
      width: 100%;
      padding: 12px;
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

    .form-container input[type="submit"]:hover {
      background: linear-gradient(135deg, #3b5bdb, #6a8dff);
      transform: translateY(-2px);
    }

    /* Style pour les messages d'erreur ou de succès */
    .message {
      text-align: center;
      margin-top: 20px;
      padding: 10px;
      border-radius: 8px;
    }

    .success {
      background-color: #d4edda;
      color: #155724;
    }

    .error {
      background-color: #f8d7da;
      color: #721c24;
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
      <span>👨‍💼</span>
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
  <div class="form-container">
    <h2>Modifier un Paiement</h2>

    <!-- Formulaire pour modifier un paiement -->
    <form action="ModifierPaiementServlet" method="post">
      <%
        String id = request.getParameter("id");
        if (id != null) {
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
            String sql = "SELECT * FROM paiements WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
              int residentId = rs.getInt("resident_id");
              double montantDue = rs.getDouble("montant_due");
              double montantPaye = rs.getDouble("montant_paye");
              String datePaiement = rs.getString("date_paiement");
              String modePaiement = rs.getString("mode_paiement");
              String statut = rs.getString("statut");
              String commentaire = rs.getString("commentaire");
      %>
      <input type="hidden" name="id" value="<%= id %>">
      <label>ID Résident :</label>
      <input type="text" name="residentId" value="<%= residentId %>" required>

      <label>Montant Due :</label>
      <input type="number" step="0.01" name="montantDue" value="<%= montantDue %>" required>

      <label>Montant Payé :</label>
      <input type="number" step="0.01" name="montantPaye" value="<%= montantPaye %>" required>

      <label>Date de Paiement :</label>
      <input type="datetime-local" name="datePaiement" value="<%= datePaiement %>" required>

      <label>Mode de Paiement :</label>
      <select name="modePaiement" required>
        <option value="Espèce" <%= modePaiement.equals("Espèce") ? "selected" : "" %>>Espèce</option>
        <option value="Carte" <%= modePaiement.equals("Carte") ? "selected" : "" %>>Carte</option>
        <option value="Virement" <%= modePaiement.equals("Virement") ? "selected" : "" %>>Virement</option>
      </select>

      <label>Statut :</label>
      <select name="statut" required>
        <option value="Payé" <%= statut.equals("Payé") ? "selected" : "" %>>Payé</option>
        <option value="En attente" <%= statut.equals("En attente") ? "selected" : "" %>>En attente</option>
        <option value="Annulé" <%= statut.equals("Annulé") ? "selected" : "" %>>Annulé</option>
      </select>

      <label>Commentaire :</label>
      <textarea name="commentaire" rows="3"><%= commentaire %></textarea>

      <input type="submit" value="Enregistrer les modifications">
      <%
            }
            conn.close();
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      %>
    </form>
    <a href="paiement.jsp" style="display: block; text-align: center; margin-top: 20px;">Retour à la liste</a>
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