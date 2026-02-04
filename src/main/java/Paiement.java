import java.sql.Timestamp;

public class Paiement {
    private int idPaiement;
    private int idEtudiant;
    private double montantPaye;
    private Timestamp datePaiement;
    private String statutPaiement;
    private String recuUrl;

    // Constructeurs
    public Paiement() {
        // Constructeur par défaut
    }

    public Paiement(int idPaiement, int idEtudiant, double montantPaye, Timestamp datePaiement, String statutPaiement, String recuUrl) {
        this.idPaiement = idPaiement;
        this.idEtudiant = idEtudiant;
        this.montantPaye = montantPaye;
        this.datePaiement = datePaiement;
        this.statutPaiement = statutPaiement;
        this.recuUrl = recuUrl;
    }

    // Getters et Setters
    public int getIdPaiement() {
        return idPaiement;
    }

    public void setIdPaiement(int idPaiement) {
        this.idPaiement = idPaiement;
    }

    public int getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(int idEtudiant) {
        this.idEtudiant = idEtudiant;
    }

    public double getMontantPaye() {
        return montantPaye;
    }

    public void setMontantPaye(double montantPaye) {
        this.montantPaye = montantPaye;
    }

    public Timestamp getDatePaiement() {
        return datePaiement;
    }

    public void setDatePaiement(Timestamp datePaiement) {
        this.datePaiement = datePaiement;
    }

    public String getStatutPaiement() {
        return statutPaiement;
    }

    public void setStatutPaiement(String statutPaiement) {
        this.statutPaiement = statutPaiement;
    }

    public String getRecuUrl() {
        return recuUrl;
    }

    public void setRecuUrl(String recuUrl) {
        this.recuUrl = recuUrl;
    }

    // Méthode toString pour afficher les informations du paiement
    @Override
    public String toString() {
        return "Paiement{" +
                "idPaiement=" + idPaiement +
                ", idEtudiant=" + idEtudiant +
                ", montantPaye=" + montantPaye +
                ", datePaiement=" + datePaiement +
                ", statutPaiement='" + statutPaiement + '\'' +
                ", recuUrl='" + recuUrl + '\'' +
                '}';
    }
}