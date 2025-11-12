package com.example.demo1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
@WebServlet("/DeletePaiement")
public class DeletePaiement extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idPaiement = Integer.parseInt(request.getParameter("id"));

        String url = "jdbc:mysql://localhost/residence_manager";
        String driver = "com.mysql.cj.jdbc.Driver";

        try {
            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, "root", "root123@");

            String sql = "DELETE FROM paiements WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idPaiement);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("paiementResident.jsp");
            } else {
                response.getWriter().println("Erreur lors de la suppression du paiement.");
            }
            ps.close();
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur de connexion à la base de données : " + e.getMessage());
        }
    }
}
