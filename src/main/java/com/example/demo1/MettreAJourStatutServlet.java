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

@WebServlet("/MettreAJourStatutServlet")
public class MettreAJourStatutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int incidentId = Integer.parseInt(request.getParameter("incident_id"));
        String statut = request.getParameter("statut");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour mettre à jour le statut
            String sql = "UPDATE incidents SET statut = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, statut);
            pstmt.setInt(2, incidentId);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}