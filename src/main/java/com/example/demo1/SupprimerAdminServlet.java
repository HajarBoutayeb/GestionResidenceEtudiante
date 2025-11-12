package com.example.demo1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SupprimerAdminServlet")
public class SupprimerAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer l'ID de l'administrateur à supprimer
        int id = Integer.parseInt(request.getParameter("id"));

        // Connexion à la base de données
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Charger le pilote JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour supprimer l'administrateur
            String sql = "DELETE FROM admin WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            // Exécuter la requête
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                // Rediriger vers la page d'accueil des administrateurs
                response.sendRedirect("listeAdmin.jsp");
            } else {
                // Afficher un message d'erreur si la suppression a échoué
                response.getWriter().println("Échec de la suppression de l'administrateur.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la suppression de l'administrateur : " + e.getMessage());
        } finally {
            // Fermer les ressources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}