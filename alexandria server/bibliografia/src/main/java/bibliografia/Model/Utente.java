package bibliografia.Model;
//import bibliografia.Model.Riferimento;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.*;
@Entity
@Table(name = "utente")
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

    @Column(name = "email")
    private String email;

    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Riferimento> riferimento = new ArrayList<>();

    @JsonCreator
    public Utente(@JsonProperty("nome") final String nome, @JsonProperty("cognome") final String cognome, @JsonProperty("user_ID") final int ID,
                  @JsonProperty("password_hashed") final String password_hashed,
                  @JsonProperty("salt") final String salt, @JsonProperty("username") final String username, @JsonProperty final String email) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.password_hashed = password_hashed;
        this.salt = salt;
        this.username = username;
        this.email = email;
       // this.categorie.add(categoria);
        //this.riferimenti = riferimenti;
    }

    public Utente() {

    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) { this.cognome = cognome; }

    public int getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(int user_ID) {this.user_ID = user_ID;}

    public String nominativoCompletoToString() {
        return this.nome + " " + this.cognome;
    }

    public String getPassword_hashed() {return password_hashed;}

    public void setPassword_hashed(String password_hashed) { this.password_hashed = password_hashed; }

    public String getSalt() {return salt;}

    public void setSalt(String salt) { this.salt = salt; }

    public String getUsername() {return username;}

    public void setUsername(String username) { this.username = username; }

    public void setRiferimento(List<Riferimento> riferimento) {this.riferimento = riferimento;}

    public String getEmail() { return this.email; }

    public void setEmail(String email) {this.email = email;}

}
