package bibliografia.Dto;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UtenteDto {

    private String nome;

    private String cognome;

    private String username;

    private int user_ID;

    private String password_hashed;

    private String salt;


    public UtenteDto(final String nome, final String cognome, final int ID, final String password_hashed, final String salt, final String username) {
        super();
        this.nome = nome;
        this.cognome = cognome;
        this.user_ID = ID;
        this.password_hashed = password_hashed;
        this.username = username;
        this.salt = salt;
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

    public String getPassword_hashed() { return password_hashed; }

    public void setPassword_hashed(String password_hashed) {this.password_hashed = password_hashed;}

    public String getSalt() {return salt;}

    public void setSalt(String salt) {this.salt = salt;}

    public String getUsername() {return username;}

    public void setUsername(String username) {this.username = username;}
}
