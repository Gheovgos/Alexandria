package bibliografia.Repository;

import bibliografia.Model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    @Query(value = "SELECT DISTINCT * FROM categoria WHERE id_categoria = ?1", nativeQuery = true)
    Categoria getCategoriaById(int id_categoria);

    @Query(value = "SELECT categoria.* FROM categoria JOIN riferimento_biblio_categorie ON categoria.id_categoria = riferimento_biblio_categorie.categorie_id_categoria \n" +
            "WHERE riferimento_id_riferimento = ?1", nativeQuery = true)
    Categoria getCategoriaByRiferimento(int id_riferimento);

    @Query(value = "SELECT DISTINCT * FROM categoria WHERE descr_categoria = ?1", nativeQuery = true)
    Categoria getCategoriaByName(String descr_categoria);

    @Query(value = "SELECT MAX(id_categoria) FROM categoria", nativeQuery = true)
    Integer getNextId();


}
