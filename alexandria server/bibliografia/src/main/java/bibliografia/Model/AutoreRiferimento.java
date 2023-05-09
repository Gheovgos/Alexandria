package bibliografia.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "autore_riferimento")
public class AutoreRiferimento {
    @EmbeddedId
    @ManyToOne
    @JoinColumn(name = "user_id")
    private Utente user_id;

    @Column
    private String descr_utente;

    @EmbeddedId
    @ManyToOne
    @JoinColumn(name = "id_riferimento")
    private Riferimento id_riferimento;

    @Column
    private Integer ordine;

    public AutoreRiferimento(Utente userId, String descr_utente, Riferimento riferimento, Integer ordine) {
        this.user_id = userId;
        this.descr_utente = descr_utente;
        this.id_riferimento = riferimento;
        this.ordine = ordine;
    }
}
