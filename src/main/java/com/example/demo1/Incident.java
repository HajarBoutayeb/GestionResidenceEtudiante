package com.example.demo1;

import java.util.Date;

public class Incident {
    private int id;
    private int residentId;
    private int chambreId;
    private String description;
    private String categorie;
    private Date dateSignalement;
    private String statut;
    private int technicienAssigne;
    private Date dateResolution;
    private String commentaireResolution;

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getResidentId() {
        return residentId;
    }

    public void setResidentId(int residentId) {
        this.residentId = residentId;
    }

    public int getChambreId() {
        return chambreId;
    }

    public void setChambreId(int chambreId) {
        this.chambreId = chambreId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public Date getDateSignalement() {
        return dateSignalement;
    }

    public void setDateSignalement(Date dateSignalement) {
        this.dateSignalement = dateSignalement;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public int getTechnicienAssigne() {
        return technicienAssigne;
    }

    public void setTechnicienAssigne(int technicienAssigne) {
        this.technicienAssigne = technicienAssigne;
    }

    public Date getDateResolution() {
        return dateResolution;
    }

    public void setDateResolution(Date dateResolution) {
        this.dateResolution = dateResolution;
    }

    public String getCommentaireResolution() {
        return commentaireResolution;
    }

    public void setCommentaireResolution(String commentaireResolution) {
        this.commentaireResolution = commentaireResolution;
    }
}