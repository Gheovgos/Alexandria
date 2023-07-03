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
    test('Creazione riferimento', () async {
      primo_riferimento = Riferimento(
        0,
        'TestRiferimento',
        DateTime.now(),
        tipo_enum.Conferenza,
        null,
        null,
        false,
        'descr_riferimento',
        null,
        null,
        null,
        'luogo',
        null,
        null,
        null,
      );
      primo_riferimento =
          await networkHelper.createRiferimento(primo_riferimento, (await networkHelper.getCategoriaById(1))!, 1);
      expect('TestRiferimento', primo_riferimento?.titolo_riferimento);
      expect(tipo_enum.Conferenza, primo_riferimento?.tipo);
      expect('descr_riferimento', primo_riferimento?.descr_riferimento);
      expect('luogo', primo_riferimento?.luogo);
    });
    test('Test eliminazione riferimento', () async {
      var eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, true);
      eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, false);
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
