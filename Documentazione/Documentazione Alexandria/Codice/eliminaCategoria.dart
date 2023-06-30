import 'package:test/test.dart';

void main() {
  group('Test categorie', () {
    	//*Codice omesso*//
    });
    test('Test sopra-categoria', () async {
       //*Codice omesso*//
    });
    test('Test eliminazione categoria', () async {

      final eliminaPrimaCategoria = await networkHelper.deleteCategoria(prima_categoria!);
      final eliminaSecondaCategoria = await networkHelper.deleteCategoria(seconda_categoria!);
      expect(eliminaPrimaCategoria, true);
      expect(eliminaSecondaCategoria, true);

    });
  });