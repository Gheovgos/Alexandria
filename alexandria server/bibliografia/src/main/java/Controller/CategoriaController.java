package Controller;

import Dto.CategoriaDto;
import Model.Categoria;
import Service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(path = "api/v1/categoria")
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

    @GetMapping("/get/getAll")
    public List<CategoriaDto> findAll()
    {
        List<Categoria> categorie = categoriaService.getCategorie();
        List<CategoriaDto> categorieDto = new ArrayList<>();
        for(Categoria categoria : categorie)
            categorieDto.add(convertDto(categoria));

        return categorieDto;
    }


    @GetMapping("/get/getCategoriaByRiferimento/{id_riferimento}")
    public CategoriaDto getCategoriaByRiferimento(@PathVariable String id_riferimento)
    {
        Categoria categoria = categoriaService.
    }


    @PostMapping("/create")
    public void create(@RequestBody CategoriaDto categoriaDto)
    {
        categoriaService.create(convertEntity(categoriaDto));
    }


    public void update(@RequestBody CategoriaDto categoriaDto)
    {
        Categoria categoria = convertEntity(categoriaDto);
        categoriaService.update(categoria);
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
