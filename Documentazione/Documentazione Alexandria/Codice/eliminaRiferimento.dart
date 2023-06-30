import 'package:test/test.dart';

void main() {
  group('Test riferimenti', () {
    Riferimento? primo_riferimento;
    test('Creazione riferimento', () async {
      //*Codice omesso*// 
    });
    test('Test eliminazione riferimento', () async {

      var eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, true);
      eliminaPrimoRiferimento = await networkHelper.deleteRiferimento(primo_riferimento!);
      expect(eliminaPrimoRiferimento, false);

    });
    test('Test aggiorna riferimento autore', () async {
      //*Codice omesso*// 
    });
  });
}