import 'package:test/test.dart';

void main() {
  group('Test riferimenti', () {

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

    test('Test Creazione riferimento', () async {
      //*Codice Omesso*//
    });

    test('Test eliminazione riferimento', () async {
      //*Codice Omesso*//
    });
    test('Test Aggiungere Citazione', () async {
      //*Codice Omesso*//
    });

    test('Test aggiorna riferimento autore', () async {
      //*Codice Omesso*//
    });
  });