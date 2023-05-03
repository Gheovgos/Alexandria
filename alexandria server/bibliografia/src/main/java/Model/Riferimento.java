package Model;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.util.*;
@Entity
@Table
public class Riferimento {

    @Id
    @Column
    private int id_Rif;

    @Column
    private String titolo;

    @Column
    private Date dataCreazione;

    @Column
    private String tipo;

    @Column
    private String URL;

    @Column
    private Integer DOI;

    @Column
    private Boolean digitale;

    @Column
    private String descrizione;


    private List<Categoria> categorie;
    private List<Utente> autori;
    private List<Riferimento> cited;
    private List<Riferimento> citedIn;

    public Riferimento(final int id_Rif, final String titolo, final Date dataCreazione, final String tipo,
                       final String URL, final Integer DOI, final Boolean digitale, final String descrizione) {
        super();
        this.id_Rif = id_Rif;
        categorie = new ArrayList<>(0);
        this.titolo = titolo;
        this.dataCreazione = dataCreazione;
        this.DOI = DOI;
        this.tipo = tipo;
        this.URL = URL;
        this.digitale = digitale;
        this.descrizione = descrizione;
    }

    public Riferimento()
    {

    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(final String titolo) {
        this.titolo = titolo;
    }

    public Date getDataCreazione() {
        return dataCreazione;
    }

    public void setDataCreazione(final Date dataCreazione) {
        this.dataCreazione = dataCreazione;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(final String tipo) {
        this.tipo = tipo;
    }

    public String getURL() {
        return URL;
    }

    public void setURL(final String URL) {
        this.URL = URL;
    }

    public Boolean getDigitale() {
        return digitale;
    }

    public void setDigitale(final Boolean digitale) {
        this.digitale = digitale;
    }

    public List<Categoria> getCategorie() {
        return categorie;
    }

    public void setCategorie(final List<Categoria> categorie) {
        this.categorie = categorie;
    }

    public List<Utente> getAutori() {
        return autori;
    }

    public void setAutori(final List<Utente> autori) {
        this.autori = autori;
    }

    public List<Riferimento> getCitazioni() {
        return cited;
    }

    public void setCitazioni(final List<Riferimento> citazioni) {
        this.cited = citazioni;
    }

    public String citazioniToString() {
        final StringBuilder a = new StringBuilder();
        for (int i = 0; i < cited.size(); i++) {
            a.append(cited.get(i).titolo);
            if (i != cited.size() - 1)
                a.append(",");
        }
        return a.toString();
    }

    public String citazioniToString(final int ID) {
        final StringBuilder a = new StringBuilder();
        for (int i = 0; i < cited.size(); i++) {
            final List<Utente> tempList = cited.get(i).autori;
            if (tempList != null) {
                for (int j = 0; j < tempList.size(); j++) {
                    if (ID == tempList.get(i).getUser_ID()) {
                        a.append(cited.get(i).titolo);
                        if (i != cited.size() - 1)
                            a.append(",");
                        j = tempList.size();
                    }
                }
            }
        }
        return a.toString();
    }

    public String autoriToString() {
        final StringBuilder a = new StringBuilder();
        for (int i = 0; i < autori.size(); i++) {
            a.append(autori.get(i).nominativoCompletoToString());
            if (i != autori.size() - 1)
                a.append(",");
        }
        return a.toString();
    }

    public String categorieToString() {
        final StringBuilder a = new StringBuilder();
        for (int i = 0; i < categorie.size(); i++) {
            a.append(categorie.get(i).getNome()).append(" ");
            if (i != categorie.size() - 1)
                a.append(",");
        }
        return a.toString();
    }

    public List<Riferimento> getCitedIn() {
        return citedIn;
    }

    public void setCitedIn(final List<Riferimento> citedIn) {
        this.citedIn = citedIn;
    }

    public int getId_Rif() {
        return id_Rif;
    }

    public void setId_Rif(final int id_Rif) {
        this.id_Rif = id_Rif;
    }

    public Integer getDOI() {
        return DOI;
    }

    public void setDOI(final int dOI) {
        DOI = dOI;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(final String descrizione) {
        this.descrizione = descrizione;
    }
}
