package Repository;

import Model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.Optional;

@Repository

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {
    @Query(value = "SELECT categoria.* FROM categoria NATURAL JOIN associativa_riferimenti_categoria WHERE id_riferimento = ?1", nativeQuery = true)
    Categoria getCategoriaByRiferimento(String id_riferimento);

    @Query(value = "SELECT id_categoria FROM categoria WHERE descr_categoria = ?1", nativeQuery = true)
    Categoria getCategoriaByName(String descr_categoria);

    @Query(value = "SELECT MAX(id_categoria) FROM categoria", nativeQuery = true)
    Integer getNextId();
}
