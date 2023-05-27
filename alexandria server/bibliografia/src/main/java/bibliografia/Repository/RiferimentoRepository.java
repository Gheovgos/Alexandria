package bibliografia.Repository;

import bibliografia.Model.Riferimento;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

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

    @Query(value = "SELECT riferimenti_biblio.* \n" +
            "FROM riferimenti_biblio JOIN riferimenti_biblio_riferimento_citante ON riferimenti_biblio.id_riferimento = riferimenti_biblio_riferimento_citante.riferimento_citante_id_riferimento WHERE riferimenti_biblio_riferimento_citante.riferimento_citato_id_riferimento = ?1",
            nativeQuery = true)
    List<Riferimento> getRiferimentoCitanti(int riferimento_associato);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio JOIN riferimenti_biblio_categorie ON riferimenti_biblio.id_riferimento = riferimenti_biblio_categorie.riferimento_id_riferimento  WHERE riferimenti_biblio_categorie.categorie_id_categoria = :categoriaID", nativeQuery = true)
    List<Riferimento> getByCategoria(@Param("categoriaID") int categoriaID);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio WHERE descrizione LIKE %:descr%", nativeQuery = true)
    List<Riferimento> getByDescrizione(@Param("descr") String descr);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio, riferimenti_biblio_user_id, utente WHERE riferimenti_biblio_user_id.riferimento_id_riferimento = riferimenti_biblio.id_riferimento AND riferimenti_biblio_user_id.utente_user_id = utente.user_id AND (nome LIKE %:nome% OR cognome LIKE %:cognome%)",
    nativeQuery = true)
    List<Riferimento> getByAutoreSearch(@Param("nome") String nome, @Param("cognome") String cognome);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio WHERE doi = ?1", nativeQuery = true)
    List<Riferimento> getByDOISearch(int doi);

    @Query(value = "SELECT DISTINCT riferimenti_biblio.* FROM riferimenti_biblio WHERE cast(tipo as varchar) = :tipo", nativeQuery = true)
    List<Riferimento> getByTipo(@Param("tipo") String tipo);

    @Query(value = "SELECT rb.* FROM riferimenti_biblio AS rb JOIN riferimenti_biblio_riferimento_citante AS rbc ON rb.id_riferimento = rbc.riferimento_citante_id_riferimento JOIN riferimenti_biblio_user_id AS rbui ON rb.id_riferimento = rbui.riferimento_id_riferimento WHERE rbui.utente_user_id = :userID ", nativeQuery = true)
    List<Riferimento> getCitazioniByUserId(@Param("userID") int userID);

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
    @Query(value = "UPDATE riferimenti_biblio_user_id SET utente_user_id = :newAutore WHERE riferimento_id_riferimento = :id_riferimento AND utente_user_id = :oldAutore ;", nativeQuery = true)
    @Transactional
    void updateAutore(@Param("id_riferimento") int id_riferimento, @Param("oldAutore") int oldAutore, @Param("newAutore") int newAutore);


    @Modifying
    @Query(value = "UPDATE riferimenti_biblio_categorie SET categorie_id_categoria = :newCategoria WHERE riferimento_id_riferimento = :id_riferimento AND categorie_id_categoria = :oldCategoria ;", nativeQuery = true)
    @Transactional
    void updateCategoria(@Param("id_riferimento") int id_riferimento, @Param("oldCategoria") int oldCategoria, @Param("newCategoria") int newCategoria);


    @Modifying
    @Query(value = "UPDATE riferimenti_biblio_riferimento_citante SET riferimento_citato_id_riferimento = :newCitato WHERE riferimento_citante_id_riferimento = :id_riferimento AND riferimento_citato_id_riferimento = :oldCitato ;", nativeQuery = true)
    @Transactional
    void updateCitazione(@Param("id_riferimento") int id_riferimento, @Param("oldCitato") int oldCitato, @Param("newCitato") int newCitato);

    @Modifying
    @Query(value = "DELETE FROM riferimenti_biblio_user_id WHERE riferimento_id_riferimento = :id_riferimento AND utente_user_id = :userID", nativeQuery = true)
    @Transactional
    void deleteAutore(@Param("id_riferimento") int id_riferimento, @Param("userID") int userID);

    @Modifying
    @Query(value = "DELETE FROM riferimenti_biblio_categorie WHERE riferimento_id_riferimento = :id_riferimento AND categorie_id_categoria = :categoriaID", nativeQuery = true)
    @Transactional
    void deleteCategoria(@Param("id_riferimento") int id_riferimento, @Param("categoriaID") int categoriaID);

    @Modifying
    @Query(value = "DELETE FROM riferimenti_biblio_riferimento_citante WHERE riferimento_citante_id_riferimento = :id_riferimento AND riferimento_citante_id_riferimento = :citanteID", nativeQuery = true)
    @Transactional
    void deleteRiferimentoCitazione(@Param("id_riferimento") int id_riferimento, @Param("citanteID") int citanteID);
}
