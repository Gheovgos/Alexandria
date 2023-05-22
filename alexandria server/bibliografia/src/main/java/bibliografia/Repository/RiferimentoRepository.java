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

    @Query(value = "SELECT riferimenti_biblio.* \n" +
            "FROM riferimenti_biblio JOIN riferimenti_biblio_riferimento_citante ON riferimenti_biblio.id_riferimento = riferimenti_biblio_riferimento_citante.riferimento_citato_id_riferimento WHERE riferimenti_biblio_riferimento_citante.riferimento_citante_id_riferimento = ?1",
    nativeQuery = true)
    List<Riferimento> getByRiferimento(int riferimento_associato);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, associativa_riferimenti_categoria WHERE titolo_riferimento LIKE ?1", nativeQuery = true)
    List<Riferimento> getByTitoloSearch(String titolo_riferimento);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, riferimenti_biblio_user_id, utente WHERE riferimenti_biblio_user_id.riferimento_id_riferimento = riferimenti_biblio.id_riferimento AND riferimenti_biblio_user_id.utente_user_id = utente.user_id AND (nome LIKE %:nome% OR cognome LIKE %:cognome%)",
    nativeQuery = true)
    List<Riferimento> getByAutoreSearch(@Param("nome") String nome, @Param("cognome") String cognome);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio WHERE doi = ?1", nativeQuery = true)
    List<Riferimento> getByDOISearch(int doi);

    @Query(value = "SELECT MAX(id_riferimento) FROM riferimenti_biblio", nativeQuery = true)
    Integer getNextId();

    @Modifying
    @Query(value = "INSERT INTO riferimenti_biblio_user_id VALUES (:utente_user_id, :id_riferimento_id_riferimento)", nativeQuery = true)
    @Transactional

    void insertAutoreRiferimento(@Param("id_riferimento_id_riferimento") int id_riferimento_id_riferimento, @Param("utente_user_id") int utente_user_id);

    @Modifying
    @Query(value = "INSERT INTO riferimenti_biblio_categorie VALUES (:riferimento_id_riferimento, :categorie_id_categoria)", nativeQuery = true)
    @Transactional

    void insertCategoriaRiferimento(@Param("riferimento_id_riferimento") int riferimento_id_riferimento, @Param("categorie_id_categoria") int categorie_id_categoria);

    @Modifying
    @Query(value = "INSERT INTO riferimenti_biblio_riferimento_citante VALUES (:riferimento_citato_id_riferimento, :riferimento_citante_id_riferimento)", nativeQuery = true)
    @Transactional

    void insertRiferimentoCitante(@Param("riferimento_citato_id_riferimento") int riferimento_citato_id_riferimento, @Param("riferimento_citante_id_riferimento") int riferimento_citante_id_riferimento);

    @Modifying
    @Query(value = "UPDATE riferimenti_biblio_user_id SET utente_user_id = :id_utente, riferimento_id_riferimento :id_riferimento", nativeQuery = true)
    @Transactional
    void updateAutore(@Param("id_utente") Integer id_utente, @Param("id_riferimento") Integer id_riferimento);


    @Modifying
    @Query(value = "UPDATE riferimenti_biblio_categorie SET riferimento_id_riferimento = :id_riferimento, categoria_id_categoria = :id_categoria", nativeQuery = true)
    @Transactional
    void updateCategoria(@Param("id_riferimento") Integer id_riferimento, @Param("id_categoria") Integer id_categoria);


    @Modifying
    @Query(value = "UPDATE riferimenti_biblio_riferimento_citante SET riferimento_citante_id_riferimento = :id_riferimento, riferimento_citato_id_riferimento = :id_riferimento_associato", nativeQuery = true)
    @Transactional
    void updateCitazione(@Param("id_riferimento") Integer id_riferimento, @Param("id_riferimento_associato") Integer id_riferimento_associato);
}
