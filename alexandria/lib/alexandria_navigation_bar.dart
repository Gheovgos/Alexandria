import 'package:flutter/material.dart';
import 'constants.dart';

class AlexandriaNavigationBar extends StatelessWidget {
  const AlexandriaNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 4:
            Navigator.pushNamed(context, 'settings');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), label: 'Riferimenti'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Crea'),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_outlined), label: 'Boh'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Impostazioni'),
      ],
      selectedItemColor: kAlexandriaGreen,
      unselectedItemColor: Colors.black,
    );
  }
}
