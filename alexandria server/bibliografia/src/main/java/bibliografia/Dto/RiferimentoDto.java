package bibliografia.Dto;


import bibliografia.Model.tipo_enum;

import java.time.LocalDate;

public class RiferimentoDto {
    private int id_Rif;

    private String titolo;

    private LocalDate dataCreazione;

    private tipo_enum tipo;

    private String URL;

    private Integer DOI;

    private Boolean digitale;

    private String descrizione;

    private String editore;

    private String isbn;

    private String isnn;

    private String luogo;

    private Integer pag_inizio;

    private Integer pag_fine;

    private Integer edizione;

    public RiferimentoDto(final int id_Rif, final String titolo, final LocalDate dataCreazione, final tipo_enum tipo,
                          final String URL, final Integer DOI, final Boolean digitale, final String descrizione,
                          final String editore, final String isbn, final String isnn, final String luogo,
                          final Integer pag_inizio, final Integer pag_fine, final Integer edizione) {
        super();
        this.id_Rif = id_Rif;
        this.titolo = titolo;
        this.dataCreazione = dataCreazione;
        this.DOI = DOI;
        this.tipo = tipo;
        this.URL = URL;
        this.digitale = digitale;
        this.descrizione = descrizione;
        this.editore = editore;
        this.isbn = isbn;
        this.isnn = isnn;
        this.luogo = luogo;
        this.pag_inizio = pag_inizio;
        this.pag_fine = pag_fine;
        this.edizione = edizione;
    }

    public RiferimentoDto()
    {

    }

    public String getTitolo() {
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

    public tipo_enum getTipo() {
        return tipo;
    }

    public void setTipo(final tipo_enum tipo) {
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

    public String getEditore() {return this.editore;}

    public void setEditore(String editore) {this.editore = editore;}

    public String getIsbn() {return this.isbn;}

    public void setIsbn(String isbn) {this.isbn = isbn;}

    public String getIsnn() {return this.isnn;}

    public void setIsnn(String isnn) {this.isnn = isnn;}

    public String getLuogo() {return this.luogo;}

    public void setLuogo(String luogo) {this.luogo = luogo; }

    public Integer getPag_inizio() {return this.pag_inizio;}

    public void setPag_inizio(Integer pag_inizio) {this.pag_inizio = pag_inizio;}

    public Integer getPag_fine() {return this.pag_fine;}

    public void setPag_fine() {this.pag_fine = pag_fine;}

    public Integer getEdizione() {return this.edizione;}

    public void setEdizione(Integer edizione) {this.edizione = edizione;}
}
