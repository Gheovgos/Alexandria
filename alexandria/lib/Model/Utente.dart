import 'dart:core';
import 'dart:math';

class Utente {
  Utente(
    this.user_ID,
    this.username,
    this.nome,
    this.cognome,
    this.email,
    this.password,
  ) {
    salt = generateRandomString();
  }

  Utente.fromJson(Map<String, dynamic> json)
      : user_ID = json['user_ID'] as int,
        nome = json['nome'] as String,
        cognome = json['cognome'] as String,
        username = json['username'] as String,
        password = json['password_hashed'] as String,
        salt = json['salt'] as String,
        email = json['email'] as String?;

  late int user_ID;
  late String username;
  late String nome;
  late String cognome;
  String? email;
  late String password;
  late String salt;

  Map<String, dynamic> toJson() {
    return {
      'user_ID': user_ID,
      'nome': nome,
      'cognome': cognome,
      'email': email,
      'username': username,
      'password_hashed': password,
      'salt': salt,
    };
  }

  String calculateHash(String unhashedPassword, String salt) {
    int hash = unhashedPassword.hashCode ^ salt.hashCode;
    String password_hashed = hash.toString();

    return password_hashed;
  }

  String generateRandomString() {
    final len = Random();
    final r = Random();
    return String.fromCharCodes(
      List.generate(len.nextInt(20) + 5, (index) => r.nextInt(33) + 89),
    );
  }
}
