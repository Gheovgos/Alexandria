

class Utente {
    late int user_ID;
    late String username;
    late String nome;
    late String cognome;
    late String email;
    late String password;
    late String salt;

    Utente(user_ID, username, nome, cognome, email, password, salt);

    Utente.fromJson(Map<String, dynamic> json)
        : user_ID = json['user_ID'],
            nome = json['nome'],
            cognome = json['cognome'],
            username = json['username'],
            password = json['password_hashed'],
            salt = json['salt'];


    Map<String, dynamic> toJson() => {
        'user_ID': user_ID,
        'nome': nome,
        'cognome': cognome,
        'email': email,
        'username': username,
        'password_hashed': password,
        'salt': salt,
    };

}