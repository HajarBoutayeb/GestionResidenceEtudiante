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

@WebServlet("/DeleteMaintenanceServlet")
public class DeleteMaintenanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=ID de maintenance manquant");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            // Connexion à la base de données
            String url = "jdbc:mysql://localhost/residence_manager";
            String user = "root";
            String password = "root123@";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Supprimer la maintenance
            String sql = "DELETE FROM incidents WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?successMessage=Requête de maintenance supprimée avec succès");
            } else {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Requête de maintenance non trouvée");
            }

            // Fermeture des ressources
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Erreur lors de la suppression de la requête");
        }
    }
}