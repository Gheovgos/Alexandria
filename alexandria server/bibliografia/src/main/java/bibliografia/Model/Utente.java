package bibliografia.Model;
//import bibliografia.Model.Riferimento;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.*;
@Entity
@Table(name = "utente", schema = "public")
public class Utente {

    @Id
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int user_ID;

    @Column(name = "nome")
    private String nome;

    @Column(name = "cognome")
    private String cognome;


    @Column(name = "username")
    private String username;

    @Column(name = "password_hashed")
    private String password_hashed;

    @Column(name = "salt")
    private String salt;

   /* @OneToMany
    private List<Categoria> categorie;*/


    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Riferimento> riferimento = new ArrayList<>();

    public Utente(final String nome, final String cognome, final int ID, final String password_hashed, final String salt, final String username, final Categoria categoria) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.password_hashed = password_hashed;
        this.salt = salt;
        this.username = username;
       // this.categorie.add(categoria);
        //this.riferimenti = riferimenti;
    }

    public Utente() {

    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public int getUser_ID() {
        return user_ID;
    }

    public String nominativoCompletoToString() {
        return this.nome + " " + this.cognome;
    }

    public String getPassword_hashed() {return password_hashed;}

    public String getSalt() {return salt;}

    public String getUsername() {return username;}

  /*  public List<Categoria> getCategoria() {
        return categorie;
    }*/
}
