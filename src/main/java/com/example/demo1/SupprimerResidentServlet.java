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

@WebServlet("/SupprimerResidentServlet")
public class SupprimerResidentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID du résident à supprimer
        int idResident = Integer.parseInt(request.getParameter("id"));

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour supprimer le résident
            String sql = "DELETE FROM residents WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idResident);

            // Exécuter la requête
            pstmt.executeUpdate();

            // Fermer les ressources
            pstmt.close();
            conn.close();

            // Rediriger vers la page des résidents
            response.sendRedirect("indexResidents.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Rediriger avec un message d'erreur en cas d'échec
            response.sendRedirect("indexResidents.jsp?errorMessage=Erreur lors de la suppression du résident");
        }
    }
}