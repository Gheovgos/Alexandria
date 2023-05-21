package bibliografia.Controller;

import bibliografia.Dto.RiferimentoDto;
import bibliografia.Model.Riferimento;
import bibliografia.Service.RiferimentoService;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping(path = "/api/v1/riferimento/")
public class RiferimentoController {

    @Autowired
    private final RiferimentoService riferimentoService;

    @Autowired
    private ModelMapper modelMapper = new ModelMapper();

    @Autowired
    public RiferimentoController(RiferimentoService riferimentoService)
    {
        this.riferimentoService = riferimentoService;
    }

    @GetMapping("get/findAll")
    public List<RiferimentoDto> findAll()
    {
        List<Riferimento> riferimenti = riferimentoService.getRiferimenti();
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getRiferimentoById/{riferimentoId}")
    public RiferimentoDto getRiferimentoByID(@PathVariable int riferimentoId)
    {
        Riferimento riferimento = riferimentoService.getRiferimentoById(riferimentoId);
        RiferimentoDto riferimentoDto = convertDto(riferimento);
        return riferimentoDto;
    }

    @GetMapping("get/getRiferimentoByUserId/{user_id}")
    public List<RiferimentoDto> getRiferimentoByUserId(@PathVariable int user_id)
    {
        List<Riferimento> riferimenti = riferimentoService.getRiferimentoByUserId(user_id);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getRiferimentoByNome/{titolo_riferimento}")
    public RiferimentoDto getRiferimentoByNome(@PathVariable String titolo_riferimento)
    {
        Riferimento riferimento = riferimentoService.getRiferimentoByNome(titolo_riferimento);
        RiferimentoDto riferimentoDto = convertDto(riferimento);
        return riferimentoDto;
    }

    @GetMapping("get/getByRiferimento/{riferimento_associato}")
    public List<RiferimentoDto> getByRiferimento(@PathVariable String riferimento_associato)
    {
        List<Riferimento> riferimenti = riferimentoService.getByRiferimento(riferimento_associato);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }


    @GetMapping("get/getByTitoloSearch/{titolo_riferimento}")
    public List<RiferimentoDto> getByTitoloSearch(@PathVariable String titolo_riferimento)
    {
        List<Riferimento> riferimenti = riferimentoService.getByTitoloSearch(titolo_riferimento);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getByAutoreSearch/{testo}")
    public List<RiferimentoDto> getByAutoreSearch(@PathVariable String testo)
    {
        List<Riferimento> riferimenti = riferimentoService.getByAutoreSearch(testo);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getByDOISearch/{doi}")
    public List<RiferimentoDto> getByDOISearch(@PathVariable String doi)
    {
        List<Riferimento> riferimenti = riferimentoService.getByDOISearch(doi);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @PostMapping("/create/aggiungiAutore/{autoreID}")
    @ResponseBody
    public void aggiungiAutore(@RequestBody RiferimentoDto riferimentoDto, @PathVariable int autoreID) {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.aggiungiAutore(riferimento, autoreID);
    }

    @PostMapping("/create/aggiungiCategoria/{categoriaID}")
    @ResponseBody
    public void aggiungiCategoria(@RequestBody RiferimentoDto riferimentoDto, @PathVariable int categoriaID) {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.aggiungiCategoria(riferimento, categoriaID);
    }

    @PostMapping("/create/aggiungiCitazione/{citazioneID}")
    @ResponseBody
    public void aggiungiCitazione(@RequestBody RiferimentoDto riferimentoDto, @PathVariable int citazioneID) {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.aggiungiCitazione(riferimento, citazioneID);
    }


    @PostMapping("/create/{userID}/{categoriaID}/{riferimentoCitatoID}")
    @ResponseBody
    public void create(@RequestBody RiferimentoDto riferimentoDto, @PathVariable int userID, @PathVariable int categoriaID, @PathVariable Integer riferimentoCitatoID)
    {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.create(riferimento, userID, categoriaID, riferimentoCitatoID);
    }

    @PutMapping("/update")
    public void update(@RequestBody RiferimentoDto riferimentoDto)
    {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.update(riferimento);
    }

    @DeleteMapping("/delete")
    public void delete(@RequestBody RiferimentoDto riferimentoDto)
    {
        Riferimento riferimento = convertEntity(riferimentoDto);
        riferimentoService.delete(riferimento.getIdRiferimento());
    }

    public Riferimento convertEntity(RiferimentoDto riferimentoDto)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        Riferimento riferimento = new Riferimento();
        riferimento = modelMapper.map(riferimentoDto, Riferimento.class);

        return riferimento;
    }

    public RiferimentoDto convertDto(Riferimento riferimento)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        RiferimentoDto riferimentoDto = new RiferimentoDto();
        riferimentoDto = modelMapper.map(riferimento, RiferimentoDto.class);

        riferimentoDto.setDescrizione(riferimento.getDescr_riferimento());
        riferimentoDto.setDigitale(riferimento.getOnline());
        riferimentoDto.setDOI(riferimento.getDoi());
        riferimentoDto.setTipo(riferimentoDto.getTipo());
        riferimentoDto.setURL(riferimento.getUrl());
        riferimentoDto.setId_Rif(riferimentoDto.getId_Rif());
        riferimentoDto.setTitolo(riferimento.getTitolo_riferimento());
        //riferimentoDto.setDataCreazione(riferimento.getDataRiferimento());

        return riferimentoDto;
    }

}
