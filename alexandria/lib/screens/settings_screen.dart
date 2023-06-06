import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/components/alexandria_dialog.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String nome;
  late String cognome;
  late String email;
  late String username;
  late String password;
  late String confermaPassword;
  bool mostraPassword = false;
  bool mostraConfermaPassword = false;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 4,
      ),
      backgroundColor: kAlexandriaGreen,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 39,
              child: Row(
                children: [
                  const SizedBox(
                    //spazio verde a destra
                    width: 40,
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          bottomLeft: Radius.circular(70),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          top: 10,
                          bottom: 10,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'IMPOSTAZIONI',
                              style: TextStyle(
                                fontSize: 24,
                                shadows: kTextElevation,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nome'),
                                Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(33),
                                  ),
                                  elevation: 5,
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: TextEditingController(text: currentUser.nome),
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      nome = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'Nome...',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Cognome'),
                                Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(33),
                                  ),
                                  elevation: 5,
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: TextEditingController(text: currentUser.cognome),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      cognome = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'Cognome...',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email'),
                                Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(33),
                                  ),
                                  elevation: 5,
                                  child: TextField(
                                    controller: TextEditingController(text: currentUser.email),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'Email...',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Username'),
                                Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(33),
                                  ),
                                  elevation: 5,
                                  child: TextField(
                                    controller: TextEditingController(text: currentUser.username),
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'Username...',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(33),
                                        ),
                                        elevation: 5,
                                        child: TextField(
                                          obscureText: !mostraPassword,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          keyboardType: TextInputType.visiblePassword,
                                          textAlign: TextAlign.left,
                                          onChanged: (value) {
                                            password = value;
                                          },
                                          decoration: kInputDecoration,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          mostraPassword = !mostraPassword;
                                        });
                                      },
                                      icon: const Icon(Icons.remove_red_eye),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Conferma password'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(33),
                                        ),
                                        elevation: 5,
                                        child: TextField(
                                          obscureText: !mostraConfermaPassword,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          keyboardType: TextInputType.visiblePassword,
                                          textAlign: TextAlign.left,
                                          onChanged: (value) {
                                            confermaPassword = value;
                                          },
                                          decoration: kInputDecoration,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          mostraConfermaPassword = !mostraConfermaPassword;
                                        });
                                      },
                                      icon: const Icon(Icons.remove_red_eye),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    rememberMe = value!;
                                    setState(() {});
                                  },
                                ),
                                const Text('Ricordami')
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AlexandriaRoundedButton(
                                  onPressed: () {
                                    Navigator.popUntil(context, ModalRoute.withName('login'));
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                AlexandriaRoundedButton(
                                  onPressed: () async {
                                    if (confermaPassword == password &&
                                        password != '' &&
                                        nome != '' &&
                                        cognome != '' &&
                                        email != '' &&
                                        username != '') {
                                      final newUser =
                                          Utente(currentUser.user_ID, username, nome, cognome, email, password);
                                      await showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlexandriaDialog(
                                            content: FutureBuilder(
                                              future: networkHelper.updateUser(currentUser),
                                              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const Center(child: CircularProgressIndicator());
                                                } else {
                                                  if (snapshot.data!) {
                                                    currentUser = newUser;
                                                    if (rememberMe) {
                                                      preferences
                                                        ..setString('username', currentUser.username)
                                                        ..setString('password', currentUser.password);
                                                    }
                                                    return const Center(child: Text('Dati aggiornati!'));
                                                  } else {
                                                    return const Center(child: Text("Errore nell'aggiornare dati!"));
                                                  }
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Salva',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
