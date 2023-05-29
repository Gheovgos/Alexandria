import 'package:alexandria/components/alexandria_dialog.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(70),
                          bottomRight: Radius.circular(70),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'REGISTRAZIONE',
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
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      nome = value;
                                    },
                                    decoration: kInputDecoration,
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
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      cognome = value;
                                    },
                                    decoration: kInputDecoration,
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
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: kInputDecoration,
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
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    decoration: kInputDecoration,
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
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          mostraConfermaPassword =
                                              !mostraConfermaPassword;
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
                            Center(
                              child: AlexandriaRoundedButton(
                                onPressed: () async {
                                  if (confermaPassword == password &&
                                      password != '' &&
                                      nome != '' &&
                                      cognome != '' &&
                                      email != '' &&
                                      username != '') {
                                    if (kReleaseMode) {
                                      final user =
                                          await networkHelper.registrazione(
                                        username,
                                        password,
                                        nome,
                                        cognome,
                                        email,
                                      );
                                      if (user == null) {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlexandriaDialog(
                                              title: Text('Errore!'),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Utente già esistente!',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        currentUser = user;
                                        Navigator.pushNamed(
                                          context,
                                          'home',
                                        );
                                      }
                                    }
                                  } else {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlexandriaDialog(
                                          title: Text('Errore!'),
                                          content: SizedBox(
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Non tutti i campi sono stati riempiti!',
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Text(
                                  'Registrati',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    //spazio verde a destra
                    width: 40,
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
