<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription r�ussie</title>
    <!-- Lien vers Font Awesome pour les ic�nes -->
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

        .success-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
            animation: fadeIn 0.5s ease-in-out;
        }

        .success-container i {
            font-size: 4rem;
            color: #4caf50; /* Vert pour le succ�s */
            margin-bottom: 20px;
            animation: bounce 1s infinite;
        }

        .success-container h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #3b5bdb;
            overflow: hidden; /* Cache le texte qui d�passe */
            white-space: nowrap; /* Emp�che le texte de passer � la ligne */
            border-right: 2px solid #3b5bdb; /* Curseur de type machine � �crire */
            animation: typing 3s steps(40, end), blink-caret 0.75s step-end infinite;
        }

        .success-container p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #6a8dff;
            opacity: 0;
            animation: fadeInText 1s ease-in-out 3s forwards; /* Appara�t apr�s l'animation du titre */
        }

        .success-container a {
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
            animation: fadeInText 1s ease-in-out 4s forwards; /* Appara�t apr�s l'animation du texte */
        }

        .success-container a:hover {
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

        /* Animation de rebond pour l'ic�ne */
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        /* Animation de texte (machine � �crire) */
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

        /* Animation pour faire appara�tre le texte */
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
    <div class="success-container">
        <i class="fas fa-check-circle"></i> <!-- Ic�ne de succ�s -->
        <h1>Inscription reussie !</h1>
        <p>Attendez que l'administrateur valide votre demande.</p>
        <a href="index.jsp">Se connecter</a>
    </div>
</body>
</html>