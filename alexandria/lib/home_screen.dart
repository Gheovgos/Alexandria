import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Riferimenti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Crea'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_outlined), label: 'Boh'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Impostazioni'),
        ],
        selectedItemColor: kAlexandriaGreen,
        unselectedItemColor: Colors.black,
      ),
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
                  style: TextStyle(fontSize: 30),
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
                    Icon(Icons.zoom_in),
                    Text("Ricerca"),
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
                    Icon(Icons.arrow_upward_outlined),
                    Text("Cronologia"),
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
