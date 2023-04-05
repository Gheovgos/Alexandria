package Service;

import Repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import Model.Utente;

import java.util.List;
import java.util.Optional;

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

    public Optional<Utente> getUtenteById(Integer utenteId) {
        return utenteRepository.findById(utenteId);
    }

    public void update(Utente utente)
    {
        utenteRepository.save(utente);
    }

    public void create(Utente utente)
    {
        utenteRepository.save(utente);
    }

    public void delete(Integer utenteId)
    {
        utenteRepository.deleteById(utenteId);
    }
}
