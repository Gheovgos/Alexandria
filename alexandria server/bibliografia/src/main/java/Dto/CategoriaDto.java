package Dto;


import java.util.ArrayList;
import java.util.List;

public class CategoriaDto {

    private int id_Cat;

    private String nome;

    private int autore;

    private int id_Generaliz;

    public CategoriaDto(final int id_Cat, final String nome, final int autore, final int generaliz) {
        super();
        this.id_Cat = id_Cat;
        this.nome = nome;
        this.autore = autore;
        this.id_Generaliz = generaliz;
    }

    public CategoriaDto(final int id_Cat, final String nome, final int autore) {
        super();
        this.id_Cat = id_Cat;
        this.nome = nome;
        this.autore = autore;
    }

    public CategoriaDto()
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

    public void setId_Cat(int id_Cat)
    {
        this.id_Cat = id_Cat;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public void setAutore(int autore)
    {
        this.autore = autore;
    }

    public void setId_Generaliz(int id_Generaliz)
    {
        this.id_Generaliz = id_Generaliz;
    }
}
