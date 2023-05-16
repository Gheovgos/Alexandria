import 'dart:convert';
import 'dart:core';
import 'dart:math';


class Utente {

    Utente(int user_id, String username, String nome,  String cognome, String email, String password) {
        this.user_ID = user_id;
        this.username = username;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        salt = generateRandomString();
        this.password = password;
    }

    Utente.fromJson(Map<String, dynamic>  json)
        : user_ID = json['user_ID'] as int,
            nome = json['nome'] as String,
            cognome = json['cognome'] as String,
            username = json['username'] as String,
            password = json['password_hashed'] as String,
            salt = json['salt'] as String;


    late int user_ID;
    late String username;
    late String nome;
    late String cognome;
    late String email;
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
        var len = Random();
        var r = Random();
        return String.fromCharCodes(List.generate(len.nextInt(20) + 5, (index) => r.nextInt(33) + 89));
    }

}