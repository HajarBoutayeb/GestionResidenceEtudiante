package com.example.demo1;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String email = (String) request.getSession().getAttribute("email");
        String newEmail = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");

        // Mettre à jour les informations dans la base de données
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@")) {
            String sql = "UPDATE residents SET email = ?, mot_de_passe = ? WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newEmail);
                stmt.setString(2, motDePasse);
                stmt.setString(3, email);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Mettre à jour l'email dans la session si nécessaire
        if (!email.equals(newEmail)) {
            request.getSession().setAttribute("email", newEmail);
        }

        // Rediriger vers la page de profil
        response.sendRedirect("profile.jsp");
    }
}