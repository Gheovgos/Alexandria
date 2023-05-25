import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:alexandria/mini_info_box.dart';
import 'package:flutter/material.dart';

class CreateCategoriaScreen extends StatefulWidget {
  const CreateCategoriaScreen({super.key});

  @override
  State<CreateCategoriaScreen> createState() => _CreateCategoriaScreenState();
}

class _CreateCategoriaScreenState extends State<CreateCategoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 3,
      ),
      backgroundColor: kAlexandriaGreen,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Nome Categoria',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                    onChanged: (value) {},
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Inserisci nome...',
                    ),
                  ),
                ),
                const Text(
                  'Sotto-Categoria',
                  style: TextStyle(fontSize: 16),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                            color: kAlexandriaGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 15,
                              right: 20,
                              bottom: 15,
                            ),
                            child: Column(
                              children: [
                                Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(33),
                                  ),
                                  elevation: 5,
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {},
                                    decoration: kInputDecoration.copyWith(
                                      hintText: 'Cerca categoria...',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 300,
                                  child: FutureBuilder(
                                    future: networkHelper.findAllCategories(),
                                    builder: (
                                      context,
                                      AsyncSnapshot<List<Categoria>?> snapshot,
                                    ) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return ListView.builder(
                                          itemCount: snapshot.data?.length,
                                          itemBuilder:
                                              (BuildContext build, int index) {
                                            return MiniInfoBox(
                                              name: snapshot.data![index].nome,
                                              fontSize: 15,
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AlexandriaRoundedButton(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            elevation: kButtonElevation,
            child: const Text(
              'Salva',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    content: const SingleChildScrollView(
                      child: Text('Categoria creata con successo!'),
                    ),
                    actions: [
                      AlexandriaRoundedButton(
                        elevation: kButtonElevation,
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 20,
                          bottom: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Indietro'),
                      ),
                      AlexandriaRoundedButton(
                        elevation: kButtonElevation,
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 20,
                          bottom: 20,
                        ),
                        onPressed: () {
                          // TODO(peppe): view_categoria_screen(nuova categoria)
                        },
                        child: const Text('Visualizza'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
