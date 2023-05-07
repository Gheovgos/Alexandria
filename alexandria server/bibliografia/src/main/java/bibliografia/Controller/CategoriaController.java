package bibliografia.Controller;

import bibliografia.Dto.*;
import bibliografia.Model.Categoria;
import bibliografia.Service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(path = "/categoria")
public class CategoriaController {

    @Autowired
    private final CategoriaService categoriaService;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    public CategoriaController(CategoriaService categoriaService)
    {
        this.categoriaService = categoriaService;
    }

    @GetMapping("/get/findAll")
    public List<CategoriaDto> findAll()
    {
        List<Categoria> categorie = categoriaService.getCategorie();
        List<CategoriaDto> categorieDto = new ArrayList<>();
        for(Categoria categoria : categorie)
            categorieDto.add(convertDto(categoria));

        return categorieDto;
    }


    @GetMapping("/get/getCategoriaById/{categoriaId}")
    public CategoriaDto getCategoriaById(@PathVariable String categoriaId)
    {
        Categoria categoria = categoriaService.getCategoriaById(categoriaId);
        CategoriaDto categoriaDto = convertDto(categoria);
        return categoriaDto;
    }

    @GetMapping("/get/getCategoriaByRiferimento/{id_riferimento}")
    public CategoriaDto getCategoriaByRiferimento(@PathVariable String id_riferimento)
    {
        Categoria categoria = categoriaService.getCategoriaByRiferimento(id_riferimento);
        CategoriaDto categoriaDto = convertDto(categoria);
        return categoriaDto;
    }

    @GetMapping("/get/getCategoriaByName/{name}")
    public CategoriaDto getCategoriaByName(@PathVariable String name)
    {
        Categoria categoria = categoriaService.getCategoriaByName(name);
        CategoriaDto categoriaDto = convertDto(categoria);
        return categoriaDto;
    }

    @GetMapping("/get/getNextId")
    public Integer getNextId()
    {
        Integer id = categoriaService.getNextId();
        return id;
    }


    @PostMapping("/create")
    public void create(@RequestBody CategoriaDto categoriaDto)
    {
        categoriaService.create(convertEntity(categoriaDto));
    }


    @PutMapping("/update")
    public void update(@RequestBody CategoriaDto categoriaDto)
    {
        Categoria categoria = convertEntity(categoriaDto);
        categoriaService.update(categoria);
    }

    @DeleteMapping("/delete")
    public void delete(@RequestBody CategoriaDto categoriaDto)
    {
        Categoria categoria = convertEntity(categoriaDto);
        categoriaService.delete(categoria.getId_Cat());
    }


    private Categoria convertEntity(CategoriaDto categoriaDto)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        Categoria categoria = new Categoria();
        categoria = modelMapper.map(categoriaDto, Categoria.class);

        return categoria;
    }

    public CategoriaDto convertDto(Categoria categoria)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        CategoriaDto categoriaDto = new CategoriaDto();
        categoriaDto = modelMapper.map(categoria, CategoriaDto.class);

        categoriaDto.setAutore(categoria.getAutore());
        categoriaDto.setId_Cat(categoria.getId_Cat());
        categoriaDto.setNome(categoria.getNome());
        categoriaDto.setId_Generaliz(categoria.getGeneraliz());

        return categoriaDto;
    }
}
