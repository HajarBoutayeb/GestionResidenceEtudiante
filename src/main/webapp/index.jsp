<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Résidence Étudiante</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@600&display=swap" rel="stylesheet">
    <!-- Lien vers Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Réinitialisation */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Corps principal */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            line-height: 1.6;
        }

        h1, h2, h3 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        h1 {
            font-size: 2.8rem;
            margin-bottom: 1rem;
        }

        h2 {
            font-size: 2.2rem;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
        }

        /* Barre de navigation */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background: linear-gradient(to right, #3b5bdb, #6a8dff);
            color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo {
            height: 50px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffd700;
        }

        .nav-links a i {
            font-size: 1.2rem;
        }

        /* Première section */
        .section-one {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 4rem 2rem;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            color: #fff;
        }

        .left-content {
            max-width: 50%;
        }

        .left-content h1 {
            font-size: 2.8rem;
            margin-bottom: 1.5rem;
        }

        .left-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        .start-button {
            padding: 1rem 2rem;
            background-color: #fff;
            color: #3b5bdb;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .start-button:hover {
            background-color: #8f94fb;
            color: #fff;
            transform: translateY(-3px);
        }

        .right-content img {
            width: 450px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        /* Deuxième section */
        .section-two {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 4rem 2rem;
            background: #fff;
        }

        .section-two .image-left img {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .section-two .text-right {
            max-width: 50%;
        }

        .section-two h2 {
            font-size: 2.2rem;
            margin-bottom: 1.5rem;
        }

        .section-two p {
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* Section services */
        .section-three {
            text-align: center;
            padding: 4rem 2rem;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            color: #fff;
        }

        .section-three h2 {
            font-size: 2.2rem;
            margin-bottom: 2rem;
        }

        .service-images {
            display: flex;
            justify-content: center;
            gap: 2rem;
        }

        .service-images img {
            width: 250px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .service-images img:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }

        /* Quatrième section */
        .section-four {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 4rem 2rem;
            background: #fff;
        }

        .section-four .image-left img {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .section-four .text-right {
            max-width: 50%;
        }

        .section-four h2 {
            font-size: 2.2rem;
            margin-bottom: 1.5rem;
        }

        .section-four p {
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* Cinquième section */
        .section-five {
            text-align: center;
            padding: 4rem 2rem;
            background: linear-gradient(to right, #6a8dff, #3b5bdb);
            color: #fff;
        }

        .section-five .content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-five .left-content,
        .section-five .center-content,
        .section-five .right-content {
            flex: 1;
            margin: 1rem;
        }

        .section-five img {
            width: 80px;
            margin-bottom: 1rem;
        }

        .section-five a {
            display: block;
            color: #fff;
            margin-top: 0.5rem;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .section-five a:hover {
            color: #ffd700;
        }
    </style>
</head>
<body>
<!-- Barre de navigation -->
<header class="navbar">
    <div class="logo-section">
        <img src="images/logo.png" alt="Logo Gestion de Résidence" class="logo">
        <span>StudentSpace</span>
    </div>
    <nav class="nav-links">
        <a href="index.jsp">Accueil</a>
        <a href="login.html">
            <i class="fas fa-user-shield"></i> <!-- Icône Admin -->
            Connexion Admin
        </a>
        <a href="loginResident.jsp">
            <i class="fas fa-user"></i> <!-- Icône Résident -->
            Connexion Resident
        </a>
    </nav>
</header>

<!-- Première section -->
<section class="section-one">
    <div class="left-content">
        <h1>Bienvenue sur Gestion de Résidence Étudiante</h1>
        <p>Gérez vos résidences étudiantes efficacement avec notre plateforme intuitive et moderne.</p>
        <button class="start-button" onclick="window.location.href='inscription.jsp'">Commencez maintenant</button>
    </div>
    <div class="right-content">
        <img src="images/b1.png" alt="Illustration Résidence">
    </div>
</section>

<!-- Deuxième section -->
<section class="section-two">
    <div class="image-left">
        <img src="images/b3.png" alt="Illustration Pourquoi choisir">
    </div>
    <div class="text-right">
        <h2>Pourquoi choisir notre plateforme ?</h2>
        <p>Notre solution simplifie la gestion des locataires, le suivi des paiements et la génération de rapports détaillés, le tout dans une interface intuitive.</p>
    </div>
</section>

<!-- Section services -->
<section class="section-three">
    <h2>Nos Services</h2>
    <div class="service-images">
        <img src="images/cham1.jpg" alt="Service 1">
        <img src="images/chm3.jpg" alt="Service 2">
        <img src="images/chmr2.jpg" alt="Service 3">
    </div>
</section>

<!-- Quatrième section -->
<section class="section-four">
    <div class="image-left">
        <img src="images/b2.png" alt="Optimisation de la gestion">
    </div>
    <div class="text-right">
        <h2>Optimisez votre gestion</h2>
        <p>Découvrez des fonctionnalités avancées pour gérer vos résidences en toute simplicité, grâce à une interface innovante et facile à utiliser.</p>
    </div>
</section>

<!-- Cinquième section -->
<section class="section-five">
    <div class="content">
        <div class="left-content">
            <p>© 2024 Gestion de Résidence Étudiante</p>
            <p>Votre partenaire dans la gestion immobilière étudiante.</p>
        </div>
        <div class="center-content">
            <img src="images/logo.png" alt="Logo">
            <h2>StudentSpace</h2>
        </div>
        <div class="right-content">
            <a href="#">À propos</a>
            <a href="#">Contact</a>
            <a href="#">FAQ</a>
        </div>
    </div>
</section>
</body>
</html>