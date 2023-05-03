package Dto;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UtenteDto {

    private final String nome;

    private final String cognome;

    private final int user_ID;

    private final Date inizio;

    private final Date fine;


    public UtenteDto(final String nome, final String cognome, final int ID, final Date inizio, final Date fine) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.inizio = inizio;
        this.fine = fine;
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
