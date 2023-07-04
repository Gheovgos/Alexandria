import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/globals.dart';
import 'package:test/test.dart';

void main() {
  group('Test categorie', () {
    Categoria? prima_categoria;
    Categoria? seconda_categoria;
    test('Creazione categoria', () async {
      expect(await networkHelper.createCategoria('', 1, null), null); //CE1 CE4 CE5
      expect(await networkHelper.createCategoria('WECT 1', -100, null), null); //CE2 CE3 CE5
      expect(await networkHelper.createCategoria('WECT 2', 10, -5), null); //CE2 CE4 CE6
      expect(await networkHelper.createCategoria('WECT 3', 10, null) != null, true); //CE2 CE4 CE5
      expect(await networkHelper.createCategoria('WECT 4', 10, 20) != null, true); //CE2 CE4 CE7
    });
    test('Test sopra-categoria', () async {
      final cat = await networkHelper.createCategoria('TestCategoria2', 1, prima_categoria?.id_categoria);
      final sopraCategorie = await networkHelper.getSopraCategorie(cat!.id_categoria);
      seconda_categoria = cat;
      expect(sopraCategorie?[0], prima_categoria?.id_categoria);
      expect(sopraCategorie, null);
    });
    test('Test eliminazione categoria', () async {
      final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
      final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
      expect(eliminaPrimaCategoria, true);
      expect(eliminaSecondaCategoria, true);
    });
  });

  group('Test riferimenti', () {
    Riferimento? primo_riferimento;
    test('Test Creazione riferimento', () async {
      expect( await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(-1), (await networkHelper.getCategoriaById(10))!, 10,),
        null,); //CE1 CE4 CE6

      expect(await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(10), (await networkHelper.getCategoriaById(12))!, -4,
        ),
        null,
      ); //CE2 CE4 CE5

      expect(
        await networkHelper.createRiferimento( await networkHelper.getRiferimentoById(10), (await networkHelper.getCategoriaById(12))!, 40,
        ) != null,
        true,
      ); //CE2 CE4 CE6
    });

    test('Test Ricerca Riferimento', () async {
      List<Categoria> categoriaPiena = [(await networkHelper.getCategoriaById(1))!];
      List<tipo_enum> tipoPiena = [tipo_enum.Libro];

      expect(await networkHelper.ricerca('', 10, 'autore', categoriaPiena, tipoPiena), []); //CE2 CE5 CE7 CE9

      expect(await networkHelper.ricerca(null, 10, 'autore', categoriaPiena, []), []); //CE1 CE5 CE7 CE8

      expect(await networkHelper.ricerca(null, 10, 'autore', categoriaPiena, tipoPiena), []); //CE1 CE5 CE7 CE9

      expect(await networkHelper.ricerca('Ricerca bug', null, null, [], tipoPiena) != [], true); //CE3 CE4 CE6 CE9

      for (var i = 0; i < 6; i++) {
        tipoPiena.add(tipo_enum.Libro);
      }

      expect(await networkHelper.ricerca(null, 10, 'autore', categoriaPiena, tipoPiena), []); //CE1 CE5 CE7 CE10

    });
    test('Test eliminazione riferimento', () async {
      var eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, true);
      eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, false);
    });
    test('Test Aggiungere Citazione', () async {

      expect(await networkHelper.aggiungiCitazione((await networkHelper.getRiferimentoById(8))!, -10, ), false,); //CE1 CE2

      expect(await networkHelper.aggiungiCitazione((await networkHelper.getRiferimentoById(8))!, 10,), true,); //CE1 CE3
    });

    test('Test aggiorna riferimento autore', () async {
      final riferimento = Riferimento(
        -1,
        'TestRiferimento',
        DateTime.now(),
        tipo_enum.Libro,
        null,
        null,
        false,
        'descr_riferimento',
        'editore',
        null,
        null,
        null,
        null,
        null,
        null,
      );
      var aggiornaRiferimentoAutore = await networkHelper.aggiornaRiferimentoAutore(riferimento, 1, 2);
      expect(aggiornaRiferimentoAutore, true);
      aggiornaRiferimentoAutore = await networkHelper.aggiornaRiferimentoAutore(riferimento, 2, -2);
      expect(aggiornaRiferimentoAutore, false);
    });
  });
}
