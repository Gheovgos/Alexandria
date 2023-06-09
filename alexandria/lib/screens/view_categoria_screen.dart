import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/components/alexandria_navigation_bar.dart';
import 'package:alexandria/components/mini_info_box.dart';
import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:flutter/material.dart';

class ViewCategoriaScreen extends StatefulWidget {
  const ViewCategoriaScreen({super.key});

  @override
  State<ViewCategoriaScreen> createState() => _ViewCategoriaScreenState();
}

class _ViewCategoriaScreenState extends State<ViewCategoriaScreen> {
  @override
  Widget build(BuildContext context) {
    final categoria = ModalRoute.of(context)!.settings.arguments as Categoria?;
    return Scaffold(
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 3),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  right: 75,
                  left: 75,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    categoria!.nome,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 24),
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
                  'Riferimenti associati',
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
                        future: networkHelper.getRiferimentoByCategoria(categoria.id_categoria),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<List<Riferimento>?> snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MiniInfoBox(
                                  name: snapshot.data![index].titolo_riferimento,
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
                  'Sopra-categorie',
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
                        future: networkHelper.getSopraCategorie(categoria.id_categoria),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<List<Categoria>?> snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MiniInfoBox(
                                  name: snapshot.data![index].nome,
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
        ],
      ),
    );
  }
}
