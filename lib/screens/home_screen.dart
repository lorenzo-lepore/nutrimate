import 'package:nutrimate/widgets/home.dart';
import 'package:nutrimate/widgets/products.dart';
import 'package:nutrimate/widgets/scanner.dart';
import 'package:nutrimate/widgets/supermarkets.dart';
import 'package:nutrimate/widgets/user.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomBarIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const SupermarketsPage(),
    const ProductsPage(),
    const HomePage(),
    const ScannerPage(),
    const UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Text(
            widget.title,
            style: GoogleFonts.kadwa(
              color: Colors.black,
              fontSize: 32.0 /* 40.0 */,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _bottomBarIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        backgroundColor: const Color.fromARGB(244, 178, 218, 94),
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Supermercati',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: 'Prodotti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.barcode_reader),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilo',
          ),
        ],
        currentIndex: _bottomBarIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
