import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class WriteRiferimentoScreen extends StatefulWidget {
  const WriteRiferimentoScreen({super.key});

  @override
  State<WriteRiferimentoScreen> createState() => _WriteRiferimentoScreenState();
}

class _WriteRiferimentoScreenState extends State<WriteRiferimentoScreen> {
  late bool isCreate;
  Riferimento? riferimento;
  @override
  Widget build(BuildContext context) {
    riferimento ??= ModalRoute.of(context)!.settings.arguments as Riferimento?;
    if (riferimento == null) {
      riferimento ??= Riferimento.empty();
      isCreate = true;
    } else {
      isCreate = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 2),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                  right: 10,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Titolo Riferimento',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              AlexandriaRoundedButton(
                child: GestureDetector(
                  onTap: () async {
                    riferimento!.data_riferimento = (await showDatePicker(
                      context: context,
                      initialDate: riferimento!.data_riferimento,
                      firstDate: DateTime(1500),
                      lastDate: DateTime.now(),
                    ))!;
                  },
                  child: const Row(
                    children: [Text('Data'), Icon(Icons.calendar_month)],
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 170,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(33)),
                        elevation: 5,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            riferimento!.titolo_riferimento = value;
                          },
                          decoration: kInputDecoration.copyWith(
                            hintText: riferimento!.titolo_riferimento == ''
                                ? 'Inserisci testo...'
                                : riferimento!.titolo_riferimento,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        const Text('Riferimento a...'),
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
                      onPressed: riferimento!.tipo != tipo_enum.Articolo
                          ? () {
                              setState(() {
                                riferimento?.tipo = tipo_enum.Articolo;
                              });
                            }
                          : null,
                      child: const Text('Articoli'),
                    ),
                    AlexandriaRoundedButton(
                      onPressed: riferimento!.tipo != tipo_enum.Libro
                          ? () {
                              setState(() {
                                riferimento?.tipo = tipo_enum.Libro;
                              });
                            }
                          : null,
                      child: const Text('Libri'),
                    ),
                    AlexandriaRoundedButton(
                      onPressed: riferimento!.tipo != tipo_enum.Fascicolo
                          ? () {
                              setState(() {
                                riferimento!.tipo = tipo_enum.Fascicolo;
                              });
                            }
                          : null,
                      child: const Text('Fascicoli'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlexandriaRoundedButton(
                      onPressed: riferimento!.tipo != tipo_enum.Rivista
                          ? () {
                              setState(() {
                                riferimento!.tipo = tipo_enum.Rivista;
                              });
                            }
                          : null,
                      child: const Text('Riviste'),
                    ),
                    AlexandriaRoundedButton(
                      onPressed: riferimento!.tipo != tipo_enum.Conferenza
                          ? () {
                              setState(() {
                                riferimento!.tipo = tipo_enum.Conferenza;
                              });
                            }
                          : null,
                      child: const Text('Conferenze'),
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
                        const Text('Descrizione...'),
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
                        const Text('Link...'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.white,
                      width: 150,
                      child: Material(
                        elevation: 2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Editore'),
                            Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(33)),
                              elevation: 5,
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                onChanged: (value) {},
                                decoration: kInputDecoration.copyWith(
                                  hintText: 'Inserisci testo...',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: 150,
                      child: Material(
                        elevation: 2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Luogo'),
                            Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(33)),
                              elevation: 5,
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                onChanged: (value) {},
                                decoration: kInputDecoration.copyWith(
                                  hintText: 'Inserisci testo...',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.white,
                      width: 150,
                      child: Material(
                        elevation: 2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('ISSN'),
                            Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(33)),
                              elevation: 5,
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                onChanged: (value) {},
                                decoration: kInputDecoration.copyWith(
                                  hintText: 'Inserisci testo...',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: 150,
                      child: Material(
                        elevation: 2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('ISBN'),
                            Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(33)),
                              elevation: 5,
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.left,
                                onChanged: (value) {},
                                decoration: kInputDecoration.copyWith(
                                  hintText: 'Inserisci testo...',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                AlexandriaRoundedButton(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                    top: 30,
                    bottom: 30,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Conferma',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
