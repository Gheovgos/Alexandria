import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';
import '../alexandria_container.dart';
import '../alexandria_rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
                    height: 170.0,
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
            elevation: 2.0,
            padding: const EdgeInsets.all(15.0),
            backgroundColor: Colors.white,
            child: Text(
              "Unisciti",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 15,
                  shadows: kTextElevation),
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
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
