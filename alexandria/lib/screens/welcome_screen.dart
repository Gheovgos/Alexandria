import 'dart:async';
import 'package:alexandria/alexandria_container.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Future<bool> hasConnection;
  @override
  void initState() {
    super.initState();
    connectionCheck();
  }

  Future<void> connectionCheck() async {
    hasConnection = networkHelper.hasConnection();
  }

  Future<void> showError() async {
    unawaited(
      showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Controllando la connessione...'),
            content: Container(
              padding: const EdgeInsets.all(50),
              height: 250,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
    final awaitedHasConnection = await hasConnection;
    Navigator.pushNamed(
      context,
      awaitedHasConnection ? 'login' : 'neterror',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Benvenuto su Alexandria, l’app personale per la gestione affidabile dei propri riferimenti bibliografici.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Potrai aggiungere e modificare i tuoi riferimenti, inoltre potrai visualizzare i riferimenti degli altri utenti.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          AlexandriaRoundedButton(
            elevation: kButtonElevation,
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.white,
            onPressed: showError,
            child: Text(
              'Unisciti',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 15,
                shadows: kTextElevation,
              ),
            ),
          ),
          const Hero(
            tag: 2,
            child: SizedBox(
              height: 130,
              child: Image(
                image: AssetImage('assets/unina_logo.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
