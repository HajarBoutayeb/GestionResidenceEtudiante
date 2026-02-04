package com.example.demo1;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/loginResident")
public class LoginResidentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@")) {
            String sql = "SELECT * FROM residents WHERE email = ? AND mot_de_passe = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, motDePasse);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Connexion réussie : définir l'attribut `email` dans la session
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("id", rs.getInt("id"));
                    response.sendRedirect("profile.jsp"); // Rediriger vers la page de profil
                } else {
                    // Connexion échouée : rediriger vers la page de connexion avec un message d'erreur
                    response.sendRedirect("loginResident.jsp?error=1");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("loginResident.jsp?error=2");
        }
    }
}