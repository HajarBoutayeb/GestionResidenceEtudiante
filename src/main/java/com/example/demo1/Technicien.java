package com.example.demo1;

public class Technicien {
    // Attributs correspondant aux colonnes de la table
    private int id;
    private String nom;
    private String email;
    private String motDePasse;
    private String telephone;
    private String specialite;
    private boolean actif;

    // Constructeur par défaut
    public Technicien() {
    }

    // Constructeur avec tous les attributs
    public Technicien(int id, String nom, String email, String motDePasse, String telephone, String specialite, boolean actif) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.telephone = telephone;
        this.specialite = specialite;
        this.actif = actif;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    // Méthode toString pour afficher les informations du technicien
    @Override
    public String toString() {
        return "Technicien{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", email='" + email + '\'' +
                ", motDePasse='" + motDePasse + '\'' +
                ", telephone='" + telephone + '\'' +
                ", specialite='" + specialite + '\'' +
                ", actif=" + actif +
                '}';
    }
}