package bibliografia.Model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "riferimenti_biblio", schema = "public")
public class Riferimento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id_riferimento;

    @Column
    private String titolo_riferimento;

    @Column
    private LocalDate data_riferimento;

    @Enumerated(EnumType.STRING)
    @Column
    private tipo_enum tipo;

    @Column
    private String URL;

    @Column
    private Integer DOI;

    @Column
    private boolean on_line;

    @Column
    private String descr_riferimento;

    @Column
    private String editore;

    @Column
    private String isbn;

    @Column
    private String isnn;

    @Column
    private String luogo;

    @Column
    private Integer pag_inizio;

    @Column
    private Integer pag_fine;

    @Column
    private Integer edizione;

    /*
    private List<Categoria> categorie;

    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "autore", referencedColumnName = "user_ID")
    @ElementCollection(targetClass = Riferimento.class)/

    private List<Integer> autore;
    private List<Riferimento> cited;
    private List<Riferimento> citedIn;*/

    public Riferimento(final int id_riferimento, final String titolo_riferimento, final LocalDate data_riferimento, final tipo_enum tipo,
                       final String URL, final Integer DOI, final Boolean on_line, final String descr_riferimento, final String editore,
                       final String isbn, final String isnn, final String luogo, final int pag_inizio, final int pag_fine, final int edizione) {
        super();
        this.id_riferimento = id_riferimento;
        //categorie = new ArrayList<>(0);
        this.titolo_riferimento = titolo_riferimento;
        this.data_riferimento = data_riferimento;
        this.DOI = DOI;
        this.tipo = tipo;
        this.URL = URL;
        this.on_line = on_line;
        this.descr_riferimento = descr_riferimento;
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
        return titolo_riferimento;
    }

    public void setTitolo_riferimento(final String titolo_riferimento) {
        this.titolo_riferimento = titolo_riferimento;
    }

    public LocalDate getData_riferimento() {
        return data_riferimento;
    }

    public void setData_riferimento(final LocalDate data_riferimento) {
        this.data_riferimento = data_riferimento;
    }

    public tipo_enum getTipo() {
        return tipo;
    }

    public void setTipo(final tipo_enum tipo) {
        this.tipo = tipo;
    }

    public String getUrl() {
        return URL;
    }

    public void setURL(final String URL) {
        this.URL = URL;
    }

    public Boolean getOnline() {
        return on_line;
    }

    public void setOn_line(final Boolean on_line) {
        this.on_line = on_line;
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

    public void setDOI(final Integer dOI) {
        DOI = dOI;
    }

    public String getDescr_riferimento() {
        return descr_riferimento;
    }

    public void setDescr_riferimento(final String descr_riferimento) {
        this.descr_riferimento = descr_riferimento;
    }
}
