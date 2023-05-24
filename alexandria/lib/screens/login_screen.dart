import 'package:alexandria/Connessione/ConnectionHandler.dart';
import 'package:alexandria/alexandria_container.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String username;
  late String password;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 1,
            child: AlexandriaContainer(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/alexandria_name_white.png',
                    height: 170,
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 350,
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(33)),
                  elevation: 5,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      username = value;
                    },
                    decoration:
                        kInputDecoration.copyWith(hintText: 'Username...'),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(33)),
                  elevation: 5,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                        kInputDecoration.copyWith(hintText: 'Password...'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    TextButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                            'mailto:alexandria.help@gmail.com?subject=<Recupero credenziali>',
                          ),
                        );
                      },
                      child: const Text(
                        'Credenziali dimenticate?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlexandriaRoundedButton(
                      elevation: kButtonElevation,
                      child: Text(
                        'Registrati',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                    ),
                    AlexandriaRoundedButton(
                      elevation: kButtonElevation,
                      child: Text(
                        'Accedi',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      onPressed: () async {
                        if (kReleaseMode) {
                          final user = await networkHelper.login(username, password);
                          if (user == null) {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actionsAlignment:
                                      MainAxisAlignment.spaceAround,
                                  title: const Text('Errore!'),
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Credenziali errate!'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            currentUser = user;
                            Navigator.pushNamed(context, 'home');
                          }
                        }
                        Navigator.pushNamed(context, 'home');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
            child: Hero(
              tag: 2,
              child: Image(
                image: AssetImage('assets/unina_logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
