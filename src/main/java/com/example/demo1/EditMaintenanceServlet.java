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
import java.sql.ResultSet;

@WebServlet("/EditMaintenanceServlet") // Chemin de la servlet
public class EditMaintenanceServlet extends HttpServlet {
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

            // Récupérer les détails de la maintenance
            String sql = "SELECT * FROM incidents WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Stocker les détails dans la requête pour les afficher dans le formulaire
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("resident_id", rs.getInt("resident_id"));
                request.setAttribute("chambre_id", rs.getInt("chambre_id"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("categorie", rs.getString("categorie"));
                request.setAttribute("statut", rs.getString("statut"));

                // Rediriger vers une page JSP pour afficher le formulaire de modification
                request.getRequestDispatcher("/editMaintenance.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Requête de maintenance non trouvée");
            }

            // Fermeture des ressources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp?errorMessage=Erreur lors de la récupération des détails");
        }
    }
}