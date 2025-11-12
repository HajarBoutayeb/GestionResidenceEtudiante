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
import java.sql.SQLException;

@WebServlet("/modifierAdmin") // URL du servlet
public class ModifierAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Informations de connexion à la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/residence_manager";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root123@";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID de l'administrateur à modifier
        int id = Integer.parseInt(request.getParameter("id"));

        // Récupérer les informations de l'administrateur depuis la base de données
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT * FROM admin WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setId(rs.getInt("id"));
                    admin.setName(rs.getString("name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setPassword(rs.getString("password"));

                    // Passer l'objet admin à la JSP
                    request.setAttribute("admin", admin);
                    request.getRequestDispatcher("ModifierAdmin.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Administrateur non trouvé.");
                    request.getRequestDispatcher("erreur1.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur de base de données : " + e.getMessage());
            request.getRequestDispatcher("erreur1.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Valider les données
        if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("erreur1.jsp").forward(request, response);
            return;
        }

        // Mettre à jour l'administrateur dans la base de données
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "UPDATE admin SET name = ?, email = ?, password = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, password);
                pstmt.setInt(4, id);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la modification de l'administrateur : " + e.getMessage());
            request.getRequestDispatcher("erreur1.jsp").forward(request, response);
            return;
        }

        // Rediriger vers une page de confirmation
        response.sendRedirect("confirmation1.jsp");
    }
}