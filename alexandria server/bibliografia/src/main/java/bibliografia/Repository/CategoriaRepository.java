package bibliografia.Repository;

import bibliografia.Model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.List;

@Repository

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    @Query(value = "SELECT DISTINCT * FROM categoria WHERE id_categoria = ?1", nativeQuery = true)
    Categoria getCategoriaById(int id_categoria);

    @Query(value = "SELECT categoria.* FROM categoria JOIN riferimento_biblio_categorie ON categoria.id_categoria = riferimento_biblio_categorie.categorie_id_categoria \n" +
            "WHERE riferimento_id_riferimento = ?1", nativeQuery = true)
    Categoria getCategoriaByRiferimento(int id_riferimento);

    @Query(value = "SELECT DISTINCT * FROM categoria WHERE descr_categoria = ?1", nativeQuery = true)
    Categoria getCategoriaByName(String descr_categoria);

    @Query(value = "SELECT super_cat(:categoriaID)", nativeQuery = true)
    List<Integer> getSopraCategorie(@Param("categoriaID") int categoriaID);

    @Query(value = "SELECT MAX(id_categoria) FROM categoria", nativeQuery = true)
    Integer getNextId();


}
