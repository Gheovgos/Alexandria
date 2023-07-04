import 'package:test/test.dart';

void main() {
  group('Test categorie', () {

    test('Creazione categoria', () async {

      expect(await networkHelper.createCategoria('', 1, null), null); //CE1 CE4 CE5
      expect(await networkHelper.createCategoria('WECT 1', -100, null), null); //CE2 CE3 CE5
      expect(await networkHelper.createCategoria('WECT 2', 10, -5), null); //CE2 CE4 CE6
      expect(await networkHelper.createCategoria('WECT 3', 10, null) != null, true); //CE2 CE4 CE5
      expect(await networkHelper.createCategoria('WECT 4', 10, 20) != null, true); //CE2 CE4 CE7

    });

    test('Test sopra-categoria', () async {

      //*Codice Omesso*//

    });

    test('Test eliminazione categoria', () async {

      //*Codice Omesso*//

    });
  });