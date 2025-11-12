package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/UpdateMaintenanceServlet")
public class UpdateMaintenanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String residentIdParam = request.getParameter("resident_id");
        String chambreIdParam = request.getParameter("chambre_id");
        String description = request.getParameter("description");
        String categorie = request.getParameter("categorie");
        String statut = request.getParameter("statut");

        if (idParam == null || residentIdParam == null || chambreIdParam == null ||
                description == null || categorie == null || statut == null) {
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Paramètres manquants ou invalides");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            int residentId = Integer.parseInt(residentIdParam);
            int chambreId = Integer.parseInt(chambreIdParam);

            // Connexion à la base de données
            String url = "jdbc:mysql://localhost/residence_manager";
            String user = "root";
            String password = "root123@";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Mettre à jour la maintenance
            String sql = "UPDATE incidents SET resident_id=?, chambre_id=?, description=?, categorie=?, statut=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, residentId);
            pstmt.setInt(2, chambreId);
            pstmt.setString(3, description);
            pstmt.setString(4, categorie);
            pstmt.setString(5, statut);
            pstmt.setInt(6, id);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?successMessage=Requête de maintenance mise à jour avec succès");
            } else {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Requête de maintenance non trouvée");
            }

            // Fermeture des ressources
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Erreur lors de la mise à jour de la requête");
        }
    }
}