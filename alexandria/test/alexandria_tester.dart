import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/globals.dart';
import 'package:test/test.dart';

void main() {
  group('Test categorie', () {
    Categoria? prima_categoria;
    Categoria? seconda_categoria;
    test('Creazione categoria', () async {
      final cat = await networkHelper.createCategoria('TestCategoria', 1, null);
      expect('TestCategoria', cat?.nome);
      expect(null, cat?.super_Categoria);
      expect(1, cat?.user_id);
      prima_categoria = cat;
    });
    test('Test sopra-categoria', () async {
      final cat = await networkHelper.createCategoria('TestCategoria2', 1, prima_categoria?.id_categoria);
      final sopraCategorie = await networkHelper.getSopraCategorie(cat!.id_categoria);
      seconda_categoria = cat;
      expect(sopraCategorie?[0], prima_categoria?.id_categoria);
    });
    test('Test eliminazione categoria', () async {
      final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
      final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
      expect(eliminaPrimaCategoria, true);
      expect(eliminaSecondaCategoria, true);
    });
  });

  // group('Test riferimenti', ()
  // {
  //   Riferimento? primo_riferimento;
  //   Riferimento? secondo_riferimento;
  //   test('Creazione riferimento', () async {
  //     final cat = await networkHelper.createRiferimento('TestCategoria', 1, null);
  //     expect('TestCategoria', cat?.nome);
  //     expect(null, cat?.super_Categoria);
  //     expect(1, cat?.user_id);
  //     prima_categoria = cat;
  //   });
  //   test('Test sopra-categoria', () async {
  //     final cat = await networkHelper.createCategoria('TestCategoria2', 1, prima_categoria?.id_categoria);
  //     final sopraCategorie = await networkHelper.getSopraCategorie(cat!.id_categoria);
  //     seconda_categoria = cat;
  //     expect(sopraCategorie?[0], prima_categoria?.id_categoria);
  //   });
  //   test('Test eliminazione categoria', () async {
  //     final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
  //     final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
  //     expect(eliminaPrimaCategoria, true);
  //     expect(eliminaSecondaCategoria, true);
  //   });
  // });
}
