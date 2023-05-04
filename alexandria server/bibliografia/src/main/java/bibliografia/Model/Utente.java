package bibliografia.Model;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.*;
@Entity
@Table(name = "utente")
public class Utente {

    @Id
    @Column(name = "user_ID")
    private int user_ID;

    @Column(name = "nome")
    private String nome;

    @Column(name = "cognome")
    private String cognome;


    @Column(name = "inizio")
    private Date inizio;

    @Column(name = "fine")
    private Date fine;

    @Column(name = "username")
    private String username;

    @Column(name = "password_hashed")
    private String password_hashed;

    @Column(name = "salt")
    private String salt;

    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_Rif", referencedColumnName = "id_Rif")
    private List<Riferimento> riferimenti = new ArrayList<>();

    public Utente(final String nome, final String cognome, final int ID, final Date inizio, final Date fine, final String password_hashed, final String salt, final String username, ArrayList<Riferimento> riferimenti) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.inizio = inizio;
        this.fine = fine;
        this.password_hashed = password_hashed;
        this.salt = salt;
        this.username = username;
        this.riferimenti = riferimenti;
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

    public Date getInizio() {
        return inizio;
    }

    public Date getFine() {
        return fine;
    }

    public String getPassword_hashed() {return password_hashed;}

    public String getSalt() {return salt;}

    public String getUsername() {return username;}
}
