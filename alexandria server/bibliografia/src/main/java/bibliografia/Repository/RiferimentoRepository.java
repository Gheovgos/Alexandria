package bibliografia.Repository;

import bibliografia.Model.Riferimento;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RiferimentoRepository extends JpaRepository<Riferimento, Integer> {


    @Query(value = "SELECT DISTINCT * FROM riferimenti_biblio WHERE id_riferimento = ?1", nativeQuery = true)
    Riferimento getRiferimentoById(int id_riferimento);

    @Query(value = "SELECT riferimenti_biblio.* FROM riferimenti_biblio JOIN riferimenti_biblio_user_id ON riferimenti_biblio.id_riferimento = riferimenti_biblio_user_id.riferimento_id_riferimento WHERE utente_user_id = ?1", nativeQuery = true)
    List<Riferimento> getRiferimentoByUserId(int id_utente);

    @Query(value = "SELECT * FROM riferimenti_biblio WHERE titolo_riferimento = ?1", nativeQuery = true)
    Riferimento getRiferimentoByNome(String titolo_riferimento);

    @Query(value = "SELECT riferimenti_biblio.* FROM riferimenti_biblio JOIN associazione_riferimenti ON riferimenti_biblio.id_riferimento = associazione_riferimenti.id_riferimento AND id_riferimento_associato = ?1",
    nativeQuery = true)
    List<Riferimento> getByRiferimento(String riferimento_associato);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria WHERE titolo_riferimento LIKE ?1", nativeQuery = true)
    List<Riferimento> getByTitoloSearch(String titolo_riferimento);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria , " +
            "autore_riferimento,utente WHERE autore_riferimento.id_riferimento = riferimenti_biblio.id_riferimento AND autore_riferimento.id_utente = utente.id_utente AND (nome_utente LIKE ?1 OR cognome_utente LIKE ?1",
    nativeQuery = true)
    List<Riferimento> getByAutoreSearch(String testo);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria WHERE doi = ?1", nativeQuery = true)
    List<Riferimento> getByDOISearch(String doi);

    @Query(value = "SELECT MAX(id_riferimento) FROM riferimenti_biblio", nativeQuery = true)
    Integer getNextId();

    @Modifying
    @Query(value = "INSERT INTO riferimenti_biblio_user_id VALUES (:utente_user_id, :id_riferimento_id_riferimento)", nativeQuery = true)
    @Transactional

    void insertAutoreRiferimento(@Param("id_riferimento_id_riferimento") int id_riferimento_id_riferimento, @Param("utente_user_id") int utente_user_id);
}
