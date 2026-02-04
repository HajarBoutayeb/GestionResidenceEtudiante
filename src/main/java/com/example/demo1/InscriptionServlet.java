package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/InscriptionServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Remplacez ces valeurs par les informations de votre base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/residence_manager";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root123@";

    // Dossier où les fichiers uploadés seront stockés
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer les données du formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String cne = request.getParameter("cne");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");

        // Récupérer le fichier uploadé
        Part filePart = request.getPart("carte_etudiant");
        String fileName = filePart.getSubmittedFileName();

        // Chemin absolu du dossier d'upload
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Créer le dossier s'il n'existe pas
        }

        // Sauvegarder le fichier sur le serveur
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Enregistrer les données dans la base de données
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO residents (nom, prenom, cne, email, mot_de_passe, carte_etudiant) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nom);
                stmt.setString(2, prenom);
                stmt.setString(3, cne);
                stmt.setString(4, email);
                stmt.setString(5, motDePasse);
                stmt.setString(6, fileName); // Enregistrer le nom du fichier

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    // Rediriger vers une page de succès
                    response.sendRedirect("inscription_succes.jsp");
                } else {
                    // Rediriger vers une page d'erreur
                    response.sendRedirect("inscription_erreur.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("inscription_erreur.jsp");
        }
    }
}