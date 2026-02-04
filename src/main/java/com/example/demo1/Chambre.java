package com.example.demo1;

public class Chambre {
    private int id;
    private String numeroChambre;
    private String taille;
    private String equipements;
    private String statut;
    private double prixMensuel;
    private int etage;
    private String description;

    // Constructeurs
    public Chambre() {
        // Constructeur par défaut
    }

    public Chambre(int id, String numeroChambre, String taille, String equipements, String statut, double prixMensuel, int etage, String description) {
        this.id = id;
        this.numeroChambre = numeroChambre;
        this.taille = taille;
        this.equipements = equipements;
        this.statut = statut;
        this.prixMensuel = prixMensuel;
        this.etage = etage;
        this.description = description;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumeroChambre() {
        return numeroChambre;
    }

    public void setNumeroChambre(String numeroChambre) {
        this.numeroChambre = numeroChambre;
    }

    public String getTaille() {
        return taille;
    }

    public void setTaille(String taille) {
        this.taille = taille;
    }

    public String getEquipements() {
        return equipements;
    }

    public void setEquipements(String equipements) {
        this.equipements = equipements;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public double getPrixMensuel() {
        return prixMensuel;
    }

    public void setPrixMensuel(double prixMensuel) {
        this.prixMensuel = prixMensuel;
    }

    public int getEtage() {
        return etage;
    }

    public void setEtage(int etage) {
        this.etage = etage;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Méthode toString pour afficher les informations de la chambre
    @Override
    public String toString() {
        return "Chambre{" +
                "id=" + id +
                ", numeroChambre='" + numeroChambre + '\'' +
                ", taille='" + taille + '\'' +
                ", equipements='" + equipements + '\'' +
                ", statut='" + statut + '\'' +
                ", prixMensuel=" + prixMensuel +
                ", etage=" + etage +
                ", description='" + description + '\'' +
                '}';
    }
}