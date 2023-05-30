import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Ricerca.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/components/alexandria_dialog.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  String testo = '';
  String? filtroCategoria;
  String filtro = 'titolo';
  Categoria? categoria;
  List<tipo_enum> tipi = [tipo_enum.Articolo];
  @override
  void initState() {
    super.initState();
    allCategories ??= networkHelper.findAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AlexandriaDialog(
      content: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(33)),
            elevation: 5,
            child: TextField(
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
              onChanged: (value) {
                testo = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Inserisci $filtro...'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlexandriaRoundedButton(
                backgroundColor: tipi.contains(tipo_enum.Articolo)
                    ? Colors.grey
                    : Colors.white,
                borderColor: tipi.contains(tipo_enum.Articolo)
                    ? Colors.grey
                    : Colors.white,
                child: const Text('Articoli'),
                onPressed: () {
                  if (tipi.contains(tipo_enum.Articolo) && tipi.length != 1) {
                    tipi.remove(tipo_enum.Articolo);
                  } else {
                    tipi.add(tipo_enum.Articolo);
                  }
                  setState(() {});
                },
              ),
              AlexandriaRoundedButton(
                backgroundColor:
                    tipi.contains(tipo_enum.Libro) ? Colors.grey : Colors.white,
                borderColor:
                    tipi.contains(tipo_enum.Libro) ? Colors.grey : Colors.white,
                child: const Text('Libri'),
                onPressed: () {
                  if (tipi.contains(tipo_enum.Libro) && tipi.length != 1) {
                    tipi.remove(tipo_enum.Libro);
                  } else {
                    tipi.add(tipo_enum.Libro);
                  }
                  setState(() {});
                },
              ),
              AlexandriaRoundedButton(
                backgroundColor: tipi.contains(tipo_enum.Fascicolo)
                    ? Colors.grey
                    : Colors.white,
                borderColor: tipi.contains(tipo_enum.Fascicolo)
                    ? Colors.grey
                    : Colors.white,
                child: const Text('Fascicoli'),
                onPressed: () {
                  if (tipi.contains(tipo_enum.Fascicolo) && tipi.length != 1) {
                    tipi.remove(tipo_enum.Fascicolo);
                  } else {
                    tipi.add(tipo_enum.Fascicolo);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlexandriaRoundedButton(
                backgroundColor: tipi.contains(tipo_enum.Rivista)
                    ? Colors.grey
                    : Colors.white,
                borderColor: tipi.contains(tipo_enum.Rivista)
                    ? Colors.grey
                    : Colors.white,
                child: const Text('Riviste'),
                onPressed: () {
                  if (tipi.contains(tipo_enum.Rivista) && tipi.length != 1) {
                    tipi.remove(tipo_enum.Rivista);
                  } else {
                    tipi.add(tipo_enum.Rivista);
                  }
                  setState(() {});
                },
              ),
              AlexandriaRoundedButton(
                backgroundColor: tipi.contains(tipo_enum.Conferenza)
                    ? Colors.grey
                    : Colors.white,
                borderColor: tipi.contains(tipo_enum.Conferenza)
                    ? Colors.grey
                    : Colors.white,
                child: const Text('Conferenze'),
                onPressed: () {
                  if (tipi.contains(tipo_enum.Conferenza) && tipi.length != 1) {
                    tipi.remove(tipo_enum.Conferenza);
                  } else {
                    tipi.add(tipo_enum.Conferenza);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
          const Text(
            'Categorie',
            style: TextStyle(fontSize: 16),
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 2,
            child: DecoratedBox(
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
                      borderRadius: const BorderRadius.all(Radius.circular(33)),
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
                      height: 100,
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
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext build, int index) {
                                if (filtroCategoria == null ||
                                    snapshot.data![index].nome
                                        .contains(RegExp(filtroCategoria!))) {
                                  return MiniInfoBox(
                                    backgroundColor:
                                        categoria == snapshot.data![index]
                                            ? Colors.grey
                                            : Colors.white,
                                    name: snapshot.data![index].nome,
                                    fontSize: 15,
                                    onTap: () {
                                      if (categoria != snapshot.data![index]) {
                                        categoria = snapshot.data![index];
                                      }
                                      setState(() {});
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlexandriaRoundedButton(
                backgroundColor:
                    filtro == 'titolo' ? Colors.grey : Colors.white,
                borderColor: filtro == 'titolo' ? Colors.grey : Colors.white,
                child: const Text('Titolo'),
                onPressed: () {
                  filtro = 'titolo';
                  setState(() {});
                },
              ),
              AlexandriaRoundedButton(
                backgroundColor: filtro == 'DOI' ? Colors.grey : Colors.white,
                borderColor: filtro == 'DOI' ? Colors.grey : Colors.white,
                child: const Text('DOI'),
                onPressed: () {
                  filtro = 'DOI';
                  setState(() {});
                },
              ),
            ],
          ),
          AlexandriaRoundedButton(
            backgroundColor: filtro == 'autore' ? Colors.grey : Colors.white,
            borderColor: filtro == 'autore' ? Colors.grey : Colors.white,
            onPressed: () {
              filtro = 'autore';
              setState(() {});
            },
            child: const Text('Autore'),
          ),
        ],
      ),
      actions: [
        AlexandriaRoundedButton(
          border: const CircleBorder(),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        AlexandriaRoundedButton(
          child: const Icon(
            Icons.search,
            size: 50,
          ),
          onPressed: () async {
            // TODO(peppe): fai la ricerca e result_screen

            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlexandriaDialog(
                  content: FutureBuilder(
                    future: networkHelper.ricerca(
                      filtro == 'titolo' ? testo : null,
                      filtro == 'DOI' ? int.parse(testo) : null,
                      filtro == 'autore' ? testo : null,
                      categoria,
                      tipi,
                    ),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Riferimento>?> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Navigator.popAndPushNamed(
                            context,
                            'results',
                            arguments: Ricerca(testo, snapshot.data),
                          );
                        });
                        return const Center(child: Text('Apro la pagina...'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              },
            );
          },
        )
      ],
      title: const Text(
        'Ricerca',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
