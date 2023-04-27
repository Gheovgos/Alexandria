import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';
import '../alexandria_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AlexandriaNavigationBar(),
      backgroundColor: kAlexandriaGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70.0),
                    bottomRight: Radius.circular(70.0)),
              ),
              child: const Center(
                child: Text(
                  "Benvenuto, Nome Cognome",
                  style: TextStyle(fontSize: 24, shadows: kTextElevation),
                ),
              ),
            ),
          ),
          //TODO: aggiungi gesture detector
          SizedBox(
            height: 100,
            width: 300,
            child: Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.zoom_in,
                      size: 40,
                    ),
                    Text(
                      "Ricerca",
                      style: TextStyle(fontSize: 20, shadows: kTextElevation),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //TODO: aggiungi gesture detector
          SizedBox(
            height: 100,
            width: 300,
            child: Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_upward_outlined,
                      size: 40,
                    ),
                    Text(
                      "Cronologia",
                      style: TextStyle(fontSize: 20, shadows: kTextElevation),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Image.asset('assets/alexandria_bianco.png'),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
