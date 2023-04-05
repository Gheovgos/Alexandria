package Repository;

import Model.Riferimento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RiferimentoRepository extends JpaRepository<Riferimento, Integer> {

    @Query(value = "SELECT riferimenti_biblio.* FROM riferimenti_biblio NATURAL JOIN autore_riferimento WHERE id_utente = ?1", nativeQuery = true)
    Optional<List<Riferimento>> getRiferimentoByUserId(String id_utente);

    @Query(value = "SELECT * FROM riferimenti_biblio WHERE titolo_riferimento = ?1", nativeQuery = true)
    Optional<Riferimento> getRiferimentoByNome(String titolo_riferimento);

    @Query(value = "SELECT riferimenti_biblio.* FROM riferimenti_biblio JOIN associazione_riferimenti ON riferimenti_biblio.id_riferimento = associazione_riferimenti.id_riferimento AND id_riferimento_associato = ?1",
    nativeQuery = true)
    Optional<List<Riferimento>> getByRiferimento(String riferimento_associato);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria WHERE titolo_riferimento LIKE ?1", nativeQuery = true)
    Optional<List<Riferimento>> getByTitoloSearch(String titolo_riferimento);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria , " +
            "autore_riferimento,utente WHERE autore_riferimento.id_riferimento = riferimenti_biblio.id_riferimento AND autore_riferimento.id_utente = utente.id_utente AND (nome_utente LIKE ?1 OR cognome_utente LIKE ?1",
    nativeQuery = true)
    Optional<List<Riferimento>> getByAutoreSearch(String testo);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria WHERE doi = ?1", nativeQuery = true)
    Optional<List<Riferimento>> getByDOISearch(String doi);

    @Query(value = "SELECT MAX(Id_riferimento) FROM riferimenti_biblio", nativeQuery = true)
    Optional<Integer> getNextId();
}
