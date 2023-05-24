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

    @GetMapping("get/getByTipo/{tipo}")
    public List<RiferimentoDto> getByTipo(@PathVariable String tipo)
    {
        List<Riferimento> riferimenti = riferimentoService.getByTipo(tipo);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getByRiferimento/{riferimento_citante}")
    public List<RiferimentoDto> getByRiferimento(@PathVariable int riferimento_citante)
    {
        List<Riferimento> riferimenti = riferimentoService.getByRiferimento(riferimento_citante);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }


    @GetMapping("get/getByDescrizione/{descrizione}")
    public List<RiferimentoDto> getByDescrizione(@PathVariable String descrizione)
    {
        List<Riferimento> riferimenti = riferimentoService.getByDescrizione(descrizione);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getByAutoreSearch/{nome}/{cognome}")
    public List<RiferimentoDto> getByAutoreSearch(@PathVariable String nome, @PathVariable String cognome)
    {
        List<Riferimento> riferimenti = riferimentoService.getByAutoreSearch(nome, cognome);
        List<RiferimentoDto> riferimentiDto = new ArrayList<>();
        for(Riferimento riferimento : riferimenti)
            riferimentiDto.add(convertDto(riferimento));

        return riferimentiDto;
    }

    @GetMapping("get/getByDOISearch/{doi}")
    public List<RiferimentoDto> getByDOISearch(@PathVariable int doi)
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

    @PutMapping("/update/riferimentoAutore/{idRiferimento}/{oldAutore}/{newAutore}")
    public void updateAutore(@PathVariable int idRiferimento, @PathVariable int oldAutore, @PathVariable int newAutore) {
        riferimentoService.updateAutore(idRiferimento, oldAutore, newAutore);
    }

    @PutMapping("/update/riferimentoCategoria/{idRiferimento}/{oldCategoria}/{newCategoria}")
    public void updateCategoria(@PathVariable int idRiferimento, @PathVariable int oldCategoria, @PathVariable int newCategoria) {
        riferimentoService.updateCategoria(idRiferimento, oldCategoria, newCategoria);
    }

    @PutMapping("/update/riferimentoCitazione/{idRiferimento}/{oldCitato}/{newCitato}")
    public void updateCitazione(@PathVariable int idRiferimento, @PathVariable int oldCitato, @PathVariable int newCitato) {
        riferimentoService.updateCitazione(idRiferimento, oldCitato, newCitato);
    }

    @DeleteMapping("/delete/{idRiferimento}")
    public void delete(@PathVariable int idRiferimento)
    {
        riferimentoService.delete(idRiferimento);
    }

    @DeleteMapping("/delete/riferimentoAutore/{idRiferimento}/{autoreID}")
    public void deleteRiferimentoAutore(@PathVariable int idRiferimento, @PathVariable int autoreID)
    {
        riferimentoService.deleteRiferimentoAutore(idRiferimento, autoreID);
    }

    @DeleteMapping("/delete/riferimentoCategoria/{idRiferimento}/{categoriaID}")
    public void deleteRiferimentoCategoria(@PathVariable int idRiferimento, @PathVariable int categoriaID)
    {
        riferimentoService.deleteRifeirmentoCategoria(idRiferimento, categoriaID);
    }

    @DeleteMapping("/delete/riferimentoCitazione/{idRiferimento}/{citazioneID}")
    public void deleteRiferimentoCitazione(@PathVariable int idRiferimento, @PathVariable int citazioneID)
    {
        riferimentoService.deleteRiferimentoCitazione(idRiferimento, citazioneID);
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

        riferimentoDto.setDescrizione(riferimento.getDescrizione());
        riferimentoDto.setOn_line(riferimento.getOnline());
        riferimentoDto.setDOI(riferimento.getDoi());
        riferimentoDto.setTipo(riferimentoDto.getTipo());
        riferimentoDto.setURL(riferimento.getUrl());
        riferimentoDto.setId_Rif(riferimentoDto.getId_Rif());
        riferimentoDto.setTitolo(riferimento.getTitolo_riferimento());
        riferimentoDto.setDataCreazione(riferimento.getData_riferimento());
        riferimentoDto.setPag_fine(riferimento.getPag_fine());

        return riferimentoDto;
    }

}
