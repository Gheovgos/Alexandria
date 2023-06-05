import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/components/alexandria_dialog.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class WriteRiferimentoScreen extends StatefulWidget {
  const WriteRiferimentoScreen({super.key});

  @override
  State<WriteRiferimentoScreen> createState() => _WriteRiferimentoScreenState();
}

class _WriteRiferimentoScreenState extends State<WriteRiferimentoScreen> {
  late bool isCreate;
  Riferimento? riferimento;
  List<Riferimento> oldCitazioni = [];
  List<Categoria> oldCategorie = [];
  List<Utente> oldAutori = [];
  List<Riferimento> citazioni = [];
  List<Categoria> categorie = [];
  List<Utente> autori = [];
  String descrizione = '';
  int? DOI;
  int? edizione;
  int? pagInizio;
  int? pagFine;
  @override
  void initState() {
    super.initState();
    allRiferimenti ??= networkHelper.findAllRiferimenti();
    allCategories ??= networkHelper.findAllCategories();
    allUtenti ??= networkHelper.findAllUsers();
  }

  Future<void> fillLists() async {
    citazioni = (await networkHelper.getRiferimentiCitati(riferimento!))!;
    oldCitazioni = citazioni;
    autori = (await networkHelper.getAutoriByRiferimento(riferimento!.id_riferimento))!;
    oldAutori = autori;
    categorie = await networkHelper.getCategoriaByRiferimento(riferimento!.id_riferimento);
    oldCategorie = categorie;
  }

