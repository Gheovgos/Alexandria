
import 'package:test/test.dart';

void main() {
  group('Test riferimenti', () {

    Riferimento? primo_riferimento;
    test('Creazione riferimento', () async {
      primo_riferimento = Riferimento(0, 'TestRiferimento', DateTime.now(), 
			tipo_enum.Conferenza, null, null, false,
 			'descr_riferimento', null, null, null, 'luogo', 
			null, null, null);
      primo_riferimento =
          await networkHelper.createRiferimento(primo_riferimento, 
				(await networkHelper.getCategoriaById(1))!, 1);
      expect('TestRiferimento', primo_riferimento?.titolo_riferimento);
      expect(tipo_enum.Conferenza, primo_riferimento?.tipo);
      expect('descr_riferimento', primo_riferimento?.descr_riferimento);
      expect('luogo', primo_riferimento?.luogo);

    });
    test('Test eliminazione riferimento', () async {
      	//*Codice omesso*//
    });
    test('Test aggiorna riferimento autore', () async {
      //*Codice omesso*//
    });
  });
}