import 'package:flutter/material.dart';
import 'package:project/pages/CRUD/crudsystem.dart';
import 'package:project/pages/contextPage/favoritePage.dart';
import 'package:project/pages/contextPage/generatePage.dart';
import 'package:project/pages/map/map.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  int _currentIndex = 0;

  final List<String> _titles = ['Home', 'Favorites', 'CRUD', 'Map'];

  final List<Widget> _pages = [
    const Generatepage(),
    const FavoritesPage(),
    const Crud(),
    const MapPage(),
    ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),

      body: ColoredBox(
        color: const Color.fromARGB(255, 237, 237, 237),
        child: AnimatedSwitcher(
          duration: const Duration(microseconds: 300),
          child: _pages[_currentIndex], // this is swape page <--
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  color: theme,
                  alignment: Alignment.center,
                  child: Text(
                    _titles[_currentIndex],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            // class Icon { icons;}
            ListTile(
              textColor: theme,
              leading: Icon(Icons.shuffle, color: theme),
              title: const Text("Home"),
              selected: _currentIndex == 0,
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: theme,
              leading: Icon(Icons.favorite, color: theme),
              title: const Text("Favorite"),
              selected: _currentIndex == 1,
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: theme,
              leading: Icon(Icons.input, color: theme),
              title: const Text("CRUD"),
              selected: _currentIndex == 2,
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: theme,
              leading: Icon(Icons.map, color: theme),
              title: const Text("Map"),
              selected: _currentIndex == 3,
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
