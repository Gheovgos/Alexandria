package Controller;

import Service.UtenteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/v1/utente")
public class UtenteController {

    private final UtenteService utenteService;
    @Autowired
    public UtenteController(UtenteService utenteService)
    {
        this.utenteService = utenteService;
    }

}
