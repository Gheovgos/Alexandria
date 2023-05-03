package Service;

import Model.Categoria;
import Repository.CategoriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class CategoriaService {
    private final CategoriaRepository categoriaRepository;
    @Autowired
    public CategoriaService(CategoriaRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public List<Categoria> getCategorie()

    {
        return categoriaRepository.findAll();
    }

    public Optional<Categoria> getCategoriaById(Integer categoriaId)
    {
        return categoriaRepository.findById(categoriaId);
    }

    public void update(Categoria categoria)
    {
        categoriaRepository.save(categoria);
    }

    public void create(Categoria categoria)
    {
        categoriaRepository.save(categoria);
    }

    public void delete(Integer categoriaId)
    {
        categoriaRepository.deleteById(categoriaId);
    }

    public Categoria getCategoriaByRiferimento(String id_riferimento) {return categoriaRepository.getCategoriaByRiferimento(id_riferimento);}

    public Categoria getCategoriaByName(String name) {return categoriaRepository.getCategoriaByName(name);}

    public Integer getNextId() {return categoriaRepository.getNextId();}
}
