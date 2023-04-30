import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      scrollable: true,
      content: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(33.0)),
            elevation: 5,
            child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                onChanged: (value) {},
                decoration:
                    kInputDecoration.copyWith(hintText: 'Inserisci titolo...')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Articoli"),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Libri"),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Fascicoli"),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Riviste"),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Conferenze"),
                onPressed: () {},
              ),
            ],
          ),
          const Text(
            "Categorie",
            style: TextStyle(fontSize: 16),
          ),
          Container(
            decoration: BoxDecoration(
                color: kAlexandriaGreen,
                borderRadius: BorderRadius.circular(50)),
            child: Text("da riempire"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("Titolo"),
                onPressed: () {},
              ),
              AlexandriaRoundedButton(
                elevation: 2,
                child: const Text("DOI"),
                onPressed: () {},
              ),
            ],
          ),
          AlexandriaRoundedButton(
            elevation: 2,
            child: const Text("Autore"),
            onPressed: () {},
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        AlexandriaRoundedButton(
            border: const CircleBorder(),
            elevation: 2,
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
            }),
        AlexandriaRoundedButton(
          elevation: 2,
          child: const Icon(
            Icons.search,
            size: 50,
          ),
          onPressed: () {
            //TODO: prendi i dati, fai la ricerca e vai a search_result_screen
          },
        )
      ],
      title: const Text(
        "Ricerca",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
