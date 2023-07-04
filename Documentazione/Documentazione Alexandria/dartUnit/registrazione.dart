import 'package:test/test.dart';

void main() {
  group('Test Utenti', () {

    test('Test Registrazione', () async {

      expect(await networkHelper.registrazione("", "password", "nome", "cognome", "email"), null); //CE1 CE4 CE6 CE8 CE10
      expect(await networkHelper.registrazione("username", "", "nome", "cognome", "email"), null); //CE2 CE3 CE6 CE8 CE10
      expect(await networkHelper.registrazione("username", "password", "", "cognome", "email"), null); //CE2 CE4 CE5 CE8 CE10
      expect(await networkHelper.registrazione("username", "password", "nome", "", "email"), null); //CE2 CE4 CE5 CE7 CE10
      expect(await networkHelper.registrazione("username", "password", "nome", "cognome", ""), null); //CE2 CE4 CE5 CE8 CE9
      expect(await networkHelper.registrazione("username", "password", "nome", "cognome", "email") != null, true); //CE2 CE4 CE6 CE8 CE10

    });

  });