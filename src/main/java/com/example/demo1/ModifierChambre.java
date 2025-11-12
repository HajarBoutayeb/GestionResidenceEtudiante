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

@WebServlet("/ModifierChambre")
public class ModifierChambre extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        int idChambre = Integer.parseInt(request.getParameter("id"));
        String numeroChambre = request.getParameter("numero_chambre");
        String taille = request.getParameter("taille");
        String equipements = request.getParameter("equipements");
        String statut = request.getParameter("statut");
        double prixMensuel = Double.parseDouble(request.getParameter("prix_mensuel"));
        int etage = Integer.parseInt(request.getParameter("etage"));
        String description = request.getParameter("description");

        // Connexion à la base de données et mise à jour
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            String sql = "UPDATE chambres SET numero_chambre = ?, taille = ?, equipements = ?, statut = ?, prix_mensuel = ?, etage = ?, description = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, numeroChambre);
            pstmt.setString(2, taille);
            pstmt.setString(3, equipements);
            pstmt.setString(4, statut);
            pstmt.setDouble(5, prixMensuel);
            pstmt.setInt(6, etage);
            pstmt.setString(7, description);
            pstmt.setInt(8, idChambre);

            pstmt.executeUpdate(); // Exécuter la mise à jour
            conn.close(); // Fermer la connexion

            // Rediriger vers la liste des chambres après la modification
            response.sendRedirect("index1.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // En cas d'erreur, rediriger vers une page d'erreur
            response.sendRedirect("error.jsp");
        }
    }
}