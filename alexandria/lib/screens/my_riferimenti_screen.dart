import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:alexandria/mini_info_box.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(33)),
                        elevation: 5,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          onChanged: (value) {},
                          decoration: kInputDecoration.copyWith(
                            hintText: 'Cerca riferimento...',
                          ),
                        ),
                      ),
                    ),
                    AlexandriaRoundedButton(
                      elevation: kButtonElevation,
                      child: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Ordina:'),
                AlexandriaRoundedButton(
                  elevation: kButtonElevation,
                  onPressed: () {},
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
                      height: 350,
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
                                return InkWell(
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          content: Text(
                                            snapshot.data![index]
                                                .titolo_riferimento,
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            AlexandriaRoundedButton(
                                              elevation: kButtonElevation,
                                              padding: const EdgeInsets.all(
                                                20,
                                              ),
                                              onPressed: () {
                                                // TODO(peppe): apri write_riferimento
                                              },
                                              child: const Text('Modifica'),
                                            ),
                                            AlexandriaRoundedButton(
                                              elevation: kButtonElevation,
                                              padding: const EdgeInsets.all(
                                                20,
                                              ),
                                              onPressed: () {
                                                // TODO(peppe): apri view_riferimento
                                              },
                                              child: const Text('Visualizza'),
                                            ),
                                            AlexandriaRoundedButton(
                                              elevation: kButtonElevation,
                                              padding: const EdgeInsets.all(
                                                20,
                                              ),
                                              onPressed: () {
                                                // TODO(peppe): chiedi conferma
                                              },
                                              child: const Text('Elimina'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: MiniInfoBox(
                                    name: snapshot
                                        .data![index].titolo_riferimento,
                                    fontSize: 15,
                                  ),
                                );
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
}
