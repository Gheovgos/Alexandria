import 'dart:async';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/components/alexandria_dialog.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class MyRiferimentiScreen extends StatefulWidget {
  const MyRiferimentiScreen({super.key});

  @override
  State<MyRiferimentiScreen> createState() => _MyRiferimentiScreenState();
}

class _MyRiferimentiScreenState extends State<MyRiferimentiScreen> {
  @override
  void initState() {
    super.initState();
    myRiferimenti ??= networkHelper.getRiferimentoByUserId(currentUser.user_ID);
  }

  bool sortedAscending = false;
  String? filtroRiferimenti;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Riferimenti creati',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 250,
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(33)),
                    elevation: 5,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        filtroRiferimenti = value;
                        setState(() {});
                      },
                      decoration: kInputDecoration.copyWith(
                        hintText: 'Cerca riferimento...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Ordina:'),
                AlexandriaRoundedButton(
                  onPressed: () async {
                    (await myRiferimenti)?.sort((a, b) {
                      if (!sortedAscending) {
                        return a.titolo_riferimento.compareTo(b.titolo_riferimento);
                      } else {
                        return b.titolo_riferimento.compareTo(a.titolo_riferimento);
                      }
                    });

                    sortedAscending = !sortedAscending;
                    setState(() {});
                  },
                  child: const Icon(Icons.filter_list_outlined),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: kAlexandriaGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      right: 20,
                      bottom: 15,
                    ),
                    child: SizedBox(
                      height: 450,
                      width: 300,
                      child: FutureBuilder(
                        future: myRiferimenti,
                        builder: (
                          context,
                          AsyncSnapshot<List<Riferimento>?> snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext build, int index) {
                                if (filtroRiferimenti == null ||
                                    snapshot.data![index].titolo_riferimento.contains(
                                      RegExp(filtroRiferimenti!),
                                    )) {
                                  return InkWell(
                                    onTap: () {
                                      cliccaRiferimentoDialog(
                                        context,
                                        snapshot,
                                        index,
                                      );
                                    },
                                    child: MiniInfoBox(
                                      name: snapshot.data![index].titolo_riferimento,
                                      fontSize: 15,
                                    ),
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
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cliccaRiferimentoDialog(
    BuildContext context,
    AsyncSnapshot<List<Riferimento>?> snapshot,
    int index,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: Text(
            snapshot.data![index].titolo_riferimento,
            textAlign: TextAlign.center,
          ),
          actions: [
            AlexandriaRoundedButton(
              padding: const EdgeInsets.all(
                20,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'write_riferimento', arguments: snapshot.data![index]);
              },
              child: const Text('Modifica'),
            ),
            AlexandriaRoundedButton(
              padding: const EdgeInsets.all(
                20,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'view_riferimento',
                  arguments: snapshot.data![index],
                );
              },
              child: const Text('Visualizza'),
            ),
            AlexandriaRoundedButton(
              padding: const EdgeInsets.all(
                20,
              ),
              onPressed: () {
                confermaEliminaRiferimentoDialog(
                  context,
                  snapshot.data![index],
                );
              },
              child: const Text('Elimina'),
            ),
          ],
        );
      },
    );
  }

  Future<void> confermaEliminaRiferimentoDialog(
    BuildContext context,
    Riferimento r,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlexandriaDialog(
          title: const Text(
            'Sei sicuro?',
          ),
          actions: [
            AlexandriaRoundedButton(
              padding: const EdgeInsets.all(
                20,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Annulla',
              ),
            ),
            AlexandriaRoundedButton(
              padding: const EdgeInsets.all(
                20,
              ),
              onPressed: () async {
                if ((await myRiferimenti)!.remove(r)) {
                  unawaited(
                    networkHelper.deleteRiferimento(
                      r,
                    ),
                  );
                  setState(() {});
                }
              },
              child: const Text(
                'Conferma',
              ),
            ),
          ],
        );
      },
    );
  }
}
