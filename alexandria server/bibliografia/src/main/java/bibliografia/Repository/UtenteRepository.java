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

    @Query(value = "SELECT * FROM utente WHERE username = ?1", nativeQuery = true)
    Utente getByUsername(String username);

    @Query(value = "SELECT utente.* FROM utente, riferimenti_biblio_user_id WHERE utente.user_id = riferimenti_biblio_user_id.utente_user_id AND riferimenti_biblio_user_id.riferimento_id_riferimento = :riferimentoID", nativeQuery = true)
    List<Utente> getAutoriByRiferimento(@Param("riferimentoID") int riferimentoID);

    @Query(value = "SELECT MAX(user_id) FROM utente", nativeQuery = true)
    Integer getNextId();

    @Query(value = "SELECT * FROM utente WHERE username = :username AND password_hashed = :password_hashed", nativeQuery = true)
    Utente login(@Param("username") String username, @Param("password_hashed") String password_hashed);

 }
