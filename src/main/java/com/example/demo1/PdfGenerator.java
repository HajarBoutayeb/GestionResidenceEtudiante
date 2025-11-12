package com.example.demo1;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.FileOutputStream;
import java.io.IOException;

public class PdfGenerator {

    public static void generatePdf(int idPaiement, int idEtudiant, String nom, String prenom, double montantPaye, String datePaiement, String statutPaiement, String filePath) throws DocumentException, IOException {
        // Créer un document PDF
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(filePath));
        document.open();

        // Titre du document
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
        Paragraph title = new Paragraph("Reçu de Paiement", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        // Ajouter un espace
        document.add(new Paragraph(" "));

        // Créer un tableau avec 2 colonnes
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);

        // Définir les largeurs des colonnes
        float[] columnWidths = {1f, 2f};
        table.setWidths(columnWidths);

        // Ajouter les données au tableau
        addRow(table, "ID Paiement", String.valueOf(idPaiement));
        addRow(table, "ID Étudiant", String.valueOf(idEtudiant));
        addRow(table, "Nom", nom);
        addRow(table, "Prénom", prenom);
        addRow(table, "Montant Payé", montantPaye + " €");
        addRow(table, "Date de Paiement", datePaiement);
        addRow(table, "Statut", statutPaiement);

        // Ajouter le tableau au document
        document.add(table);

        // Fermer le document
        document.close();
    }

    private static void addRow(PdfPTable table, String label, String value) {
        // Ajouter une cellule pour le label
        PdfPCell labelCell = new PdfPCell(new Phrase(label));
        labelCell.setPadding(5);
        labelCell.setBackgroundColor(new com.itextpdf.text.BaseColor(240, 240, 240)); // Couleur de fond
        table.addCell(labelCell);

        // Ajouter une cellule pour la valeur
        PdfPCell valueCell = new PdfPCell(new Phrase(value));
        valueCell.setPadding(5);
        table.addCell(valueCell);
    }
}