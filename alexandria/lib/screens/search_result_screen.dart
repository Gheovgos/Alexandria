import 'package:alexandria/Model/Ricerca.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/alexandria_rounded_button.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    var sortedAscending = false;
    final ricerca = ModalRoute.of(context)!.settings.arguments as Ricerca?;
    return Scaffold(
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 0,
      ),
      backgroundColor: kAlexandriaGreen,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                      ),
                    ),
                    child: Text(
                      'Risultati per ${ricerca?.testo}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 15)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Ordina:',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AlexandriaRoundedButton(
                    onPressed: () {
                      ricerca?.data?.sort((a, b) {
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: kAlexandriaGreen,
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ricerca?.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MiniInfoBox(
                          name: ricerca!.data![index].titolo_riferimento,
                          onTapIcon: () {
                            Navigator.pushNamed(
                              context,
                              'view_riferimento',
                              arguments: ricerca.data![index],
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
