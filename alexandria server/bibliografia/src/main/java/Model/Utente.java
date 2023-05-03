package Model;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.*;
@Entity
@Table
public class Utente {

    @Column
    private final String nome;

    @Column
    private final String cognome;

    @Id
    @Column
    private final int user_ID;

    @Column
    private final Date inizio;

    @Column
    private final Date fine;

    @Column
    @ManyToMany
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_Rif", referencedColumnName = "id_Rif")
    private List<Riferimento> riferimenti;

    public Utente(final String nome, final String cognome, final int ID, final Date inizio, final Date fine) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.inizio = inizio;
        this.fine = fine;
        this.riferimenti = new ArrayList<Riferimento>();
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
}
