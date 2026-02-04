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

@WebServlet("/AjouterPaiementServlet")
public class AjouterPaiementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres du formulaire
        int residentId = Integer.parseInt(request.getParameter("resident_id"));
        double montantDue = Double.parseDouble(request.getParameter("montant_due"));
        double montantPaye = Double.parseDouble(request.getParameter("montant_paye"));
        String modePaiement = request.getParameter("mode_paiement");
        String commentaire = request.getParameter("commentaire");

        // Statut par défaut à 'En attente'
        String statut = "En attente";

        // Informations de connexion à la base de données
        String url = "jdbc:mysql://localhost/residence_manager";
        String user = "root";
        String password = "root123@";

        try {
            // Charger le pilote JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion à la base de données
            try (Connection con = DriverManager.getConnection(url, user, password)) {
                // Requête SQL pour insérer un nouveau paiement
                String sql = "INSERT INTO paiements (resident_id, montant_due, montant_paye, mode_paiement, statut, commentaire) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";

                // Préparer la requête
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, residentId);
                    ps.setDouble(2, montantDue);
                    ps.setDouble(3, montantPaye);
                    ps.setString(4, modePaiement);
                    ps.setString(5, statut);
                    ps.setString(6, commentaire);

                    // Exécuter la requête
                    int result = ps.executeUpdate();

                    // Rediriger en fonction du résultat
                    if (result > 0) {
                        response.sendRedirect("paiement.jsp?successMessage=Paiement ajouté avec succès");
                    } else {
                        response.sendRedirect("paiement.jsp?errorMessage=Erreur lors de l'ajout du paiement");
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("paiement.jsp?errorMessage=Erreur de connexion à la base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger les requêtes GET vers doPost pour un traitement uniforme
        doPost(request, response);
    }
}