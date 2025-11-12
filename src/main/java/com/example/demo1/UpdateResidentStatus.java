package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/UpdateResidentStatus")
public class UpdateResidentStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        String email = request.getParameter("email"); // E-mail du résident
        String nom = request.getParameter("nom"); // Nom du résident
        String prenom = request.getParameter("prenom"); // Prénom du résident

        // Logs pour débogage
        System.out.println("ID : " + id);
        System.out.println("Action : " + action);
        System.out.println("E-mail : " + email);
        System.out.println("Nom : " + nom);
        System.out.println("Prénom : " + prenom);

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
            String sql = "UPDATE residents SET statut = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            if ("valider".equals(action)) {
                pstmt.setString(1, "actif");
                sendEmail(email, nom, prenom, "Votre demande a été acceptée",
                        "Nous sommes heureux de vous informer que votre demande d'inscription à StudentSpace a été acceptée.<br>"
                                + "Vous pouvez maintenant accéder à votre espace résident.");
            } else if ("rejeter".equals(action)) {
                pstmt.setString(1, "parti");
                sendEmail(email, nom, prenom, "Votre demande a été rejetée",
                        "Nous regrettons de vous informer que votre demande d'inscription à StudentSpace a été rejetée.<br>"
                                + "Pour plus d'informations, veuillez contacter l'administration.");
            }

            pstmt.setString(2, id);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Rediriger vers la page des demandes d'inscription
        response.sendRedirect("ajouter-rejeter-residents.jsp");
    }

    // Méthode pour envoyer un e-mail personnalisé
    private void sendEmail(String toEmail, String nom, String prenom, String subject, String body) {
        final String username = "hajarboutayeb5@gmail.com"; // Remplacez par votre adresse e-mail
        final String password = "rarw jobo zdvj tvgt"; // Remplacez par votre mot de passe

        // Configuration des propriétés pour Jakarta Mail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Serveur SMTP de Gmail
        props.put("mail.smtp.port", "587"); // Port SMTP de Gmail

        // Créer une session Jakarta Mail
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Créer un message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // Personnaliser le corps du message en HTML
            String messageBody = "<html>"
                    + "<body>"
                    + "<p>Bonjour " + nom + " " + prenom + ",</p>"
                    + "<p>" + body + "</p>"
                    + "<p>Date : " + new java.util.Date() + "</p>"
                    + "<p>Cordialement,<br>L'équipe de StudentSpace</p>"
                    + "</body>"
                    + "</html>";

            // Définir le contenu du message comme HTML
            message.setContent(messageBody, "text/html");

            // Envoyer le message
            Transport.send(message);
            System.out.println("E-mail envoyé avec succès à " + toEmail);
        } catch (MessagingException e) {
            throw new RuntimeException("Erreur lors de l'envoi de l'e-mail", e);
        }
    }
}