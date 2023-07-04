import 'package:test/test.dart';

void main() {
  group('Test utenti', () {
	
    test('Test calcolo hash', () async {
      Utente u = Utente(-1, "Test", "nome", "cognome", "email", "password");
      expect(u.calculateHash("", "salt"), ""); //CE1 CE4
      expect(u.calculateHash("password", ""), ""); //CE2 CE3
      expect(u.calculateHash("unhashedPassword", "salt") != null, true); //CE2 CE4

    });

  });