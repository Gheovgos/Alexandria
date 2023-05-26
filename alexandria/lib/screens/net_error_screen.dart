import 'package:alexandria/alexandria_container.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class NetErrorScreen extends StatefulWidget {
  const NetErrorScreen({super.key});

  @override
  State<NetErrorScreen> createState() => _NetErrorScreenState();
}

class _NetErrorScreenState extends State<NetErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AlexandriaContainer(
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
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: 'Connessione '),
                  TextSpan(
                    text: 'non',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' riuscita. Per favore, controlla le impostazioni di rete del dispositivo, oppure provare a risolvere in questo modo:\n  ',
                  ),
                  TextSpan(text: '1. Riavvia il cellulare.\n  '),
                  TextSpan(
                    text:
                        '2. Se riavviando il cellulare il problema persiste, prova a cambiare rete da Wi-Fi a dati mobili.\n',
                  ),
                  TextSpan(
                    text:
                        'In alternativa, puoi riprovare cliccando il tasto sottostante:',
                  )
                ],
              ),
            ),
          ),
          AlexandriaRoundedButton(
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.white,
            child: Text(
              'Riprova',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 15,
                shadows: kTextElevation,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
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
        ],
      ),
    );
  }
}
