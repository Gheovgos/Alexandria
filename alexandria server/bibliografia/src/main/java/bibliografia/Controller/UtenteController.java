package bibliografia.Controller;

import bibliografia.Model.Utente;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import bibliografia.Dto.UtenteDto;
import bibliografia.Service.UtenteService;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "/api/v1/utente")
public class UtenteController {

    @Autowired
    private final UtenteService utenteService;

     private ModelMapper modelMapper = new ModelMapper();

    @Autowired
    public UtenteController(UtenteService utenteService)
    {
        this.utenteService = utenteService;
    }

    @PostMapping("/create")
    public void create(@RequestBody UtenteDto utenteDto) { utenteService.create(convertEntity(utenteDto));}

    @PutMapping("/update")
    public void update(UtenteDto utenteDto)
    {
        utenteService.update(convertEntity(utenteDto));
    }

    @DeleteMapping("/delete")
    public void delete(UtenteDto utenteDto)
    {
        utenteService.delete(convertEntity(utenteDto).getUser_ID());
    }

    @GetMapping("/create/findAll")
    public List<UtenteDto> getUtenti()
    {
        List<Utente> utenti = utenteService.getUtenti();
        List<UtenteDto> utentiDto = new ArrayList<>();
        for(Utente utente : utenti)
            utentiDto.add(convertDto(utente));

        return utentiDto;
    }

    @GetMapping("/create/getUtenteById/{utenteId}")
    public UtenteDto getUtenteById(@PathVariable int utenteId)
    {
        Utente utente = utenteService.getUtenteById(utenteId);
        UtenteDto utenteDto = convertDto(utente);
        return utenteDto;
    }

    @GetMapping("/login/{username}/{password}")
    public Optional<Utente> login(@PathVariable String username, @PathVariable String password)
    {
        Optional<Utente> utente = Optional.ofNullable(utenteService.login(username, password));
        if(utente.isPresent()) {
            return utente;
        }
        else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "ERRORE: credenziali inserite non valide!");
        }
    }

    @GetMapping("/create/getByRiferimentoId/{id_riferimento}")
    public List<UtenteDto> getByRiferimentoId(@PathVariable String id_riferimento)
    {
        List<Utente> utenti = utenteService.getByRiferimentoId(id_riferimento);
        List<UtenteDto> utentiDto = new ArrayList<>();
        for(Utente utente : utenti)
            utentiDto.add(convertDto(utente));

        return utentiDto;
    }

    @GetMapping("/create/getNextId")
    public Integer getNextId()
    {
        return utenteService.getNextId();
    }

    public Utente convertEntity(UtenteDto utenteDto)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        Utente utente = new Utente();
        utente = modelMapper.map(utenteDto, Utente.class);
        return utente;
    }

    public UtenteDto convertDto(Utente utente)
    {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.LOOSE);
        UtenteDto utenteDto = new UtenteDto();
        utenteDto = modelMapper.map(utente, UtenteDto.class);

        utenteDto.setCognome(utente.getCognome());
        utenteDto.setNome(utente.getNome());
        utenteDto.setUser_ID(utente.getUser_ID());

        return utenteDto;
    }

}
