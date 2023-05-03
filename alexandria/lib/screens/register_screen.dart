import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              child: Row(children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 10, bottom: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "REGISTRAZIONE",
                            style: TextStyle(
                                fontSize: 24, shadows: kTextElevation),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Nome"),
                              Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(33.0)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {},
                                  decoration: kInputDecoration,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cognome"),
                              Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(33.0)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {},
                                  decoration: kInputDecoration,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email"),
                              Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(33.0)),
                                elevation: 5,
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {},
                                  decoration: kInputDecoration,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Username"),
                              Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(33.0)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {},
                                  decoration: kInputDecoration,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Password"),
                              Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(33.0)),
                                      elevation: 5,
                                      child: TextField(
                                        obscureText: true,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {},
                                        decoration: kInputDecoration,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove_red_eye))
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Conferma password"),
                              Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(33.0)),
                                      elevation: 5,
                                      child: TextField(
                                        obscureText: true,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {},
                                        decoration: kInputDecoration,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove_red_eye))
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
                                  }),
                              const Text("Ricordami")
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: AlexandriaRoundedButton(
                              elevation: 1,
                              borderColor: Colors.grey,
                              onPressed: () {},
                              child: const Text(
                                "Registrati",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
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
              ]),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
