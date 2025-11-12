<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier la Maintenance</title>
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
            max-width: 800px;
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
        form {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        form label {
            font-weight: 600;
            margin-top: 10px;
            display: block;
            color: #555;
        }

        form input[type="text"],
        form input[type="number"],
        form select,
        form textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 0.9rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        form input[type="text"]:focus,
        form input[type="number"]:focus,
        form select:focus,
        form textarea:focus {
            border-color: #6a8dff;
            box-shadow: 0 0 8px rgba(106, 141, 255, 0.3);
            outline: none;
        }

        form textarea {
            resize: vertical;
            min-height: 100px;
        }

        form input[type="submit"] {
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

        form input[type="submit"]:hover {
            background: linear-gradient(135deg, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
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
        <h1>Modifier la Requête de Maintenance</h1>

        <!-- Formulaire de modification -->
        <form action="${pageContext.request.contextPath}/UpdateMaintenanceServlet" method="post">
            <input type="hidden" name="id" value="${id}">

            <label for="resident_id">ID du Résident:</label>
            <input type="number" id="resident_id" name="resident_id" value="${resident_id}" readonly>

            <label for="chambre_id">ID de la Chambre:</label>
            <input type="number" id="chambre_id" name="chambre_id" value="${chambre_id}" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required>${description}</textarea>

            <label for="categorie">Catégorie:</label>
            <select id="categorie" name="categorie" required>
                <option value="plomberie" ${categorie == 'plomberie' ? 'selected' : ''}>Plomberie</option>
                <option value="électricité" ${categorie == 'électricité' ? 'selected' : ''}>Électricité</option>
                <option value="autre" ${categorie == 'autre' ? 'selected' : ''}>Autre</option>
            </select>

            <label for="statut">Statut:</label>
            <select id="statut" name="statut" required>
                <option value="en attente" ${statut == 'en attente' ? 'selected' : ''}>En attente</option>
                <option value="en cours" ${statut == 'en cours' ? 'selected' : ''}>En cours</option>
                <option value="résolu" ${statut == 'résolu' ? 'selected' : ''}>Résolu</option>
            </select>

            <input type="submit" value="Mettre à jour">
        </form>
    </div>
</main>
</body>
</html>