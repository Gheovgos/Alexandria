package bibliografia.Service;

import bibliografia.Repository.UtenteRepository;
import bibliografia.Model.Utente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Component
public class UtenteService {
    private final UtenteRepository utenteRepository;
    @Autowired
    public UtenteService(UtenteRepository utenteRepository) {
        this.utenteRepository = utenteRepository;
    }

    public List<Utente> getUtenti()
    {
        return utenteRepository.findAll();
    }

    public Utente getUtenteById(@PathVariable int utenteId) {
        return utenteRepository.getUtenteById(utenteId);
    }

    public Utente login(String username, String password) { return utenteRepository.login(username, password); }

    public List<Utente> getAutoriByRiferimento(@PathVariable int id_riferimento) {return utenteRepository.getAutoriByRiferimento(id_riferimento);}

    public Utente getByUsername(@PathVariable String username) {return utenteRepository.getByUsername(username);}

    public Integer getNextId() {return utenteRepository.getNextId();}

    public void update(Utente utente)
    {
        utenteRepository.save(utente);
    }

    public void create(Utente utente)
    {
        utenteRepository.save(utente);
    }

    public void delete(int utenteId)
    {
        utenteRepository.deleteById(utenteId);
    }
}
