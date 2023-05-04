import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WriteRiferimentoScreen extends StatefulWidget {
  const WriteRiferimentoScreen({Key? key}) : super(key: key);

  @override
  State<WriteRiferimentoScreen> createState() => _WriteRiferimentoScreenState();
}

class _WriteRiferimentoScreenState extends State<WriteRiferimentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAlexandriaGreen,
        bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 2),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Titolo Riferimento",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                AlexandriaRoundedButton(
                  child: GestureDetector(
                    onTap: () {
                      //TODO: aggiungi date picker
                    },
                    child: Row(
                      children: const [
                        Text("Data"),
                        Icon(Icons.calendar_month)
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              width: 370,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 170,
                    child: Material(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(33.0)),
                      elevation: 5,
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        onChanged: (value) {},
                        decoration: kInputDecoration.copyWith(
                            hintText: 'Inserisci testo...'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: 300,
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Riferimento a..."),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlexandriaRoundedButton(
                        onPressed: () {},
                        elevation: 5,
                        child: const Text("Articoli"),
                      ),
                      AlexandriaRoundedButton(
                        onPressed: () {},
                        elevation: 5,
                        child: const Text("Libri"),
                      ),
                      AlexandriaRoundedButton(
                        onPressed: () {},
                        elevation: 5,
                        child: const Text("Fascicoli"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlexandriaRoundedButton(
                        onPressed: () {},
                        elevation: 5,
                        child: const Text("Riviste"),
                      ),
                      AlexandriaRoundedButton(
                        onPressed: () {},
                        elevation: 5,
                        child: const Text("Conferenze"),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: 300,
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Descrizione..."),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: 300,
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Link..."),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Material(
                            elevation: 2,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),

                            child: Text("Editore"),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
