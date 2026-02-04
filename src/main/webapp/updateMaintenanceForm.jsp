<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modifier Signalement</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    /* Styles CSS similaires à ceux de la page principale */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #f4f4f9, #e0e0f5);
      margin: 0;
      padding: 0;
      color: #333;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .form-container {
      max-width: 400px;
      margin: 20px;
      padding: 20px;
      background: #fff;
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
  </style>
</head>
<body>
<div class="form-container">
  <h2>Modifier Signalement</h2>
  <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                     url="jdbc:mysql://localhost/residence_manager"
                     user="root" password="root123@" />

  <sql:query dataSource="${db}" var="result">
    SELECT * FROM incidents WHERE id = ?
    <sql:param value="${param.id}" />
  </sql:query>

  <c:forEach var="row" items="${result.rows}">
    <form action="${pageContext.request.contextPath}/UpdateMaintenance" method="post">
      <input type="hidden" name="id" value="${row.id}">

      <label for="resident_id">ID du résident:</label>
      <input type="number" id="resident_id" name="resident_id" value="${row.resident_id}" readonly>

      <label for="chambre_id">ID de la chambre:</label>
      <input type="number" id="chambre_id" name="chambre_id" value="${row.chambre_id}" required>

      <label for="categorie">Catégorie:</label>
      <select id="categorie" name="categorie" required>
        <option value="plomberie" ${row.categorie == 'plomberie' ? 'selected' : ''}>Plomberie</option>
        <option value="électricité" ${row.categorie == 'électricité' ? 'selected' : ''}>Électricité</option>
        <option value="autre" ${row.categorie == 'autre' ? 'selected' : ''}>Autre</option>
      </select>

      <label for="description">Description:</label>
      <textarea id="description" name="description" required>${row.description}</textarea>

      <label for="statut">Statut:</label>
      <select id="statut" name="statut" required>
        <option value="en attente" ${row.statut == 'en attente' ? 'selected' : ''}>En attente</option>
        <option value="en cours" ${row.statut == 'en cours' ? 'selected' : ''}>En cours</option>
        <option value="résolu" ${row.statut == 'résolu' ? 'selected' : ''}>Résolu</option>
      </select>

      <input type="submit" value="Mettre à jour">
    </form>
  </c:forEach>
</div>
</body>
</html>