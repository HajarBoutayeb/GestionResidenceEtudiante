<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Maintenance</title>
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
            background: #3b5bdb;
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
            display: flex;
            justify-content: center;
            align-items: flex-start;
            transition: margin-left 0.3s ease;
        }

        /* Conteneur principal */
        .container {
            max-width: 1000px;
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

        /* Style du formulaire */
        .form-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            font-weight: 600;
            margin-top: 10px;
            display: block;
            color: #555;
        }

        .form-container input[type="text"],
        .form-container input[type="number"],
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
        .form-container select:focus,
        .form-container textarea:focus {
            border-color: #6a8dff;
            box-shadow: 0 0 8px rgba(106, 141, 255, 0.3);
            outline: none;
        }

        .form-container textarea {
            resize: vertical;
            min-height: 80px;
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

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background: linear-gradient(135deg, #6a8dff, #3b5bdb);
            color: white;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        table th:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        /* Style des icônes d'action */
        .action-icons a {
            color: #3b5bdb;
            margin: 0 5px;
            transition: color 0.3s ease;
        }

        .action-icons a:hover {
            color: #6a8dff;
        }

        .fas.fa-edit:hover {
            color: #6a8dff; /* Changement de couleur au survol */
        }

        .fas.fa-trash:hover {
            color: #ff1a1a; /* Changement de couleur au survol */
        }
    </style>
</head>
<body>
<!-- Vérification de la session -->
<%
    Integer residentId = (Integer) session.getAttribute("id");
    if (residentId == null) {
        response.sendRedirect(request.getContextPath() + "/loginResident.jsp");
        return;
    }
%>

<!-- Menu latéral -->
<aside id="sidebar">
    <div class="top">
        <div class="logo">
            <img src="images/logo.png" alt="Logo">
            <h2>Student<span class="danger">Space</span></h2>
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
    <div class="container">
        <h1>Gestion des Requêtes de Maintenance</h1>

        <!-- Affichage des messages d'erreur ou de succès -->
        <c:if test="${not empty param.errorMessage}">
            <div class="alert alert-error">${param.errorMessage}</div>
        </c:if>
        <c:if test="${not empty param.successMessage}">
            <div class="alert alert-success">${param.successMessage}</div>
        </c:if>

        <!-- Tableau pour afficher les requêtes de maintenance du résident connecté -->
        <h2>Mes Requêtes de Maintenance</h2>
        <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                           url="jdbc:mysql://localhost/residence_manager"
                           user="root" password="root123@" />

        <sql:query dataSource="${db}" var="result">
            SELECT * FROM incidents WHERE resident_id = ?;
            <sql:param value="${sessionScope.id}" />
        </sql:query>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>ID Résident</th>
                <th>ID Chambre</th>
                <th>Description</th>
                <th>Catégorie</th>
                <th>Date Signalement</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${result.rows}">
                <tr>
                    <td>${row.id}</td>
                    <td>${row.resident_id}</td>
                    <td>${row.chambre_id}</td>
                    <td>${row.description}</td>
                    <td>${row.categorie}</td>
                    <td>${row.date_signalement}</td>
                    <td>
                        <!-- Bouton pour modifier avec une icône -->
                        <a href="${pageContext.request.contextPath}/EditMaintenanceServlet?id=${row.id}">
                            <i class="fas fa-edit" style="color: #3b5bdb; margin-right: 10px; cursor: pointer;"></i>
                        </a>
                        <!-- Bouton pour supprimer avec une icône -->
                        <a href="${pageContext.request.contextPath}/DeleteMaintenanceServlet?id=${row.id}">
                            <i class="fas fa-trash" style="color: #ff4d4d; cursor: pointer;"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- Formulaire pour soumettre une nouvelle requête de maintenance -->
        <div class="form-container">
            <h2>Nouvelle Requête de Maintenance</h2>
            <form action="${pageContext.request.contextPath}/MaintenanceServlet" method="post">
                <label for="resident_id">ID du Résident:</label>
                <input type="number" id="resident_id" name="resident_id" value="${sessionScope.id}" readonly>

                <label for="chambre_id">ID de la Chambre:</label>
                <input type="number" id="chambre_id" name="chambre_id" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>

                <label for="categorie">Catégorie:</label>
                <select id="categorie" name="categorie" required>
                    <option value="plomberie">Plomberie</option>
                    <option value="électricité">Électricité</option>
                    <option value="autre">Autre</option>
                </select>

                <input type="submit" value="Soumettre">
            </form>
        </div>
    </div>
</main>
</body>
</html>