package Repository;

import Model.Utente;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UtenteRepository extends JpaRepository<Utente, Integer> {

    @Query(value = "SELECT utente.* FROM utente NATURAL JOIN autore_riferimento WHERE id_riferimento = ?1", nativeQuery = true)
    Optional<List<Utente>> getByRiferimentoId(String id_riferimento);

    @Query(value = "SELECT MAX(id_utente) FROM utente", nativeQuery = true)
    Optional<Integer> getNextId();
 }
