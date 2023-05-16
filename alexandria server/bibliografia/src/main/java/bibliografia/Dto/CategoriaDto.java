package bibliografia.Dto;


public class CategoriaDto {

    private int id_categoria;

    private String descr_categoria;

    private Integer id_utente;

    private Integer id_super_categoria;

    public CategoriaDto(final int id_categoria, final String descr_categoria, final int id_utente, final Integer generaliz) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.id_utente = id_utente;
        this.id_super_categoria = generaliz;
    }

    public CategoriaDto(final int id_categoria, final String descr_categoria, final int id_utente) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.id_utente = id_utente;
    }

    public CategoriaDto()
    {

    }
    public String getDescr_categoria() {
        return descr_categoria;
    }

    public Integer getId_utente() {
        return id_utente;
    }

    public Integer getSuper_Categoria() {
        return id_super_categoria;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria)
    {
        this.id_categoria = id_categoria;
    }

    public void setDescr_categoria(String descr_categoria)
    {
        this.descr_categoria = descr_categoria;
    }

    public void setId_utente(Integer id_utente)
    {
        this.id_utente = id_utente;
    }

    public void setId_super_categoria(Integer id_super_categoria)
    {
        this.id_super_categoria = id_super_categoria;
    }
}
