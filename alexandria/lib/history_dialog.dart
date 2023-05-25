import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:alexandria/mini_info_box.dart';
import 'package:flutter/material.dart';

class HistoryDialog extends StatefulWidget {
  const HistoryDialog({super.key});

  @override
  State<HistoryDialog> createState() => _HistoryDialogState();
}

class _HistoryDialogState extends State<HistoryDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      scrollable: true,
      content: Column(
        children: [
          const Text('Ultimi riferimenti inseriti:'),
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
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: FutureBuilder(
                    future: networkHelper
                        .getRiferimentoByUserId(currentUser.user_ID),
                    builder: (
                      context,
                      AsyncSnapshot<List<Riferimento>?> snapshot,
                    ) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return MiniInfoBox(
                              name:
                                  '${snapshot.data?[index].titolo_riferimento}',
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('Ultime citazioni ai tuoi riferimenti:'),
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
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: FutureBuilder(
                    future: networkHelper // TODO(peppe): citazioni!!!
                        .getRiferimentoByUserId(currentUser.user_ID),
                    builder: (
                      context,
                      AsyncSnapshot<List<Riferimento>?> snapshot,
                    ) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              '${snapshot.data?[index].titolo_riferimento}',
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        AlexandriaRoundedButton(
          border: const CircleBorder(),
          elevation: kButtonElevation,
          child: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        )
      ],
      title: const Text(
        'Cronologia',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
