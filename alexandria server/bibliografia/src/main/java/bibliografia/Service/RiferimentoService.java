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

    public List<Riferimento> getByTitoloSearch(@PathVariable String titolo_riferimento) {return riferimentoRepository.getByTitoloSearch(titolo_riferimento);}

    public List<Riferimento> getByAutoreSearch(@PathVariable String nome, String cognome) {return riferimentoRepository.getByAutoreSearch(nome, cognome);}

    public List<Riferimento> getByDOISearch(@PathVariable int doi) {return riferimentoRepository.getByDOISearch(doi);}

    public Integer getNextId(){return riferimentoRepository.getNextId();}

    public void update(Riferimento riferimento, int autoreID, int categoriaID, int citatoID)
    {
        riferimentoRepository.save(riferimento);
       // if(autoreID != -1) riferimentoRepository.updateAutore();
       // if(categoriaID != -1) riferimentoRepository.updateCategoria();
       //  if(citatoID != -1) riferimentoRepository.updateCitazione();
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

}
