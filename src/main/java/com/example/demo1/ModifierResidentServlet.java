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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.UUID;

@WebServlet("/ModifierResidentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ModifierResidentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Répertoire où les fichiers seront stockés
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les autres champs du formulaire
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String CNE = request.getParameter("CNE");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");
        int chambreId = Integer.parseInt(request.getParameter("chambre_id"));
        String statut = request.getParameter("statut");

        // Récupérer le fichier téléchargé (s'il existe)
        Part filePart = request.getPart("carte_etudiant");
        String fileName = null;
        String relativeFilePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Un nouveau fichier a été téléchargé
            fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);

            // Chemin de destination pour enregistrer le fichier
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

            // Créer le répertoire de téléchargement s'il n'existe pas
            File fileSaveDir = new File(uploadFilePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }

            // Enregistrer le fichier
            String filePath = uploadFilePath + File.separator + fileName;
            filePart.write(filePath);

            // Chemin relatif pour stocker dans la base de données
            relativeFilePath = UPLOAD_DIR + File.separator + fileName;
        }

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour mettre à jour les données
            String sql;
            if (relativeFilePath != null) {
                // Si un nouveau fichier a été téléchargé, mettre à jour le chemin du fichier
                sql = "UPDATE residents SET nom=?, prenom=?, CNE=?, email=?, mot_de_passe=?, chambre_id=?, statut=?, carte_etudiant=? WHERE id=?";
            } else {
                // Si aucun fichier n'a été téléchargé, ne pas mettre à jour le champ carte_etudiant
                sql = "UPDATE residents SET nom=?, prenom=?, CNE=?, email=?, mot_de_passe=?, chambre_id=?, statut=? WHERE id=?";
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nom);
            pstmt.setString(2, prenom);
            pstmt.setString(3, CNE);
            pstmt.setString(4, email);
            pstmt.setString(5, motDePasse);
            pstmt.setInt(6, chambreId);
            pstmt.setString(7, statut);

            if (relativeFilePath != null) {
                pstmt.setString(8, relativeFilePath);
                pstmt.setInt(9, id);
            } else {
                pstmt.setInt(8, id);
            }

            // Exécuter la requête
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            // Rediriger vers la liste des résidents
            response.sendRedirect("indexResidents.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Rediriger vers une page d'erreur en cas d'échec
        }
    }

    // Méthode pour extraire le nom du fichier
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}