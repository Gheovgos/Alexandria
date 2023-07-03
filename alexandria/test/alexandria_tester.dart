import 'dart:ffi';

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
      assert(await networkHelper.createCategoria("", 1, null) == null);            //CE1 CE4 CE5
      assert(await networkHelper.createCategoria("WECT 1", -100, null) == null)    //CE2 CE3 CE5
      assert(await networkHelper.createCategoria("WECT 2", 10, -5) == null)        //CE2 CE4 CE6
      assert(await networkHelper.createCategoria("WECT 3", 10, null) == null)      //CE2 CE4 CE5
      assert(await networkHelper.createCategoria("WECT 4", 10, 20) == null)        //CE2 CE4 CE7
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
      assert(await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(-1) as Riferimento,
          await networkHelper.getCategoriaById(10) as Categoria, 10) == null); //CE1 CE4 CE6

      assert(await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(10) as Riferimento,
          await networkHelper.getCategoriaById(-10) as Categoria, 10) == null); //CE2 CE3 CE6

      assert(await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(10) as Riferimento,
          await networkHelper.getCategoriaById(12) as Categoria, -4) == null); //CE2 CE4 CE5

      assert(await networkHelper.createRiferimento(await networkHelper.getRiferimentoById(10) as Riferimento,
          await networkHelper.getCategoriaById(12) as Categoria, 40) == null); //CE2 CE4 CE6

    });

    test('Test Ricerca Riferimento', () async {

      List<Categoria> categoriaPiena = [];
      categoriaPiena.add(await networkHelper.getCategoriaById(1) as Categoria);
      List<tipo_enum> tipoPiena = [];
      tipoPiena.add(tipo_enum.Libro);

      assert(await networkHelper.ricerca("", 10, "autore", categoriaPiena, tipoPiena) == null); //CE2 CE5 CE7 CE9

      assert(await networkHelper.ricerca(null, 10, "autore", categoriaPiena, []) == null); //CE1 CE5 CE7 CE8

      assert(await networkHelper.ricerca(null, 10, "autore", categoriaPiena, tipoPiena) == null); //CE1 CE5 CE7 CE9

      assert(await networkHelper.ricerca("Ricerca bug", null, null, [], tipoPiena) == null); //CE3 CE4 CE6 CE9

      for(int i = 0; i < 6; i++) tipoPiena.add(tipo_enum.Libro);

      assert(await networkHelper.ricerca(null, 10, "autore", categoriaPiena, tipoPiena) == null); //CE1 CE5 CE7 CE10

    });
    test('Test eliminazione riferimento', () async {
      var eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, true);
      eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, false);
    });
    test('Test Aggiungere Citazione', () async {
      assert(await networkHelper.aggiungiCitazione(await networkHelper.getRiferimentoById(-1) as Riferimento, 1));    //CE1 CE4
      assert(await networkHelper.aggiungiCitazione(await networkHelper.getRiferimentoById(8) as Riferimento, -10));   //CE2 CE3
      assert(await networkHelper.aggiungiCitazione(await networkHelper.getRiferimentoById(8) as Riferimento, 10));    //CE2 CE4
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
