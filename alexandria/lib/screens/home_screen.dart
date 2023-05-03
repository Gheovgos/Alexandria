import 'package:alexandria/constants.dart';
import 'package:alexandria/history_dialog.dart';
import 'package:flutter/material.dart';
import '../alexandria_navigation_bar.dart';
import '../search_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 0,),
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
          GestureDetector(
            onTap: () {
              //TODO: pulsante Ricerca
              showDialog(
                context: context,
                builder: (BuildContext context) => SearchDialog(),
              );
            },
            child: SizedBox(
              height: 100,
              width: 300,
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
                      Icons.search,
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
          GestureDetector(
            onTap: () {
              //TODO: pulsante Cronologia
              showDialog(
                context: context,
                builder: (BuildContext context) => HistoryDialog(),
              );
            },
            child: SizedBox(
              height: 100,
              width: 300,
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
          Image.asset(
            'assets/alexandria_bianco.png',
            height: 100,
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
