

import 'dart:convert';

class Utente {

    Utente(int user_ID, String username, String nome,  String cognome, String email, String password, String salt) {
        this.user_ID = user_ID;
        this.username = username;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
        this.salt = salt;
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

}