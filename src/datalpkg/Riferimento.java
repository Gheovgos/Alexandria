package datalpkg;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Riferimento {
	private String titolo;
	private Date dataCreazione;
	private String tipo;
	private String DOI_URL;
	private Boolean digitale;
	private List<Categoria> categorie;
	private List<Utente> autori;
	private List<Riferimento> citazioni;
	
	public String getTitolo() {
		return titolo;
	}
	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}
	public Date getDataCreazione() {
		return dataCreazione;
	}
	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getDOI_URL() {
		return DOI_URL;
	}
	public void setDOI_URL(String dOI_URL) {
		DOI_URL = dOI_URL;
	}
	public Boolean getDigitale() {
		return digitale;
	}
	public void setDigitale(Boolean digitale) {
		this.digitale = digitale;
	}
	public List<Categoria> getCategorie() {
		return categorie;
	}
	public void setCategorie(List<Categoria> categorie) {
		this.categorie = categorie;
	}
	public List<Utente> getAutori() {
		return autori;
	}
	public void setAutori(List<Utente> autori) {
		this.autori = autori;
	}
	public List<Riferimento> getCitazioni() {
		return citazioni;
	}
	public void setCitazioni(List<Riferimento> citazioni) {
		this.citazioni = citazioni;
	}
	public Riferimento(String titolo, Date dataCreazione, String tipo, String dOI_URL, Boolean digitale,
			List<Categoria> categorie, List<Utente> autori, List<Riferimento> citazioni) {
		super();
		this.titolo = titolo;
		this.dataCreazione = dataCreazione;
		this.tipo = tipo;
		DOI_URL = dOI_URL;
		this.digitale = digitale;
		this.categorie = categorie;
		this.autori = autori;
		this.citazioni = citazioni;
	}
	public Riferimento(String titolo, Date dataCreazione, String tipo, String dOI_URL, Boolean digitale) {
		super();
		categorie = new ArrayList<Categoria>();
		this.titolo = titolo;
		this.dataCreazione = dataCreazione;
		this.tipo = tipo;
		DOI_URL = dOI_URL;
		this.digitale = digitale;
	}
	public String autoriToString()
	{
		String a = "";
		for(int i=0;i<autori.size();i++)
		{
			a = a.concat(autori.get(i).nominativoCompletoToString());
			if(i!=autori.size()-1)
				a = a.concat(",");
		}	
		return a;
	}
	public String categorieToString()
	{
		String a = "";
		for(int i=0;i<categorie.size();i++)
		{
			a = a.concat(categorie.get(i).getNome()+" ");
			if(i!=categorie.size()-1)
				a = a.concat(",");
		}
		return a;
	}
}