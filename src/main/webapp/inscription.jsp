<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <!-- Lien vers Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reset des styles par défaut */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Style général de la page */
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4ff; /* Fond bleu clair */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* Conteneur du formulaire */
        .form-container {
            background: #ffffff;
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px; /* Largeur augmentée pour accueillir les champs côte à côte */
            animation: slideIn 0.5s ease-in-out;
        }

        /* Titre du formulaire */
        .form-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 2rem;
            color: #3b5bdb;
            font-weight: 600;
            overflow: hidden; /* Cache le texte qui dépasse */
            white-space: nowrap; /* Empêche le texte de passer à la ligne */
            border-right: 2px solid #3b5bdb; /* Curseur de type machine à écrire */
            animation: typing 3s steps(40, end), blink-caret 0.75s step-end infinite;
        }

        /* Style des labels */
        .form-container label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #555;
            font-size: 0.9rem;
            cursor: pointer; /* Curseur pointer pour indiquer que le label est cliquable */
        }

        /* Style des champs de saisie */
        .form-container .input-group {
            position: relative;
            margin-bottom: 1.2rem;
        }

        .form-container .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #3b5bdb; /* Couleur des icônes */
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"],
        .form-container input[type="file"] {
            width: 100%;
            padding: 0.8rem 0.8rem 0.8rem 2.5rem; /* Ajout de padding à gauche pour l'icône */
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f9f9f9;
        }

        .form-container input[type="text"]:focus,
        .form-container input[type="email"]:focus,
        .form-container input[type="password"]:focus,
        .form-container input[type="file"]:focus {
            border-color: #3b5bdb;
            outline: none;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(59, 91, 219, 0.1);
        }

        /* Placeholder stylisé */
        .form-container input::placeholder {
            color: #999;
            font-size: 0.9rem;
        }

        /* Changement de couleur des icônes au focus */
        .form-container .input-group:focus-within i {
            color: #6a8dff; /* Couleur des icônes au focus */
        }

        /* Style du bouton de soumission */
        .form-container button {
            width: 100%;
            padding: 12px 24px;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, background 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-container button:hover {
            background: linear-gradient(to right, #3b5bdb, #6a8dff);
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        /* Style pour le champ de fichier */
        .form-container input[type="file"] {
            padding: 0.6rem;
            background: #f9f9f9;
            border: 1px dashed #e0e0e0;
            text-align: center;
            color: #777;
        }

        .form-container input[type="file"]::file-selector-button {
            background: #3b5bdb;
            color: #fff;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .form-container input[type="file"]::file-selector-button:hover {
            background: #6a8dff;
        }

        /* Animation d'apparition */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
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

        /* Mise en page pour les champs côte à côte */
        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .form-container {
                padding: 1.5rem;
                max-width: 90%;
            }

            .form-container h2 {
                font-size: 1.5rem;
            }

            .form-container input[type="text"],
            .form-container input[type="email"],
            .form-container input[type="password"],
            .form-container input[type="file"] {
                padding: 0.7rem 0.7rem 0.7rem 2.2rem; /* Ajustement pour les petits écrans */
            }

            .form-container button {
                padding: 0.7rem;
            }
        }
    </style>
    <script>
        // Fonction de validation du formulaire
        function validateForm() {
            const motDePasse = document.getElementById("mot_de_passe").value;

            // Validation du mot de passe
            if (motDePasse.length < 6) {
                alert("Le mot de passe doit contenir au moins 6 caractères.");
                return false;
            }

            const email = document.getElementById("email").value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Validation de l'email
            if (!emailPattern.test(email)) {
                alert("Veuillez entrer une adresse email valide.");
                return false;
            }

            // Si tout est valide, le formulaire est soumis
            return true;
        }
    </script>
</head>
<body>
    <div class="form-container">
        <form action="InscriptionServlet" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
            <h2>Formulaire d'inscription</h2>

            <!-- Ligne pour Nom et Prénom -->
            <div class="form-row">
                <div class="form-group">
                    <label for="nom">Nom:</label>
                    <div class="input-group">
                        <i class="fas fa-user"></i>
                        <input type="text" id="nom" name="nom" placeholder="Entrez votre nom" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="prenom">Prénom:</label>
                    <div class="input-group">
                        <i class="fas fa-user"></i>
                        <input type="text" id="prenom" name="prenom" placeholder="Entrez votre prénom" required>
                    </div>
                </div>
            </div>

            <!-- Ligne pour CNE et Email -->
            <div class="form-row">
                <div class="form-group">
                    <label for="cne">CNE:</label>
                    <div class="input-group">
                        <i class="fas fa-id-card"></i>
                        <input type="text" id="cne" name="cne" placeholder="Entrez votre CNE" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <div class="input-group">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Entrez votre email" required>
                    </div>
                </div>
            </div>

            <!-- Ligne pour Mot de passe et Carte d'étudiant -->
            <div class="form-row">
                <div class="form-group">
                    <label for="mot_de_passe">Mot de passe:</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="mot_de_passe" name="mot_de_passe" placeholder="Entrez votre mot de passe" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="carte_etudiant">Carte d'étudiant (PDF):</label>
                    <div class="input-group">
                        <i class="fas fa-file-pdf"></i>
                        <input type="file" id="carte_etudiant" name="carte_etudiant" accept=".pdf">
                    </div>
                </div>
            </div>

            <!-- Bouton de soumission -->
            <button type="submit">S'inscrire</button>
        </form>
    </div>
</body>
</html>