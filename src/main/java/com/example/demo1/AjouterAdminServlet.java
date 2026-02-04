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
import java.sql.SQLException;

@WebServlet("/ajouterAdmin")
public class AjouterAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Informations de connexion à la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/residence_manager";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root123@";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Mot de passe en texte brut

        // Insérer l'administrateur dans la base de données
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO admin (name, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, password); // Stocker le mot de passe en texte brut
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Gérer l'erreur (par exemple, rediriger vers une page d'erreur)
            response.sendRedirect("erreur.jsp");
            return;
        }

        // Rediriger vers une page de confirmation
        response.sendRedirect("confirmation.jsp");
    }
}