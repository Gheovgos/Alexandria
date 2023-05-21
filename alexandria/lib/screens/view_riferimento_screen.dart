import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/mini_info_box.dart';
import 'package:flutter/material.dart';

class ViewRiferimentoScreen extends StatefulWidget {
  const ViewRiferimentoScreen({super.key});

  @override
  State<ViewRiferimentoScreen> createState() => _ViewRiferimentoScreenState();
}

class _ViewRiferimentoScreenState extends State<ViewRiferimentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
                    children: const [
                      Text('Link associato:'),
                      MiniInfoBox(name: 'https://urlname.domain/text',icon: Icons.copy,),
                      Text('Desideri aprire il link?'),
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
                      // TODO(peppe): apri link
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
      ),
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
                        const Text(
                          'Titolo Riferimento',
                          style: TextStyle(fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Data: gg/mm/aaaa',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Edizione: Num',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
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
              child: const Text(
                'Luogo',
                style: TextStyle(fontSize: 16),
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
                children: const [
                  Text(
                    'Tipo riferimento',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('da pagina XXX a pagina YYY')
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
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return MiniInfoBox(
                              name: 'Autore $index',
                              fontSize: 15,
                            );
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
                      onPressed: () {},
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
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return MiniInfoBox(
                              name: 'Citazione $index',
                              fontSize: 15,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
