package com.example.demo1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class IncidentService {

    private static final String URL = "jdbc:mysql://localhost/residence_manager";
    private static final String USER = "root";
    private static final String PASSWORD = "root123@";

    public void reportIncident(int residentId, int chambreId, String categorie, String description) throws SQLException {
        String query = "INSERT INTO incidents (resident_id, chambre_id, categorie, description, date_signalement, statut) VALUES (?, ?, ?, ?, NOW(), 'en attente')";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, residentId);
            statement.setInt(2, chambreId);
            statement.setString(3, categorie);
            statement.setString(4, description);
            statement.executeUpdate();
        }
    }
}