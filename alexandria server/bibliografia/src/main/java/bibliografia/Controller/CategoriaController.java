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
    private ModelMapper modelMapper = new ModelMapper();

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
    public CategoriaDto getCategoriaById(@PathVariable int categoriaId)
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


    @PostMapping("/create/{userID}")
    public void create(@RequestBody CategoriaDto categoriaDto, @PathVariable Integer userID)
    {
        categoriaService.create(convertEntity(categoriaDto, userID));
    }


    @PutMapping("/update/{userID}")
    public void update(@RequestBody CategoriaDto categoriaDto, @PathVariable Integer userID)
    {
        Categoria categoria = convertEntity(categoriaDto, userID);
        categoriaService.update(categoria);
    }

    @DeleteMapping("/delete")
    public void delete(@RequestBody CategoriaDto categoriaDto)
    {
        Categoria categoria = convertEntity(categoriaDto);
        categoriaService.delete(categoria.getId_categoria());
    }


    private Categoria convertEntity(CategoriaDto categoriaDto)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        Categoria categoria = new Categoria();
        categoria = modelMapper.map(categoriaDto, Categoria.class);

        return categoria;
    }

    private Categoria convertEntity(CategoriaDto categoriaDto, Integer user_id)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        Categoria categoria = new Categoria();
        categoria = modelMapper.map(categoriaDto, Categoria.class);
        categoria.setUser_id(user_id);

        return categoria;
    }

    public CategoriaDto convertDto(Categoria categoria)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        CategoriaDto categoriaDto = new CategoriaDto();
        categoriaDto = modelMapper.map(categoria, CategoriaDto.class);

        categoriaDto.setId_utente(categoria.getUser_id());
        categoriaDto.setId_categoria(categoria.getId_categoria());
        categoriaDto.setDescr_categoria(categoria.getDescr_categoria());
        categoriaDto.setId_super_categoria(categoria.getId_categoria());

        return categoriaDto;
    }
}
