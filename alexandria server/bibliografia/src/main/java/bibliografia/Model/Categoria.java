package bibliografia.Model;
import jakarta.persistence.*;

@Entity
@Table(name = "categoria", schema = "public")
public class Categoria {

    @Id
    @Column
    private int id_categoria;

    @Column
    private String descr_categoria;

    @ManyToOne
    @JoinColumn(name = "user_ID")
    private Utente user_id;

    @Column
    private Integer id_super_categoria;

    /*@ManyToMany(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_Rif", referencedColumnName = "id_Rif")*/
    //private List<Riferimento> riferimenti;

    public Categoria(final int id_categoria, final String descr_categoria, final Utente user_id, final int generaliz) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.user_id = user_id;
        this.id_super_categoria = generaliz;
        //this.riferimenti = new ArrayList<Riferimento>();
    }

    public Categoria(final int id_categoria, final String descr_categoria, final Utente user_id) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.user_id = user_id;
    }

    public Categoria()
    {

    }
    public String getDescr_categoria() {
        return descr_categoria;
    }

    public Utente getUser_id() {
        return user_id;
    }

    public Integer getGeneraliz() {
        return id_super_categoria;
    }

    public int getId_categoria() {
        return id_categoria;
    }

   // public List<Riferimento> getRiferimenti() {return this.riferimenti;}

}
