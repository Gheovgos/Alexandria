package bibliografia.Dto;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class UtenteDto {

    private String nome;

    private String cognome;

    private String username;

    private int user_ID;

    private String password_hashed;

    private String salt;


    @JsonCreator
    public UtenteDto(@JsonProperty("nome") final String nome, @JsonProperty("cognome") final String cognome, @JsonProperty("user_ID") final int ID, @JsonProperty("password_hashed") final String password_hashed,
                     @JsonProperty("salt") final String salt, @JsonProperty("username") final String username) {
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
