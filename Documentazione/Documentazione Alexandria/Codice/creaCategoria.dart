import 'package:test/test.dart';

void main() {
  group('Test categorie', () {

    Categoria? prima_categoria;
    Categoria? seconda_categoria;
    test('Creazione categoria', () async {
      prima_categoria = await networkHelper.createCategoria('TestCategoria', 1, null);
      expect('TestCategoria', prima_categoria?.nome);
      expect(null, prima_categoria?.super_Categoria);
      expect(1, prima_categoria?.user_id);

    });
    test('Test sopra-categoria', () async {
      //*Codice omesso*//
    });
    test('Test eliminazione categoria', () async {
      //*Codice omesso*//
    });
  });