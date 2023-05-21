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

    public List<Riferimento> getByRiferimento(@PathVariable String riferimento_associato) {return riferimentoRepository.getByRiferimento(riferimento_associato);}

    public List<Riferimento> getByTitoloSearch(@PathVariable String titolo_riferimento) {return riferimentoRepository.getByTitoloSearch(titolo_riferimento);}

    public List<Riferimento> getByAutoreSearch(@PathVariable String testo) {return riferimentoRepository.getByAutoreSearch(testo);}

    public List<Riferimento> getByDOISearch(@PathVariable String doi) {return riferimentoRepository.getByDOISearch(doi);}

    public Integer getNextId(){return riferimentoRepository.getNextId();}

    public void update(Riferimento riferimento)
    {
        riferimentoRepository.save(riferimento);
    }

    public void create(Riferimento riferimento, int userID)
    {
        riferimentoRepository.save(riferimento);

        Integer rif_id = getRiferimentoByNome(riferimento.getTitolo_riferimento()).getIdRiferimento();
        riferimentoRepository.insertAutoreRiferimento(rif_id, userID);
    }

    public void delete(Integer riferimentoId)
    {
        riferimentoRepository.deleteById(riferimentoId);
    }

}
