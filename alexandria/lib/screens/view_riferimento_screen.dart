import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:alexandria/mini_info_box.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewRiferimentoScreen extends StatefulWidget {
  const ViewRiferimentoScreen({super.key});

  @override
  State<ViewRiferimentoScreen> createState() => _ViewRiferimentoScreenState();
}

class _ViewRiferimentoScreenState extends State<ViewRiferimentoScreen> {
  @override
  Widget build(BuildContext context) {
    final riferimento =
        ModalRoute.of(context)!.settings.arguments as Riferimento?;
    return Scaffold(
      floatingActionButton: riferimento!.on_line
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      content: SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Link associato:'),
                            MiniInfoBox(
                              name: riferimento.URL!,
                              icon: Icons.copy,
                            ),
                            const Text('Desideri aprire il link?'),
                          ],
                        ),
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
                          child: const Text('No'),
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
                            launchUrl(
                              Uri.parse(riferimento.URL!),
                            );
                          },
                          child: const Text('Sì'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.link,
                color: Colors.black,
              ),
            )
          : null,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          riferimento.titolo_riferimento,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data: ${riferimento.data_riferimento.year}'
                              '-${riferimento.data_riferimento.month}'
                              '-${riferimento.data_riferimento.day}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Edizione: ${riferimento.edizione ?? 'Non associata'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(
                start: 120,
                end: 120,
                top: 10,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Text(
                riferimento.luogo ?? 'Nessun luogo associato',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(
                start: 50,
                end: 50,
                top: 10,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Text(
                    convertEnumToString(riferimento.tipo!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    riferimento.pag_fine == null
                        ? ''
                        : 'da pagina ${riferimento.pag_inizio} a '
                            '${riferimento.pag_fine}',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(
                start: 20,
                end: 20,
                top: 10,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Autori',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: kAlexandriaGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 250,
                        child: FutureBuilder(
                          future: networkHelper.findAllUsers(),
                          // TODO(peppe): QUERY SBAGLIATA!
                          builder: (
                            context,
                            AsyncSnapshot<List<Utente>?> snapshot,
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
                                  return MiniInfoBox(
                                    name: '${snapshot.data![index].nome} '
                                        '${snapshot.data![index].cognome}',
                                    fontSize: 15,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const SizedBox(),
                    const Text('Descrizione'),
                    AlexandriaRoundedButton(
                      elevation: kButtonElevation,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                title: const Text(
                                  'Descrizione',
                                  textAlign: TextAlign.center,
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: kInfoBoxColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          child: Text(
                                            riferimento.descr_riferimento!,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: kInfoBoxColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          'ISNN: ${riferimento.isnn ?? ''}',
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: kInfoBoxColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          'ISBN: ${riferimento.isbn ?? ''}',
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: kInfoBoxColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          'DOI: ${riferimento.DOI ?? ''}',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(
                start: 20,
                end: 20,
                top: 10,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Citazioni',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: kAlexandriaGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 250,
                        child: FutureBuilder(
                          future: networkHelper
                              .getByRiferimentoAssociato(riferimento),
                          // TODO(peppe): QUERY SBAGLIATA!
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
                                  return MiniInfoBox(
                                    name: snapshot
                                        .data![index].titolo_riferimento,
                                    fontSize: 15,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
