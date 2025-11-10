import 'package:flutter/material.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';
import 'card4.dart'; // NOUVEL IMPORT pour EcranSettings

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // AJOUT de EcranSettings() à la liste des pages
  static List<Widget> pages = <Widget>[
    Ecran1(), 
    Ecran2(), 
    Ecran3(), 
    EcranSettings(), // La quatrième page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TD2 App',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Card1'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Card2'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Card3'),
          // AJOUT DU QUATRIÈME BOUTON de navigation
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}