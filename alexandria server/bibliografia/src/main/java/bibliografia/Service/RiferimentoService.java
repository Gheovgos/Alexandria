package bibliografia.Service;

import bibliografia.Model.Riferimento;
import bibliografia.Repository.RiferimentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Component
public class RiferimentoService {
    private final RiferimentoRepository riferimentoRepository;
    @Autowired
    public RiferimentoService(RiferimentoRepository riferimentoRepository) {
        this.riferimentoRepository = riferimentoRepository;
    }


    public List<Riferimento> getRiferimenti()
    {
        return riferimentoRepository.findAll();
    }

    public Riferimento getRiferimentoById(int riferimentoId) {return riferimentoRepository.getRiferimentoById(riferimentoId);}

    public List<Riferimento> getRiferimentoByUserId(@PathVariable int user_id) {return riferimentoRepository.getRiferimentoByUserId(user_id);}

    public Riferimento getRiferimentoByNome(@PathVariable String titolo_riferimento) {return riferimentoRepository.getRiferimentoByNome(titolo_riferimento);}

    public List<Riferimento> getByRiferimento(@PathVariable int riferimento_associato) {return riferimentoRepository.getByRiferimento(riferimento_associato);}

    public List<Riferimento> getBySTitolo(@PathVariable String titolo) {return riferimentoRepository.getBySTitolo(titolo);}

    public List<Riferimento> getRiferimentoCitanti(@PathVariable int riferimento_associato) {return riferimentoRepository.getRiferimentoCitanti(riferimento_associato);}


    public List<Riferimento> getByDescrizione(@PathVariable String descrizione) {return riferimentoRepository.getByDescrizione(descrizione);}

    public List<Riferimento> getByAutoreSearch(@PathVariable String nome) {return riferimentoRepository.getByAutoreSearch(nome);}

    public List<Riferimento> getByTipo(@PathVariable String tipo) {return riferimentoRepository.getByTipo(tipo);}
    public List<Riferimento> getByDOISearch(@PathVariable int doi) {return riferimentoRepository.getByDOISearch(doi);}

    public List<Riferimento> getByCategoria(@PathVariable int categoriaID) {return riferimentoRepository.getByCategoria(categoriaID);}

    public List<Riferimento> getCitazioniByUserId(@PathVariable int userID) { return riferimentoRepository.getCitazioniByUserId(userID);}

    public Integer getNextId(){return riferimentoRepository.getNextId();}

    public void update(Riferimento riferimento)
    {
        riferimentoRepository.save(riferimento);
    }

    public void updateAutore(int riferimentoID, int oldAutore, int newAutore) {
        riferimentoRepository.updateAutore(riferimentoID, oldAutore, newAutore);
    }

    public void updateCategoria(int riferimentoID, int oldCategoria, int newCategoria) {
        riferimentoRepository.updateCategoria(riferimentoID, oldCategoria, newCategoria);
    }

    public void updateCitazione(int riferimentoID, int oldCitato, int newCitato) {
        riferimentoRepository.updateCitazione(riferimentoID, oldCitato, newCitato);
    }

    public void aggiungiAutore(Riferimento riferimento, int autoreID) {
        riferimentoRepository.insertAutoreRiferimento(riferimento.getIdRiferimento(), autoreID);
    }

    public void aggiungiCategoria(Riferimento riferimento, int categoriaID) {
        riferimentoRepository.insertCategoriaRiferimento(riferimento.getIdRiferimento(), categoriaID);
    }

    public void aggiungiCitazione(Riferimento riferimento, int citanteID) {
        riferimentoRepository.insertRiferimentoCitante(riferimento.getIdRiferimento(), citanteID);
    }

    public void create(Riferimento riferimento, int userID, int categoriaID, Integer riferimentoCitatoID)
    {
        if(riferimentoRepository.save(riferimento) != null) {
            Integer rif_id = getRiferimentoByNome(riferimento.getTitolo_riferimento()).getIdRiferimento();
            riferimentoRepository.insertAutoreRiferimento(rif_id, userID);
            riferimentoRepository.insertCategoriaRiferimento(rif_id, categoriaID);
            if(riferimentoCitatoID != -1) riferimentoRepository.insertRiferimentoCitante(riferimentoCitatoID, rif_id);
        }
    }

    public void delete(Integer riferimentoId)
    {
        riferimentoRepository.deleteById(riferimentoId);
    }

    public void deleteRiferimentoAutore(int riferimentoID, int autoreID) {
        riferimentoRepository.deleteAutore(riferimentoID, autoreID);
    }

    public void deleteRifeirmentoCategoria(int riferimentoID, int categoriaID) {
        riferimentoRepository.deleteCategoria(riferimentoID, categoriaID);
    }

    public void deleteRiferimentoCitazione(int riferimentoID, int citazioneID) {
        riferimentoRepository.deleteRiferimentoCitazione(riferimentoID, citazioneID);
    }

}
