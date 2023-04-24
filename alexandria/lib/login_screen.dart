import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

import 'alexandria_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    height: 170.0,
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                  decoration:
                      kInputDecoration.copyWith(hintText: 'Username...')),
              TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kInputDecoration.copyWith(hintText: 'Password...'),
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
                          }),
                      Text("Ricordami")
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text("Credenziali dimenticate?"))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlexandriaRoundedButton(
                    child: const Text("Registrati"),
                    onPressed: () {},
                  ),
                  AlexandriaRoundedButton(
                    child: const Text("Accedi"),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
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
