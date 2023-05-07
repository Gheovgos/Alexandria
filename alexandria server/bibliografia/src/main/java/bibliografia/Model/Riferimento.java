package bibliografia.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;
import java.util.*;
@Entity
@Table(name = "riferimenti_biblio", schema = "public")
public class Riferimento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id_riferimento;

    @Column
    private String titolo;

    @Column
    private LocalDate dataCreazione;

    @Column
    private String tipo;

    @Column
    private String URL;

    @Column
    private int DOI;

    @Column
    private boolean digitale;

    @Column
    private String descrizione;

    @Column
    private String editore;

    @Column
    private String isbn;

    @Column
    private String isnn;

    @Column
    private String luogo;

    @Column
    private int pag_inizio;

    @Column
    private int pag_fine;

    @Column
    private int edizione;

    /*
    private List<Categoria> categorie;

    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "autore", referencedColumnName = "user_ID")
    @ElementCollection(targetClass = Riferimento.class)/

    private List<Integer> autore;
    private List<Riferimento> cited;
    private List<Riferimento> citedIn;*/

    public Riferimento(final int id_riferimento, final String titolo, final LocalDate dataCreazione, final String tipo,
                       final String URL, final Integer DOI, final Boolean digitale, final String descrizione, final String editore,
                       final String isbn, final String isnn, final String luogo, final int pag_inizio, final int pag_fine, final int edizione) {
        super();
        this.id_riferimento = id_riferimento;
        //categorie = new ArrayList<>(0);
        this.titolo = titolo;
        this.dataCreazione = dataCreazione;
        this.DOI = DOI;
        this.tipo = tipo;
        this.URL = URL;
        this.digitale = digitale;
        this.descrizione = descrizione;
        this.edizione = edizione;
        this.pag_fine = pag_fine;
        this.pag_inizio = pag_inizio;
        this.isbn = isbn;
        this.isnn = isnn;
        this.luogo = luogo;
        this.editore = editore;
    }

    public Riferimento()
    {

    }

    public String getTitoloRiferimento() {
        return titolo;
    }

    public void setTitolo(final String titolo) {
        this.titolo = titolo;
    }

    public LocalDate getDataCreazione() {
        return dataCreazione;
    }

    public void setDataCreazione(final LocalDate dataCreazione) {
        this.dataCreazione = dataCreazione;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(final String tipo) {
        this.tipo = tipo;
    }

    public String getUrl() {
        return URL;
    }

    public void setURL(final String URL) {
        this.URL = URL;
    }

    public Boolean getOnline() {
        return digitale;
    }

    public void setDigitale(final Boolean digitale) {
        this.digitale = digitale;
    }
/*
    public List<Categoria> getCategorie() {
        return categorie;
    }

    public void setCategorie(final List<Categoria> categorie) {
        this.categorie = categorie;
    }

    public List<Integer> getAutori() {
        return autore;
    }

    public void setAutori(final List<Integer> autore) {
        this.autore = autore;
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
*/
    public int getIdRiferimento() {
        return id_riferimento;
    }

    public void setId_riferimento(final int id_riferimento) {
        this.id_riferimento = id_riferimento;
    }

    public Integer getDoi() {
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
