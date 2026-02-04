package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.format.DateTimeFormatter;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/Dash")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject data = new JSONObject();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@")) {
            // Récupérer les statistiques des chambres
            int totalChambres = getTotalChambres(conn);
            int chambresOccupees = getChambresOccupees(conn);
            int chambresDisponibles = totalChambres - chambresOccupees;
            double tauxOccupationChambres = (double) chambresOccupees / totalChambres * 100;

            // Récupérer les statistiques des résidents
            int totalResidents = getTotalResidents(conn);
            double tauxResidents = (double) totalResidents / totalChambres * 100;

            // Récupérer les paiements
            int paiementsAJour = getPaiementsAJour(conn);
            int paiementsEnRetard = getPaiementsEnRetard(conn);

            // Récupérer les nouveaux résidents
            int nouveauxResidents = getNouveauxResidents(conn);

            // Récupérer les paiements récents
            JSONArray recentPayments = getRecentPayments(conn);

            // Récupérer les mises à jour récentes
            JSONArray recentUpdates = getRecentUpdates(conn);

            // Ajouter les données au JSON
            data.put("totalChambres", totalChambres);
            data.put("tauxOccupationChambres", Math.round(tauxOccupationChambres));
            data.put("totalResidents", totalResidents);
            data.put("tauxResidents", Math.round(tauxResidents));
            data.put("chambresDisponibles", chambresDisponibles);
            data.put("tauxChambresDisponibles", Math.round((double) chambresDisponibles / totalChambres * 100));
            data.put("paiementsAJour", paiementsAJour);
            data.put("paiementsEnRetard", paiementsEnRetard);
            data.put("nouveauxResidents", nouveauxResidents);
            data.put("recentPayments", recentPayments);
            data.put("recentUpdates", recentUpdates);

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            data.put("error", "Erreur de base de données");
        }

        // Envoyer la réponse JSON
        try (PrintWriter out = response.getWriter()) {
            out.print(data.toString());
        }
    }

    // Méthodes pour interroger la base de données
    private int getTotalChambres(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM chambres";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getChambresOccupees(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM residents WHERE statut = 'actif'";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getTotalResidents(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM residents";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getPaiementsAJour(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM paiements WHERE statut = 'Payé'";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getPaiementsEnRetard(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM paiements WHERE statut = 'En retard'";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private int getNouveauxResidents(Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM residents WHERE statut = 'en attente'";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private JSONArray getRecentPayments(Connection conn) throws SQLException {
        JSONArray payments = new JSONArray();
        String query = "SELECT r.nom, p.montant_paye, p.date_paiement, p.statut " +
                "FROM paiements p JOIN residents r ON p.resident_id = r.id " +
                "ORDER BY p.date_paiement DESC LIMIT 5";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                JSONObject payment = new JSONObject();
                payment.put("resident", rs.getString("nom"));
                payment.put("montantPaye", rs.getDouble("montant_paye"));
                payment.put("datePaiement", rs.getTimestamp("date_paiement").toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
                payment.put("statut", rs.getString("statut"));
                payments.put(payment);
            }
        }
        return payments;
    }

    private JSONArray getRecentUpdates(Connection conn) throws SQLException {
        JSONArray updates = new JSONArray();
        String query = "SELECT r.nom, i.description, i.date_signalement " +
                "FROM incidents i JOIN residents r ON i.resident_id = r.id " +
                "ORDER BY i.date_signalement DESC LIMIT 5";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                JSONObject update = new JSONObject();
                update.put("nom", rs.getString("nom"));
                update.put("message", rs.getString("description"));
                update.put("timestamp", rs.getTimestamp("date_signalement").toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
                update.put("photo", "images/ph1.jpg"); // Remplacez par l'URL de la photo du résident
                updates.put(update);
            }
        }
        return updates;
    }
}