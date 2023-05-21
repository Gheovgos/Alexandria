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
        switch (index) {
          case 0:
            Navigator.pushNamed(context, 'home');
            break;
          case 1:
            Navigator.pushNamed(context, 'my_riferimenti');
            break;
          case 3:
            Navigator.pushNamed(context, 'create_categoria');
            break;
          case 4:
            Navigator.pushNamed(context, 'settings');
            break;
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
