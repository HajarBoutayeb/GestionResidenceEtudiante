package com.example.demo1;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

@WebServlet("/EnvoyerRappel")
public class EnvoieRappelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configuration de la réponse en JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Récupérer l'ID du paiement depuis la requête
        String idPaiementStr = request.getParameter("id");

        // Vérifier si le paramètre est manquant ou vide
        if (idPaiementStr == null || idPaiementStr.isEmpty()) {
            out.print("{\"status\":\"error\", \"message\":\"Le paramètre 'id' est manquant ou vide.\"}");
            return;
        }

        // Convertir l'ID du paiement en entier
        int idPaiement;
        try {
            idPaiement = Integer.parseInt(idPaiementStr);
        } catch (NumberFormatException e) {
            out.print("{\"status\":\"error\", \"message\":\"Le paramètre 'id' n'est pas un nombre valide.\"}");
            return;
        }

        // Variables pour stocker les informations
        String emailResident = null;
        String nomResident = null;
        String prenomResident = null;
        double montantPaye = 0.0;
        double montantDue = 0.0;

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Récupérer l'e-mail du résident et les détails du paiement
            String sql = "SELECT r.email, r.nom, r.prenom, p.montant_paye, p.montant_due " +
                    "FROM paiements p " +
                    "JOIN residents r ON p.resident_id = r.id " +
                    "WHERE p.id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idPaiement);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                emailResident = rs.getString("email");
                nomResident = rs.getString("nom");
                prenomResident = rs.getString("prenom");
                montantPaye = rs.getDouble("montant_paye");
                montantDue = rs.getDouble("montant_due");
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Aucun paiement trouvé avec l'ID " + idPaiement + ".\"}");
                conn.close();
                return;
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Erreur lors de la récupération des informations du résident : " + e.getMessage() + "\"}");
            return;
        }

        // Envoyer l'e-mail de rappel
        if (emailResident != null) {
            String host = "smtp.gmail.com"; // Serveur SMTP (exemple : Gmail)
            String from = "hajarboutayeb5@gmail.com"; // Votre adresse e-mail
            String password = "rarw jobo zdvj tvgt"; // Votre mot de passe ou mot de passe d'application
            String subject = "Rappel de paiement";
            String body = "Bonjour " + prenomResident + " " + nomResident + ",\n\n" +
                    "Ceci est un rappel concernant votre paiement.\n" +
                    "Montant dû : " + montantDue + " €\n" +
                    "Montant déjà payé : " + montantPaye + " €\n" +
                    "Merci de régulariser votre situation dès que possible.\n\n" +
                    "Cordialement,\nL'équipe de gestion des résidences.";

            // Propriétés pour la configuration SMTP
            Properties properties = new Properties();
            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", "587"); // Port SMTP pour TLS
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true"); // Activer TLS

            // Créer une session avec authentification
            Session mailSession = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

            try {
                // Créer un message e-mail
                MimeMessage message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(from));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(emailResident));
                message.setSubject(subject);
                message.setText(body);

                // Envoyer l'e-mail
                Transport.send(message);
                out.print("{\"status\":\"success\", \"message\":\"Rappel envoyé avec succès à " + emailResident + ".\"}");
            } catch (MessagingException e) {
                e.printStackTrace();
                out.print("{\"status\":\"error\", \"message\":\"Erreur lors de l'envoi du rappel : " + e.getMessage() + "\"}");
            }
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Aucun e-mail trouvé pour ce paiement.\"}");
        }
    }
}