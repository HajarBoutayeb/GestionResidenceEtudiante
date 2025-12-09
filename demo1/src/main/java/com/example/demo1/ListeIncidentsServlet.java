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

@WebServlet("/ListeIncidentsServlet")
public class ListeIncidentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Incident> incidents = new ArrayList<>();

        try {
            // Charger le pilote JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion à la base de données
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour récupérer tous les incidents
            String sql = "SELECT * FROM incidents";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            // Parcourir les résultats et les ajouter à la liste
            while (rs.next()) {
                Incident incident = new Incident();
                incident.setId(rs.getInt("id"));
                incident.setResidentId(rs.getInt("resident_id"));
                incident.setChambreId(rs.getInt("chambre_id"));
                incident.setDescription(rs.getString("description"));
                incident.setCategorie(rs.getString("categorie"));
                incident.setDateSignalement(rs.getDate("date_signalement"));
                incident.setStatut(rs.getString("statut"));
                incident.setTechnicienAssigne(rs.getInt("technicien_assigne"));
                incident.setDateResolution(rs.getDate("date_resolution"));
                incident.setCommentaireResolution(rs.getString("commentaire_resolution"));
                incidents.add(incident);
            }

            // Fermer les ressources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Ajouter la liste des incidents à l'objet request
        request.setAttribute("incidents", incidents);

        // Rediriger vers la JSP
        request.getRequestDispatcher("listeIncidents.jsp").forward(request, response);
    }
}