package com.example.demo1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/incident")
public class IncidentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IncidentService incidentService = new IncidentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer la session
        HttpSession session = request.getSession();

        // Récupérer les données du formulaire
        String residentIdStr = request.getParameter("resident_id");
        String chambreIdStr = request.getParameter("chambre_id");
        String categorie = request.getParameter("categorie");
        String description = request.getParameter("description");

        // Valider les données
        if (residentIdStr == null || residentIdStr.isEmpty() ||
                chambreIdStr == null || chambreIdStr.isEmpty() ||
                categorie == null || categorie.isEmpty() ||
                description == null || description.isEmpty()) {
            // Rediriger avec un message d'erreur si un champ est vide
            session.setAttribute("errorMessage", "Tous les champs sont obligatoires.");
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp");
            return;
        }

        try {
            // Convertir les IDs en entiers
            int residentId = Integer.parseInt(residentIdStr);
            int chambreId = Integer.parseInt(chambreIdStr);

            // Utiliser le service pour insérer les données
            incidentService.reportIncident(residentId, chambreId, categorie, description);

            // Rediriger vers la page de succès avec un message
            session.setAttribute("successMessage", "Le signalement a été enregistré avec succès.");
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp");
        } catch (NumberFormatException e) {
            // Gérer les erreurs de conversion des IDs
            session.setAttribute("errorMessage", "Les IDs doivent être des nombres valides.");
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp");
        } catch (Exception e) {
            // Gérer les autres erreurs
            e.printStackTrace();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de l'enregistrement du signalement.");
            response.sendRedirect(request.getContextPath() + "/maintenance.jsp");
        }
    }
}