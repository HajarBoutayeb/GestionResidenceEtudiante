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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ListeTechniciensServlet")
public class ListeTechniciensServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Technicien> techniciens = new ArrayList<>();

        try {
            // Charger le pilote JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion à la base de données
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");
            System.out.println("Connexion à la base de données réussie !");

            // Requête SQL pour récupérer tous les techniciens
            String sql = "SELECT * FROM techniciens";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            // Parcourir les résultats et les ajouter à la liste
            while (rs.next()) {
                Technicien technicien = new Technicien();
                technicien.setId(rs.getInt("id"));
                technicien.setNom(rs.getString("nom"));
                technicien.setEmail(rs.getString("email"));
                technicien.setMotDePasse(rs.getString("mot_de_passe"));
                technicien.setTelephone(rs.getString("telephone"));
                technicien.setSpecialite(rs.getString("specialite"));
                technicien.setActif(rs.getBoolean("actif")); // Récupérer le statut actif
                techniciens.add(technicien);
            }

            // Ajouter un log pour vérifier le nombre de techniciens récupérés
            System.out.println("Nombre de techniciens récupérés : " + techniciens.size());

            // Fermer les ressources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la récupération des techniciens : " + e.getMessage());
        }

        // Ajouter la liste des techniciens à l'objet request
        request.setAttribute("techniciens", techniciens);

        // Rediriger vers la JSP
        request.getRequestDispatcher("indexTechniciens.jsp").forward(request, response);
    }
}