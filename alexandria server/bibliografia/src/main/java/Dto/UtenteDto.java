package Dto;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UtenteDto {

    private String nome;

    private String cognome;

    private int user_ID;

    private Date inizio;

    private Date fine;


    public UtenteDto(final String nome, final String cognome, final int ID, final Date inizio, final Date fine) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.inizio = inizio;
        this.fine = fine;
    }

    public UtenteDto()
    {

    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {this.nome = nome;}

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome){this.cognome = cognome;}

    public int getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(int user_ID){this.user_ID = user_ID;}

    public String nominativoCompletoToString() {
        return this.nome + " " + this.cognome;
    }

    public Date getInizio() {
        return inizio;
    }

    public void setInizio(Date inizio) {this.inizio = inizio;}

    public Date getFine() {
        return fine;
    }

    public void setFine(Date fine) {this.fine = fine;}
}
