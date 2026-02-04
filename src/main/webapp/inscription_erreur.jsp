<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur d'inscription</title>
    <!-- Lien vers Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            background-color: #f0f4ff; /* Fond bleu clair */
            display: flex;
            justify-content: center;
            align-items: center;
            color: #3b5bdb;
        }

        .error-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
            animation: fadeIn 0.5s ease-in-out;
        }

        .error-container i {
            font-size: 4rem;
            color: #ff4d4d; /* Rouge pour l'erreur */
            margin-bottom: 20px;
            animation: shake 0.5s infinite;
        }

        .error-container h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #3b5bdb; /* Bleu pour le titre */
            overflow: hidden; /* Cache le texte qui dépasse */
            white-space: nowrap; /* Empêche le texte de passer à la ligne */
            border-right: 2px solid #3b5bdb; /* Curseur de type machine à écrire */
            animation: typing 3s steps(40, end), blink-caret 0.75s step-end infinite;
        }

        .error-container p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #6a8dff; /* Bleu clair pour le texte */
            opacity: 0;
            animation: fadeInText 1s ease-in-out 3s forwards; /* Apparaît après l'animation du titre */
        }

        .error-container a {
            display: inline-block;
            background: linear-gradient(90deg, #3b5bdb, #6a8dff);
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
            opacity: 0;
            animation: fadeInText 1s ease-in-out 4s forwards; /* Apparaît après l'animation du texte */
        }

        .error-container a:hover {
            background: linear-gradient(90deg, #2a4cb3, #4f7dcd);
            transform: translateY(-2px);
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

        /* Animation de secousse pour l'icône */
        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }
            25% {
                transform: translateX(-5px);
            }
            75% {
                transform: translateX(5px);
            }
        }

        /* Animation de texte (machine à écrire) */
        @keyframes typing {
            from {
                width: 0;
            }
            to {
                width: 100%;
            }
        }

        /* Animation du curseur */
        @keyframes blink-caret {
            from, to {
                border-color: transparent;
            }
            50% {
                border-color: #3b5bdb;
            }
        }

        /* Animation pour faire apparaître le texte */
        @keyframes fadeInText {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-times-circle"></i> <!-- Icône d'erreur -->
        <h1>Erreur lors d'inscription</h1>
        <p>Votre inscription a échoué. Veuillez réessayer.</p>
        <a href="inscription.jsp">Retour à l'accueil</a>
    </div>
</body>
</html>