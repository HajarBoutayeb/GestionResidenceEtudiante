package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

@WebServlet("/MaintenanceServlet")
public class MaintenanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres du formulaire
        String residentIdParam = request.getParameter("resident_id");
        String chambreIdParam = request.getParameter("chambre_id");
        String description = request.getParameter("description");
        String categorie = request.getParameter("categorie");

        // Vérifier les paramètres obligatoires
        if (residentIdParam == null || chambreIdParam == null || description == null || categorie == null) {
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Paramètres manquants ou invalides");
            return;
        }

        try {
            // Convertir les paramètres en entiers
            int residentId = Integer.parseInt(residentIdParam);
            int chambreId = Integer.parseInt(chambreIdParam);

            // Connexion à la base de données
            String url = "jdbc:mysql://localhost/residence_manager";
            String user = "root";
            String password = "root123@";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Requête SQL pour insérer un nouvel incident
            String sql = "INSERT INTO incidents (resident_id, chambre_id, description, categorie, date_signalement, statut) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, residentId);
            pstmt.setInt(2, chambreId);
            pstmt.setString(3, description);
            pstmt.setString(4, categorie);
            pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis())); // Date actuelle
            pstmt.setString(6, "en attente"); // Statut par défaut

            // Exécution de la requête
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?successMessage=Requête de maintenance soumise avec succès");
            } else {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Erreur lors de la soumission de la requête");
            }

            // Fermeture des ressources
            pstmt.close();
            conn.close();
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Paramètres invalides");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Erreur lors de la soumission de la requête");
        }
    }
}