package bibliografia.Model;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

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

    @ManyToOne
    @JsonManagedReference
    private Categoria id_super_categoria;

    @OneToMany(mappedBy = "id_super_categoria")
    @JsonBackReference
    private List<Categoria> id_sotto_categorie;

    /*@ManyToMany(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_Rif", referencedColumnName = "id_Rif")*/
    //private List<Riferimento> riferimenti;

    public Categoria(final int id_categoria, final String descr_categoria, final Utente user_id, final Categoria generaliz, final Categoria sottoCategoria) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.user_id = user_id;
        this.id_super_categoria = generaliz;
        this.id_sotto_categorie.add(sottoCategoria);
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

    public Categoria getGeneraliz() {
        return id_super_categoria;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public List<Categoria> getId_sotto_categorie() {
        return id_sotto_categorie;
    }

   // public List<Riferimento> getRiferimenti() {return this.riferimenti;}

}
