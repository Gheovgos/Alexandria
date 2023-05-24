import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class AlexandriaNavigationBar extends StatelessWidget {
  const AlexandriaNavigationBar({
    required this.currentIndex,
    super.key,
  });
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              Navigator.popAndPushNamed(context, 'home');
            case 1:
              Navigator.popAndPushNamed(context, 'my_riferimenti');
            case 2:
              Navigator.popAndPushNamed(context, 'write_riferimento');
            case 3:
              Navigator.popAndPushNamed(context, 'create_categoria');
            case 4:
              Navigator.popAndPushNamed(context, 'settings');
          }
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Riferimenti',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Crea'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_outlined),
          label: 'Categorie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Impostazioni',
        ),
      ],
      selectedItemColor: kAlexandriaGreen,
      unselectedItemColor: Colors.black,
    );
  }
}
