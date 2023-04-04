package Repository;

import Model.Riferimento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RiferimentoRepository extends JpaRepository<Riferimento, Integer> {
}