  @override
  Widget build(BuildContext context) {
    riferimento ??= ModalRoute.of(context)!.settings.arguments as Riferimento?;
    if (riferimento == null) {
      riferimento ??= Riferimento.empty();
      isCreate = true;
    } else {
      fillLists();
      isCreate = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  child: const Row(
                    children: [Text('Data'), Icon(Icons.calendar_month)],
                  ),
                  onPressed: () async {
                    riferimento!.data_riferimento = (await showDatePicker(
                      helpText: 'Scegli una data',
                      context: context,
                      initialDate: riferimento!.data_riferimento,
                      firstDate: DateTime(1500),
                      lastDate: DateTime.now(),
                    ))!;
                  },
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          borderRadius: const BorderRadius.all(Radius.circular(33)),
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
                          const Text('Categoria...'),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {
                              String? filtroCategoria;
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (
                                      BuildContext builder,
                                      StateSetter setState,
                                    ) {
                                      return AlexandriaDialog(
                                        content: DecoratedBox(
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
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: Material(
                                                    borderRadius: const BorderRadius.all(Radius.circular(33)),
                                                    elevation: 5,
                                                    child: TextField(
                                                      style: const TextStyle(color: Colors.black),
                                                      keyboardType: TextInputType.text,
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
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 450,
                                                  width: 300,
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
                                                          itemBuilder: (
                                                            BuildContext build,
                                                            int index,
                                                          ) {
                                                            final c = snapshot.data?[index];
                                                            if (filtroCategoria == null ||
                                                                c!.nome.contains(
                                                                  RegExp(filtroCategoria!),
                                                                )) {
                                                              return MiniInfoBox(
                                                                backgroundColor:
                                                                    categorie.contains(c) ? Colors.grey : Colors.white,
                                                                name: snapshot.data![index].nome,
                                                                fontSize: 15,
                                                                onTap: () {
                                                                  if (categorie.contains(c)) {
                                                                    categorie.remove(c);
                                                                  } else {
                                                                    categorie.add(c!);
                                                                  }
                                                                  setState(() {});
                                                                },
                                                                onTapIcon: () {
                                                                  Navigator.popAndPushNamed(
                                                                    context,
                                                                    'view_categoria',
                                                                    arguments: c,
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              return Container();
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
                                      );
                                    },
                                  );
                                },
                              );
                            },
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
                          const Text('Riferimento a...'),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {
                              String? filtroRiferimento;
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (
                                      BuildContext builder,
                                      StateSetter setState,
                                    ) {
                                      return AlexandriaDialog(
                                        content: DecoratedBox(
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
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: Material(
                                                    borderRadius: const BorderRadius.all(Radius.circular(33)),
                                                    elevation: 5,
                                                    child: TextField(
                                                      style: const TextStyle(color: Colors.black),
                                                      keyboardType: TextInputType.text,
                                                      textAlign: TextAlign.left,
                                                      onChanged: (value) {
                                                        filtroRiferimento = value;
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
                                                SizedBox(
                                                  height: 450,
                                                  width: 300,
                                                  child: FutureBuilder(
                                                    future: allRiferimenti,
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
                                                          itemBuilder: (
                                                            BuildContext build,
                                                            int index,
                                                          ) {
                                                            final r = snapshot.data?[index];
                                                            if (filtroRiferimento == null ||
                                                                r!.titolo_riferimento.contains(
                                                                  RegExp(filtroRiferimento!),
                                                                )) {
                                                              return MiniInfoBox(
                                                                backgroundColor:
                                                                    citazioni.contains(r) ? Colors.grey : Colors.white,
                                                                name: snapshot.data![index].titolo_riferimento,
                                                                fontSize: 15,
                                                                onTap: () {
                                                                  if (citazioni.contains(r)) {
                                                                    citazioni.remove(r);
                                                                  } else {
                                                                    citazioni.add(r!);
                                                                  }
                                                                  setState(() {});
                                                                },
                                                                onTapIcon: () {
                                                                  Navigator.popAndPushNamed(
                                                                    context,
                                                                    'view_riferimento',
                                                                    arguments: r,
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              return Container();
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
                                      );
                                    },
                                  );
                                },
                              );
                            },
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
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlexandriaDialog(
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            color: kInfoBoxColor,
                                          ),
                                          child: const Text('Descrizione'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Material(
                                          elevation: 2,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                          child: Material(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            elevation: 5,
                                            child: TextField(
                                              minLines: 6,
                                              maxLines: 7,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              keyboardType: TextInputType.emailAddress,
                                              textAlign: TextAlign.left,
                                              onChanged: (value) {
                                                descrizione = value;
                                              },
                                              decoration: kInputDecoration.copyWith(
                                                hintText: riferimento!.descr_riferimento ?? 'Inserisci testo...',
                                                fillColor: kInfoBoxColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            color: kInfoBoxColor,
                                          ),
                                          child: const Text('DOI'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Material(
                                          elevation: 2,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                          child: Material(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            elevation: 5,
                                            child: TextField(
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.left,
                                              onChanged: (value) {
                                                DOI = int.parse(value);
                                              },
                                              decoration: kInputDecoration.copyWith(
                                                hintText: riferimento!.DOI == null
                                                    ? 'Inserisci testo...'
                                                    : riferimento!.DOI.toString(),
                                                fillColor: kInfoBoxColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            color: kInfoBoxColor,
                                          ),
                                          child: const Text('Edizione'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Material(
                                          elevation: 2,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                          child: Material(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            elevation: 5,
                                            child: TextField(
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.left,
                                              onChanged: (value) {
                                                edizione = int.parse(value);
                                              },
                                              decoration: kInputDecoration.copyWith(
                                                hintText: riferimento!.edizione == null
                                                    ? 'Inserisci testo...'
                                                    : riferimento!.edizione.toString(),
                                                fillColor: kInfoBoxColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            color: kInfoBoxColor,
                                          ),
                                          child: const Text('Pagine'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Material(
                                              elevation: 2,
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              child: Material(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                                elevation: 5,
                                                child: TextField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  textAlign: TextAlign.left,
                                                  onChanged: (value) {
                                                    pagInizio = int.parse(value);
                                                  },
                                                  decoration: kInputDecoration.copyWith(
                                                    hintStyle: const TextStyle(
                                                      fontSize: 14,
                                                      shadows: [
                                                        Shadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey),
                                                      ],
                                                    ),
                                                    hintText: riferimento!.pag_inizio == null
                                                        ? 'Pagina inizio...'
                                                        : riferimento!.pag_inizio.toString(),
                                                    fillColor: kInfoBoxColor,
                                                    constraints: const BoxConstraints.tightFor(width: 130),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              elevation: 2,
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              child: Material(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                                elevation: 5,
                                                child: TextField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  textAlign: TextAlign.left,
                                                  onChanged: (value) {
                                                    pagFine = int.parse(value);
                                                  },
                                                  decoration: kInputDecoration.copyWith(
                                                    hintStyle: const TextStyle(
                                                      fontSize: 14,
                                                      shadows: [
                                                        Shadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey),
                                                      ],
                                                    ),
                                                    hintText: riferimento!.pag_fine == null
                                                        ? 'Pagina fine...'
                                                        : riferimento!.pag_fine.toString(),
                                                    fillColor: kInfoBoxColor,
                                                    constraints: const BoxConstraints.tightFor(width: 130),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      AlexandriaRoundedButton(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: const Text(
                                          'Indietro',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      AlexandriaRoundedButton(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: const Text(
                                          'Salva',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          riferimento!.descr_riferimento = descrizione;
                                          riferimento!.DOI = DOI;
                                          riferimento!.edizione = edizione;
                                          riferimento!.pag_inizio = pagInizio;
                                          riferimento!.pag_fine = pagFine;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
                            onPressed: () {
                              var tempURL = '';
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlexandriaDialog(
                                    title: const Text('Inserisci il link del riferimento.\n'
                                        'Se non presente, lasciare vuoto.'),
                                    actions: [
                                      AlexandriaRoundedButton(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: const Text(
                                          'Indietro',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      AlexandriaRoundedButton(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        child: const Text(
                                          'Salva',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          riferimento!.URL = tempURL;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                    content: Material(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(33),
                                      ),
                                      elevation: 5,
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        keyboardType: TextInputType.url,
                                        textAlign: TextAlign.left,
                                        onChanged: (value) {
                                          tempURL = value;
                                        },
                                        decoration: kInputDecoration.copyWith(
                                          hintText: riferimento!.URL ?? 'Inserisci URL...',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('Editore'),
                              Material(
                                borderRadius: const BorderRadius.all(Radius.circular(33)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    riferimento!.editore = value;
                                  },
                                  decoration: kInputDecoration.copyWith(
                                    hintText: riferimento!.editore ?? 'Inserisci testo...',
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
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('Luogo'),
                              Material(
                                borderRadius: const BorderRadius.all(Radius.circular(33)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    riferimento!.luogo = value;
                                  },
                                  decoration: kInputDecoration.copyWith(
                                    hintText: riferimento!.luogo ?? 'Inserisci testo...',
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
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('ISSN'),
                              Material(
                                borderRadius: const BorderRadius.all(Radius.circular(33)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    riferimento!.isnn = value;
                                  },
                                  decoration: kInputDecoration.copyWith(
                                    hintText: riferimento!.isnn ?? 'Inserisci testo...',
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
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('ISBN'),
                              Material(
                                borderRadius: const BorderRadius.all(Radius.circular(33)),
                                elevation: 5,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.left,
                                  onChanged: (value) {
                                    riferimento!.isbn = value;
                                  },
                                  decoration: kInputDecoration.copyWith(
                                    hintText: riferimento!.isbn ?? 'Inserisci testo...',
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
                  Container(
                    color: Colors.white,
                    width: 300,
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Autori...'),
                          AlexandriaRoundedButton(
                            child: const Icon(Icons.edit_note_outlined),
                            onPressed: () {
                              String? filtroUtente;
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (
                                      BuildContext builder,
                                      StateSetter setState,
                                    ) {
                                      return AlexandriaDialog(
                                        content: DecoratedBox(
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
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: Material(
                                                    borderRadius: const BorderRadius.all(Radius.circular(33)),
                                                    elevation: 5,
                                                    child: TextField(
                                                      style: const TextStyle(color: Colors.black),
                                                      keyboardType: TextInputType.text,
                                                      textAlign: TextAlign.left,
                                                      onChanged: (value) {
                                                        filtroUtente = value;
                                                        setState(() {});
                                                      },
                                                      decoration: kInputDecoration.copyWith(
                                                        hintText: 'Cerca autori...',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 450,
                                                  width: 300,
                                                  child: FutureBuilder(
                                                    future: allUtenti,
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
                                                          itemBuilder: (
                                                            BuildContext build,
                                                            int index,
                                                          ) {
                                                            final u = snapshot.data?[index];
                                                            if (filtroUtente == null ||
                                                                u!.nome.contains(
                                                                  RegExp(filtroUtente!),
                                                                ) ||
                                                                u.cognome.contains(RegExp(filtroUtente!)) ||
                                                                (u.nome + u.cognome).contains(RegExp(filtroUtente!))) {
                                                              return MiniInfoBox(
                                                                icon: Icons.person,
                                                                backgroundColor:
                                                                    autori.contains(u) ? Colors.grey : Colors.white,
                                                                name: u!.nome + u.cognome,
                                                                fontSize: 15,
                                                                onTap: () {
                                                                  if (autori.contains(u)) {
                                                                    autori.remove(u);
                                                                  } else {
                                                                    autori.add(u);
                                                                  }
                                                                  setState(() {});
                                                                },
                                                              );
                                                            } else {
                                                              return Container();
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
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AlexandriaRoundedButton(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                      top: 30,
                      bottom: 30,
                    ),
                    onPressed: () async {
                      print(isCreate);
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlexandriaDialog(
                            content: FutureBuilder(
                              future: isCreate ? creaRiferimento() : aggiornaRiferimento(),
                              builder: (BuildContext builder, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == null) {
                                    return const Center(child: Text('Errore!'));
                                  } else {
                                    return Center(child: Text('Riferimento ${isCreate ? 'creato!' : 'aggiornato!'}'));
                                  }
                                } else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Conferma',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<Riferimento?> creaRiferimento() async {
    final r = await networkHelper.createRiferimento(riferimento!, categorie[0], currentUser.user_ID, null);
    if (r != null) {
      for (var i = 1; i < categorie.length; ++i) {
        await networkHelper.aggiungiCategoria(r, categorie[i].id_categoria);
      }
      for (var i = 0; i < citazioni.length; ++i) {
        await networkHelper.aggiungiCitazione(r, citazioni[i].id_riferimento);
      }
      for (var i = 0; i < autori.length; ++i) {
        await networkHelper.aggiungiAutore(r, autori[i].user_ID);
      }
      (await allRiferimenti)?.add(r);
      return r;
    }
    return null;
  }

  Future<bool> aggiornaRiferimento() async {
    return networkHelper.aggiornaRiferimento(
      riferimento!,
      oldCategorie,
      categorie,
      oldCitazioni,
      citazioni,
      oldAutori,
      autori,
    );
  }
}
