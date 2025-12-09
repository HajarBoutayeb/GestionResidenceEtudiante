package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ReserverChambreServlet")
public class ReserverChambreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer residentId = (Integer) session.getAttribute("id");

        if (residentId == null) {
            response.sendRedirect(request.getContextPath() + "/loginResident.jsp");
            return;
        }

        String chambreIdParam = request.getParameter("chambreId");
        if (chambreIdParam == null || chambreIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "Veuillez sélectionner une chambre.");
            request.getRequestDispatcher("/listeChambres.jsp").forward(request, response);
            return;
        }

        int chambreId = Integer.parseInt(chambreIdParam);

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Connexion à la base de données
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/residence_manager", "root", "root123@");

            // Vérifier si le résident a déjà une chambre
            String sqlCheckResident = "SELECT chambre_id FROM residents WHERE id = ?";
            pstmt = conn.prepareStatement(sqlCheckResident);
            pstmt.setInt(1, residentId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int chambreAttribuee = rs.getInt("chambre_id");
                if (chambreAttribuee != 0) {
                    request.setAttribute("errorMessage", "Vous avez déjà une chambre attribuée.");
                    request.getRequestDispatcher("/listeChambres.jsp").forward(request, response);
                    return;
                }
            }

            // Vérifier si la chambre est disponible
            String sqlCheckChambre = "SELECT statut FROM chambres WHERE id = ?";
            pstmt = conn.prepareStatement(sqlCheckChambre);
            pstmt.setInt(1, chambreId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String statut = rs.getString("statut");
                if (!"disponible".equals(statut)) {
                    request.setAttribute("errorMessage", "La chambre sélectionnée n'est plus disponible.");
                    request.getRequestDispatcher("/listeChambres.jsp").forward(request, response);
                    return;
                }
            }

            // Mettre à jour la chambre et le résident
            String sqlUpdateChambre = "UPDATE chambres SET statut = 'occupée' WHERE id = ?";
            pstmt = conn.prepareStatement(sqlUpdateChambre);
            pstmt.setInt(1, chambreId);
            pstmt.executeUpdate();

            String sqlUpdateResident = "UPDATE residents SET chambre_id = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sqlUpdateResident);
            pstmt.setInt(1, chambreId);
            pstmt.setInt(2, residentId);
            pstmt.executeUpdate();

            // Rediriger avec un message de succès
            request.setAttribute("successMessage", "La chambre a été réservée avec succès.");
            request.getRequestDispatcher("/listeChambres.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de la réservation de la chambre.");
            request.getRequestDispatcher("/listeChambres.jsp").forward(request, response);
        } finally {
            // Fermer les ressources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}