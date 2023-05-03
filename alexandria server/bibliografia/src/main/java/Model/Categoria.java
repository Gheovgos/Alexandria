package Model;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.*;
@Entity
@Table(name = "categoria")
public class Categoria {

    @Id
    @Column
    private int id_Cat;

    @Column
    private String nome;

    @Column
    private int autore;

    @Column
    private int id_Generaliz;

    @ManyToMany(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_Rif", referencedColumnName = "id_Rif")
    private List<Riferimento> riferimenti;

    public Categoria(final int id_Cat, final String nome, final int autore, final int generaliz) {
        super();
        this.id_Cat = id_Cat;
        this.nome = nome;
        this.autore = autore;
        this.id_Generaliz = generaliz;
        this.riferimenti = new ArrayList<Riferimento>();
    }

    public Categoria(final int id_Cat, final String nome, final int autore) {
        super();
        this.id_Cat = id_Cat;
        this.nome = nome;
        this.autore = autore;
    }

    public Categoria()
    {

    }
    public String getNome() {
        return nome;
    }

    public int getAutore() {
        return autore;
    }

    public int getGeneraliz() {
        return id_Generaliz;
    }

    public int getId_Cat() {
        return id_Cat;
    }

    public List<Riferimento> getRiferimenti() {return this.riferimenti;}

}
