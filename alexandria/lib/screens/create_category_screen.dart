import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

import '../alexandria_rounded_button.dart';
import '../mini_info_box.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AlexandriaNavigationBar(currentIndex: 3,),
      backgroundColor: kAlexandriaGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                const Text(
                  "Nome Categoria",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      onChanged: (value) {},
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Inserisci nome...')),
                ),
                const Text(
                  "Sotto-Categoria",
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        child: Container(
                          width: 320,
                          decoration: BoxDecoration(
                              color: kAlexandriaGreen,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20, bottom: 15),
                            child: Column(
                              children: [
                                Material(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(33.0)),
                                  elevation: 5,
                                  child: TextField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) {},
                                      decoration: kInputDecoration.copyWith(
                                          hintText: 'Cerca categoria...')),
                                ),
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MiniInfoBox(
                                          name: "Categoria $index");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,)
              ],
            ),
          ),
          const SizedBox(height: 30,),
          AlexandriaRoundedButton(
            padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
            elevation: 2,
            child: const Text(
              "Salva",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
