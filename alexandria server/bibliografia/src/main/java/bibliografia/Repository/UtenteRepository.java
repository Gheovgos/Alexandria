package bibliografia.Repository;

import bibliografia.Model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UtenteRepository extends JpaRepository<Utente, Integer> {


    @Query(value = "SELECT DISTINCT * FROM utente WHERE user_id = :user_id", nativeQuery = true)
    Utente getUtenteById(@Param("user_id") int id_utente);

    @Query(value = "SELECT utente.* FROM utente NATURAL JOIN autore_riferimento WHERE id_riferimento = ?1", nativeQuery = true)
    List<Utente> getByRiferimentoId(String id_riferimento);

    @Query(value = "SELECT MAX(id_utente) FROM utente", nativeQuery = true)
    Integer getNextId();
 }
