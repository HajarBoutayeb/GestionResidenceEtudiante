<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Résident</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            height: 100vh;
            background-color: #f0f4ff; /* Changed background color */
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 1100px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .welcome-section {
            flex: 1;
            padding: 40px;
            background: url('images/h.jpg') no-repeat center center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            background-size: cover;
        }

        .welcome-section h1 {
            font-size: 2.8rem;
            margin-bottom: 15px;
            color: #3b5bdb;
        }

        .welcome-section p {
            font-size: 1rem;
            margin-bottom: 20px;
            line-height: 1.5;
            color: #6a8dff;
        }

        .signin-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background-color: #f0f4ff;
        }

        .signin-section h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #3b5bdb;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-size: 1rem;
            color: #6a8dff;
        }

        input {
            margin-bottom: 20px;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f9f9f9;
        }

        input:focus {
            outline: none;
            border-color: #3b5bdb;
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        button {
            background: linear-gradient(90deg, #3b5bdb, #6a8dff);
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        button:hover {
            background: linear-gradient(90deg, #2a4cb3, #4f7dcd);
        }

        a {
            color: #3b5bdb;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        
        .signin-section p {
            color: black; /* Changed color to black */
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-section">
            <!-- Suppression des textes ici -->
        </div>

        <div class="signin-section">
            <h2>Connexion</h2>
            <form action="loginResident" method="post">
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" placeholder="Entrez votre email" required>

                <label for="mot_de_passe">Mot de passe :</label>
                <input type="password" id="mot_de_passe" name="mot_de_passe" placeholder="Entrez votre mot de passe" required>

                <button type="submit">Se connecter</button>
            </form>

            <%
                String error = request.getParameter("error");
                if (error != null) {
                    if (error.equals("1")) {
                        out.println("<p class='error-message'>Email ou mot de passe incorrect.</p>");
                    } else if (error.equals("2")) {
                        out.println("<p class='error-message'>Erreur de connexion à la base de données.</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>