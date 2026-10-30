import 'package:dart_ice_and_fire/screens/books/booksScreen.dart';
import 'package:dart_ice_and_fire/screens/characters/charactersScreen.dart';
import 'package:dart_ice_and_fire/screens/houses/housesScreen.dart';
import 'package:flutter/material.dart';

class IceAndFireNav extends StatefulWidget {
  const IceAndFireNav({super.key});

  @override
  State<IceAndFireNav> createState() => _IceAndFireNavState();
}

class _IceAndFireNavState extends State<IceAndFireNav> {
  final screens = [CharactersScreen(), HousessScreen(), BooksScreen()];
  var _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_currentScreen),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentScreen,
        onDestinationSelected: (index) =>
            setState(() => _currentScreen = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: 'Houses',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Books',
          ),
        ],
      ),
    );
  }
}
