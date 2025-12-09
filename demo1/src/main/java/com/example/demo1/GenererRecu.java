package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import java.io.IOException;
import java.io.*;
import java.sql.*;
@WebServlet("/GenererRecu")
public class GenererRecu extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPaiementParam = request.getParameter("id");
        if (idPaiementParam == null || idPaiementParam.isEmpty()) {
            response.setContentType("text/plain");
            response.getWriter().write("Erreur : ID du paiement non fourni ou invalide.");
            return;
        }

        int idPaiement;
        try {
            idPaiement = Integer.parseInt(idPaiementParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("Erreur : ID du paiement doit être un entier valide.");
            return;
        }

        String url = "jdbc:mysql://localhost/residence_manager";
        String user = "root";
        String password = "root123@"; // Remplacez par votre mot de passe
        String driver = "com.mysql.cj.jdbc.Driver";

        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, user, password);
            String sql = "SELECT p.*, r.nom, r.prenom, c.id AS chambre_id " +
                    "FROM paiements p " +
                    "LEFT JOIN residents r ON p.resident_id = r.id " +
                    "LEFT JOIN chambres c ON r.chambre_id = c.id " +
                    "WHERE p.id = ?;";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idPaiement);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Création du document PDF
                PDDocument document = new PDDocument();
                PDPage page = new PDPage();
                document.addPage(page);

                PDPageContentStream contentStream = new PDPageContentStream(document, page);

                // Ajouter le logo
                ClassLoader classLoader = getClass().getClassLoader();
                PDImageXObject logo = PDImageXObject.createFromFile(
                        classLoader.getResource("images/b1.png").getPath(), document
                );
                contentStream.drawImage(logo, 50, 720, 100, 100); // Position et taille du logo

                // Titre centré
                contentStream.setFont(PDType1Font.HELVETICA_BOLD, 24);
                contentStream.beginText();
                contentStream.newLineAtOffset(220, 750);
                contentStream.showText("Reçu de Paiement");
                contentStream.endText();

                // Séparateur
                contentStream.moveTo(50, 700);
                contentStream.lineTo(550, 700);
                contentStream.stroke();

                // Affichage des informations dans une table
                contentStream.setFont(PDType1Font.HELVETICA, 12);
                int yPosition = 650;

                int tableStartX = 50; // Position X du début de la table
                int tableStartY = 650; // Position Y du début de la table
                int cellHeight = 20; // Hauteur d'une cellule
                int cellWidth = 500; // Largeur de la table
                int headerHeight = 25; // Hauteur des en-têtes

// Bordure externe de la table
                contentStream.setLineWidth(1);
                contentStream.moveTo(tableStartX, tableStartY); // Début de la table
                contentStream.lineTo(tableStartX + cellWidth, tableStartY); // Ligne horizontale supérieure
                contentStream.lineTo(tableStartX + cellWidth, tableStartY - (cellHeight * 8 + headerHeight)); // Ligne droite
                contentStream.lineTo(tableStartX, tableStartY - (cellHeight * 8 + headerHeight)); // Ligne inférieure
                contentStream.lineTo(tableStartX, tableStartY); // Ligne gauche pour fermer le rectangle
                contentStream.stroke();

// En-tête du tableau
                contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(tableStartX + 5, tableStartY - 15); // Position pour l'en-tête
                contentStream.showText("Reçu de Paiement - Informations");
                contentStream.endText();

// Lignes horizontales (pour cellules)
                int currentY = tableStartY - headerHeight; // Commence sous l'en-tête
                for (int i = 0; i <= 8; i++) { // 8 lignes pour les infos
                    contentStream.moveTo(tableStartX, currentY);
                    contentStream.lineTo(tableStartX + cellWidth, currentY);
                    contentStream.stroke();
                    currentY -= cellHeight;
                }

// Lignes verticales (pour colonnes)
                contentStream.moveTo(tableStartX, tableStartY);
                contentStream.lineTo(tableStartX, tableStartY - (cellHeight * 8 + headerHeight)); // Colonne gauche
                contentStream.stroke();

                contentStream.moveTo(tableStartX + cellWidth, tableStartY);
                contentStream.lineTo(tableStartX + cellWidth, tableStartY - (cellHeight * 8 + headerHeight)); // Colonne droite
                contentStream.stroke();

// Ajout des informations ligne par ligne
                contentStream.setFont(PDType1Font.HELVETICA, 10);
                int textY = tableStartY - headerHeight - 15; // Position Y initiale du texte
                contentStream.beginText();
                contentStream.newLineAtOffset(tableStartX + 5, textY);

// Lignes de données
                contentStream.showText("ID de Paiement : " + rs.getInt("id"));
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Nom : " + rs.getString("nom"));
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Prénom : " + rs.getString("prenom"));
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Chambre ID : " + rs.getString("chambre_id"));
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Montant dû : " + rs.getDouble("montant_due") + " MAD");
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Montant payé : " + rs.getDouble("montant_paye") + " MAD");
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Statut de paiement : " + rs.getString("statut"));
                textY -= cellHeight;
                contentStream.newLineAtOffset(0, -cellHeight);
                contentStream.showText("Date de Paiement : " + rs.getDate("date_paiement"));
                contentStream.endText();
                // Ajouter la signature
                PDImageXObject signature = PDImageXObject.createFromFile(
                        classLoader.getResource("images/b2.png").getPath(), document
                );
                contentStream.drawImage(signature, 400, 50, 150, 50); // Position et taille de la signature

                // Ajouter une note de bas de page
                contentStream.setFont(PDType1Font.HELVETICA_OBLIQUE, 10);
                contentStream.beginText();
                contentStream.newLineAtOffset(50, 40);
                contentStream.showText("Merci de conserver ce reçu comme preuve de paiement.");
                contentStream.endText();

                contentStream.close();

                // Envoyer le PDF comme réponse
                response.setContentType("application/pdf");
                document.save(response.getOutputStream());
                document.close();
            } else {
                response.getWriter().println("Aucun paiement trouvé pour l'ID: " + idPaiement);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erreur lors de la génération du reçu : " + e.getMessage());
        }
    }
}
