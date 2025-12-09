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

@WebServlet("/ModifierPaiementServlet")
public class ModifierPaiementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer les données du formulaire
        String id = request.getParameter("id");
        int residentId = Integer.parseInt(request.getParameter("residentId"));
        double montantDue = Double.parseDouble(request.getParameter("montantDue"));
        double montantPaye = Double.parseDouble(request.getParameter("montantPaye"));
        String datePaiement = request.getParameter("datePaiement");
        String modePaiement = request.getParameter("modePaiement");
        String statut = request.getParameter("statut");
        String commentaire = request.getParameter("commentaire");

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Requête SQL pour mettre à jour le paiement
            String sql = "UPDATE paiements SET resident_id = ?, montant_due = ?, montant_paye = ?, date_paiement = ?, mode_paiement = ?, statut = ?, commentaire = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, residentId);
            pstmt.setDouble(2, montantDue);
            pstmt.setDouble(3, montantPaye);
            pstmt.setString(4, datePaiement);
            pstmt.setString(5, modePaiement);
            pstmt.setString(6, statut);
            pstmt.setString(7, commentaire);
            pstmt.setInt(8, Integer.parseInt(id));

            // Exécuter la requête
            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("paiement.jsp"); // Rediriger vers la liste des paiements
            } else {
                response.getWriter().println("Erreur : Aucun paiement trouvé avec l'ID " + id);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la mise à jour du paiement : " + e.getMessage());
        }
    }
}