package bibliografia.Dto;


import java.util.Date;

public class RiferimentoDto {
    private int id_Rif;

    private String titolo;

    private Date dataCreazione;

    private String tipo;

    private String URL;

    private Integer DOI;

    private Boolean digitale;

    private String descrizione;

    public RiferimentoDto(final int id_Rif, final String titolo, final Date dataCreazione, final String tipo,
                       final String URL, final Integer DOI, final Boolean digitale, final String descrizione) {
        super();
        this.id_Rif = id_Rif;
        this.titolo = titolo;
        this.dataCreazione = dataCreazione;
        this.DOI = DOI;
        this.tipo = tipo;
        this.URL = URL;
        this.digitale = digitale;
        this.descrizione = descrizione;
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
