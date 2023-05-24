import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
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
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      nome = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: currentUser.nome,
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
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      cognome = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: currentUser.cognome,
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
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: currentUser.email,
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
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    decoration: kInputDecoration.copyWith(
                                      hintText: currentUser.username,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AlexandriaRoundedButton(
                                  elevation: kButtonElevation,
                                  onPressed: () {},
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                AlexandriaRoundedButton(
                                  elevation: kButtonElevation,
                                  onPressed: () async {
                                    if (confermaPassword == password &&
                                        password != '' &&
                                        nome != '' &&
                                        cognome != '' &&
                                        email != '' &&
                                        username != '') {
                                      currentUser.nome = nome;
                                      currentUser.cognome = cognome;
                                      currentUser.email = email;
                                      currentUser.password = password;
                                      networkHelper.updateUser(currentUser);
                                      // TODO(peppe): finire qui, mostrare dialog
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
