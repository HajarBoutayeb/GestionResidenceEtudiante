 package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/GenererRecuServlet")
public class servlet_generration extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer l'ID du paiement depuis la requête
        int idPaiement = Integer.parseInt(request.getParameter("id_paiement"));

        // Variables pour stocker les informations
        int idEtudiant = 0;
        String nom = null;
        String prenom = null;
        double montantPaye = 0.0;
        String datePaiement = null;
        String statutPaiement = null;

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Récupérer les détails du paiement
            String sql = "SELECT p.id_etudiant, r.nom, r.prenom, p.montant_paye, p.date_paiement, p.statut_paiement " +
                    "FROM paiements p " +
                    "JOIN residents r ON p.id_etudiant = r.id " +
                    "WHERE p.id_paiement = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idPaiement);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                idEtudiant = rs.getInt("id_etudiant");
                nom = rs.getString("nom");
                prenom = rs.getString("prenom");
                montantPaye = rs.getDouble("montant_paye");
                datePaiement = rs.getString("date_paiement");
                statutPaiement = rs.getString("statut_paiement");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la récupération des informations du paiement.");
            return;
        }

        // Générer le PDF
        try {
            String filePath = "recu_paiement_" + idPaiement + ".pdf";
            PdfGenerator.generatePdf(idPaiement, idEtudiant, nom, prenom, montantPaye, datePaiement, statutPaiement, filePath);

            // Envoyer le fichier PDF en réponse
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filePath + "\"");
            Files.copy(Paths.get(filePath), response.getOutputStream());

            // Supprimer le fichier après envoi (optionnel)
            Files.delete(Paths.get(filePath));
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la génération du reçu.");
        }
    }
}