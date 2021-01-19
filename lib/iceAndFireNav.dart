import 'package:dart_ice_and_fire/screens/books/booksScreen.dart';
import 'package:dart_ice_and_fire/screens/characters/charactersScreen.dart';
import 'package:dart_ice_and_fire/screens/houses/housesScreen.dart';
import 'package:flutter/material.dart';

class IceAndFireNav extends StatefulWidget {
  @override
  _IceAndFireNavState createState() => _IceAndFireNavState();
}

class _IceAndFireNavState extends State<IceAndFireNav> {
  final screens = [CharactersScreen(), HousessScreen(), BooksScreen()];
  var _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_currentScreen),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_sharp), label: 'Characters'),
          BottomNavigationBarItem(
              icon: Icon(Icons.house_sharp), label: 'Houses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_sharp), label: 'Books'),
        ],
        currentIndex: _currentScreen,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        onTap: (selectedScreen) =>
            setState(() => _currentScreen = selectedScreen),
      ),
    );
  }
}
