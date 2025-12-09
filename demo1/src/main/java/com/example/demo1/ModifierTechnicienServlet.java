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

@WebServlet("/ModifierTechnicienServlet")
public class ModifierTechnicienServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");
        String telephone = request.getParameter("telephone");
        String specialite = request.getParameter("specialite");

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour mettre à jour le technicien
            String sql = "UPDATE techniciens SET nom = ?, email = ?, mot_de_passe = ?, telephone = ?, specialite = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nom);
            pstmt.setString(2, email);
            pstmt.setString(3, motDePasse);
            pstmt.setString(4, telephone);
            pstmt.setString(5, specialite);
            pstmt.setInt(6, id);

            // Exécution de la requête
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            // Rediriger vers la liste des techniciens après la modification
            response.sendRedirect("ListeTechniciensServlet");
        } catch (Exception e) {
            e.printStackTrace();
            // Rediriger vers une page d'erreur en cas d'échec
            response.sendRedirect("error.jsp");
        }
    }
}