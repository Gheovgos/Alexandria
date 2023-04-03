import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF37C534),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120.0),
              ),
            ),
            height: 300,
            child: Center(child: Image(image: AssetImage('assets/logo.png'),)),
          ),
          Text(
            'Benvenuto su Alexandria, l’app personale per la gestione affidabile dei propri riferimenti bibliografici.',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            ' Potrai aggiungere e modificare i tuoi riferimenti, inoltre potrai visualizzare i riferimenti degli altri utenti.',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Unisciti",
            ),
          ),
          Container(
            height: 100,
            child: Image(
              image: AssetImage('assets/unina_logo.png'),
            ),
          ),
        ],
      ),
    ));
  }
}
