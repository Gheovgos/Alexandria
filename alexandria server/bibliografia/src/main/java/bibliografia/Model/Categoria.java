package bibliografia.Model;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.ArrayList;
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
    private List<Categoria> id_sotto_categorie = new ArrayList<Categoria>();

    public Categoria(final int id_categoria, final String descr_categoria, final Utente user_id, final Categoria generaliz, final Categoria sottoCategoria, final Riferimento riferimento) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.user_id = user_id;
        this.id_super_categoria = generaliz;
        this.id_sotto_categorie.add(sottoCategoria);
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

    public void setDescr_categoria(String descr_categoria) {this.descr_categoria = descr_categoria;}

    public Utente getUser_id() {
        return user_id;
    }

    public void setUser_id(Utente user_id) {this.user_id = user_id;}

    public Categoria getId_super_categoria() {
        return id_super_categoria;
    }

    public void setId_super_categoria(Categoria id_super_categoria) {this.id_super_categoria = id_super_categoria;}

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {this.id_categoria = id_categoria;}

    public List<Categoria> getId_sotto_categorie() {
        return id_sotto_categorie;
    }

    public void setId_sotto_categorie(List<Categoria> id_sotto_categorie) {this.id_sotto_categorie = id_sotto_categorie;}
}
