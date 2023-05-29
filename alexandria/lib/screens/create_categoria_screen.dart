import 'dart:async';
import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class CreateCategoriaScreen extends StatefulWidget {
  const CreateCategoriaScreen({super.key});

  @override
  State<CreateCategoriaScreen> createState() => _CreateCategoriaScreenState();
}

class _CreateCategoriaScreenState extends State<CreateCategoriaScreen> {
  String? filtroCategoria;
  Future<Categoria?> tryCreateCategoria() async {
    unawaited(
      showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Creazione categoria...'),
            content: Container(
              padding: const EdgeInsets.all(50),
              height: 250,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
    final newCategoria = await networkHelper.createCategoria(
      nomeCategoria,
      currentUser.user_ID,
      sopraCategoria,
    );
    Navigator.pop(context);
    return newCategoria;
  }

  late String nomeCategoria;
  int? sopraCategoria;
  @override
  void initState() {
    super.initState();
    allCategories ??= networkHelper.findAllCategories();
  }

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
                    onChanged: (value) {
                      nomeCategoria = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Inserisci nome...',
                    ),
                  ),
                ),
                const Text(
                  'Sopra-Categoria',
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
                                    onChanged: (value) {
                                      filtroCategoria = value;
                                      setState(() {});
                                    },
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
                                    future: allCategories,
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
                                          padding: EdgeInsets.zero,
                                          itemCount: snapshot.data?.length,
                                          itemBuilder:
                                              (BuildContext build, int index) {
                                            if (filtroCategoria == null ||
                                                snapshot.data![index].nome
                                                    .contains(
                                                  RegExp(
                                                    filtroCategoria!,
                                                  ),
                                                )) {
                                              return MiniInfoBox(
                                                backgroundColor:
                                                    sopraCategoria ==
                                                            snapshot
                                                                .data![index]
                                                                .id_categoria
                                                        ? Colors.grey
                                                        : Colors.white,
                                                name:
                                                    snapshot.data![index].nome,
                                                fontSize: 15,
                                                onTap: () {
                                                  sopraCategoria = snapshot
                                                      .data?[index]
                                                      .id_categoria;
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Selezionata "${snapshot.data![index].nome}" come sopra-categoria!',
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onTapIcon: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    'view_categoria',
                                                    arguments:
                                                        snapshot.data![index],
                                                  );
                                                },
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
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
            child: const Text(
              'Salva',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              final newCategoria = await tryCreateCategoria();

              if (newCategoria != null) {
                (await allCategories)!.add(newCategoria);
                setState(() {});
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      content: const SingleChildScrollView(
                        child: Text('Categoria creata con successo!'),
                      ),
                      actions: [
                        AlexandriaRoundedButton(
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
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 20,
                            bottom: 20,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'view_categoria',
                              arguments: newCategoria,
                            );
                          },
                          child: const Text('Visualizza'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Errore!')));
              }
            },
          ),
        ],
      ),
    );
  }
}
