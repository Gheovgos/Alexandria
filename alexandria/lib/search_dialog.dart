import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:alexandria/mini_info_box.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  String? filtroCategoria;
  String filtro = 'titolo';
  List<Categoria> categorie = [];
  List<tipo_enum> tipi = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    allCategories ??= networkHelper.findAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      scrollable: true,
      content: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(33)),
            elevation: 5,
            child: TextField(
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
              onChanged: (value) {},
              decoration:
                  kInputDecoration.copyWith(hintText: 'Inserisci titolo...'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('Articoli'),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('Libri'),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('Fascicoli'),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('Riviste'),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('Conferenze'),
                onPressed: () {},
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
                          scrollController.animateTo(
                            0,
                            duration: const Duration(microseconds: 1),
                            curve: Curves.linear,
                          );
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
                              controller: scrollController,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext build, int index) {
                                if (filtroCategoria == null ||
                                    snapshot.data![index].nome
                                        .contains(RegExp(filtroCategoria!))) {
                                  return MiniInfoBox(
                                    name: snapshot.data![index].nome,
                                    fontSize: 15,
                                  );
                                } else {
                                  return null;
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
                elevation: kButtonElevation,
                child: const Text('Titolo'),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: kButtonElevation,
                child: const Text('DOI'),
                onPressed: () {},
              ),
            ],
          ),
          AlexandriaRoundedButton(
            elevation: kButtonElevation,
            child: const Text('Autore'),
            onPressed: () {},
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        AlexandriaRoundedButton(
          border: const CircleBorder(),
          elevation: kButtonElevation,
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
          elevation: kButtonElevation,
          child: const Icon(
            Icons.search,
            size: 50,
          ),
          onPressed: () {
            // TODO(peppe): fai la ricerca e result_screen
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
