import 'package:alexandria/alexandria_navigation_bar.dart';
import 'package:alexandria/alexandria_rounded_button.dart';
import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

import '../mini_info_box.dart';

class MyRiferimentiScreen extends StatefulWidget {
  const MyRiferimentiScreen({Key? key}) : super(key: key);

  @override
  State<MyRiferimentiScreen> createState() => _MyRiferimentiScreenState();
}

class _MyRiferimentiScreenState extends State<MyRiferimentiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kAlexandriaGreen,
      bottomNavigationBar: const AlexandriaNavigationBar(
        currentIndex: 1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10,),
                const Text(
                  "Riferimenti creati",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(33.0)),
                        elevation: 5,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          onChanged: (value) {},
                          decoration: kInputDecoration.copyWith(
                              hintText: 'Cerca riferimento...'),
                        ),
                      ),
                    ),
                    AlexandriaRoundedButton(
                      elevation: 2,
                      child: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Ordina:"),
                AlexandriaRoundedButton(
                  elevation: 2,
                  onPressed: () {},
                  child: const Icon(Icons.filter_list_outlined),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kAlexandriaGreen,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 15),
                    child: SizedBox(
                      height: 240,
                      width: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return MiniInfoBox(
                            name: "Riferimento $index",
                            fontSize: 15,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlexandriaRoundedButton(
                      onPressed: () {},
                      elevation: 2,
                      child: const Text("Modifica",
                          style: TextStyle(fontSize: 15)),
                    ),
                    AlexandriaRoundedButton(
                      onPressed: () {},
                      elevation: 2,
                      child: const Text("Cancella",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                AlexandriaRoundedButton(
                  onPressed: () {},
                  elevation: 2,
                  child: const Text(
                    "Visualizza",
                    style: TextStyle(fontSize: 15),
                  ),
                )
                ,
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
