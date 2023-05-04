package bibliografia.Repository;

import bibliografia.Model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UtenteRepository extends JpaRepository<Utente, Integer> {


    @Query(value = "SELECT DISTINCT * FROM utente WHERE id_utente = ?1", nativeQuery = true)
    Utente getUtenteById(String id_utente);

    @Query(value = "SELECT utente.* FROM utente NATURAL JOIN autore_riferimento WHERE id_riferimento = ?1", nativeQuery = true)
    List<Utente> getByRiferimentoId(String id_riferimento);

    @Query(value = "SELECT MAX(id_utente) FROM utente", nativeQuery = true)
    Integer getNextId();
 }
