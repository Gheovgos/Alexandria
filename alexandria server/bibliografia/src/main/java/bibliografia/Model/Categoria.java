package bibliografia.Model;
import com.fasterxml.jackson.annotation.*;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "categoria", schema = "public")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Categoria {

    @Id
    @Column
    private int id_categoria;

    @Column
    private String descr_categoria;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @JsonIdentityReference(alwaysAsId = true)
    @JsonIgnore
    private Utente user_id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JsonIdentityReference(alwaysAsId = true)
    @JsonIgnore
    private Categoria super_categoria;

    @OneToMany(mappedBy = "super_categoria", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<Categoria> id_sotto_categorie = new ArrayList<Categoria>();

    public Categoria(final int id_categoria, final String descr_categoria, final Categoria generaliz, final Categoria sottoCategoria, final Riferimento riferiment, final Integer user_id) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
        this.super_categoria = generaliz;
        this.user_id = new Utente();
        this.user_id.setUser_ID(user_id);
        this.id_sotto_categorie.add(sottoCategoria);
    }

    public Categoria(final int id_categoria, final String descr_categoria) {
        super();
        this.id_categoria = id_categoria;
        this.descr_categoria = descr_categoria;
    }

    public Categoria()
    {

    }
    public String getDescr_categoria() {
        return descr_categoria;
    }

    public void setDescr_categoria(String descr_categoria) {this.descr_categoria = descr_categoria;}

    public void setSuper_categoria(Integer super_categoria) {
    }

    public Categoria getSuper_categoria() {
        return super_categoria;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {this.id_categoria = id_categoria;}

    public List<Categoria> getId_sotto_categorie() {
        return id_sotto_categorie;
    }

    public void setId_sotto_categorie(List<Categoria> id_sotto_categorie) {this.id_sotto_categorie = id_sotto_categorie;}

    public void setUser_id(Integer id) {
        this.user_id = new Utente();
        this.user_id.setUser_ID(id);
    }

    public Integer getUser_id() {return this.user_id.getUser_ID(); }
}
