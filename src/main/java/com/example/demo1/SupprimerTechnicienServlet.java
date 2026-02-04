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

@WebServlet("/SupprimerTechnicienServlet")
public class SupprimerTechnicienServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID du technicien à supprimer
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            // Charger le pilote JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion à la base de données
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour supprimer le technicien
            String sql = "DELETE FROM techniciens WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            // Exécuter la requête
            pstmt.executeUpdate();

            // Fermer les ressources
            pstmt.close();
            conn.close();

            // Rediriger vers la liste des techniciens après la suppression
            response.sendRedirect("ListeTechniciensServlet");
        } catch (Exception e) {
            e.printStackTrace();
            // En cas d'erreur, rediriger vers une page d'erreur
            response.sendRedirect("error.jsp");
        }
    }
}