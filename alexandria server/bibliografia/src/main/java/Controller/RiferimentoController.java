package Controller;

import Service.RiferimentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/v1/riferimento")
public class RiferimentoController {

    private final RiferimentoService riferimentoService;
    @Autowired
    public RiferimentoController(RiferimentoService riferimentoService)
    {
        this.riferimentoService = riferimentoService;
    }

}
