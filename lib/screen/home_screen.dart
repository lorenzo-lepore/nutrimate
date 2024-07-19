import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nutrimate/widget/shopping_list.dart';
import 'package:nutrimate/widget/products.dart';
import 'package:nutrimate/widget/scanner.dart';
import 'package:nutrimate/widget/supermarkets.dart';

import 'package:nutrimate/provider/shopping_list_provider.dart';
import 'package:nutrimate/model/list_item.dart';
import 'package:nutrimate/service/connectivity_service.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ConnectivityService _connectivityService = ConnectivityService();
  late StreamSubscription<bool>? _subscription;
  late bool _isConnected;
  late bool _isFirstConnection;
  late bool _showFAB;
  late String _productName;
  late int _productQuantity;
  late int _bottomBarIndex;

  @override
  void initState() {
    super.initState();
    _showFAB = false;
    _bottomBarIndex = 2;
    _productName = '';
    _productQuantity = 0;
    _isFirstConnection = true;
    _subscription =
        _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
      if (!_isConnected) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Connessione assente. Le funzionalità sono limitate.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        _isFirstConnection = false;
      } else if (_isConnected && !_isFirstConnection) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Connessione ristabilita.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    if (_bottomBarIndex == 2) {
      _showFAB = true;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarIndex = index;
      if (_bottomBarIndex == 2) {
        _showFAB = true;
      } else {
        _showFAB = false;
      }
    });
  }

  List<Widget> _widgetOptions(StreamSubscription<bool> subscription) {
    return <Widget>[
      SupermarketsPage(subscription: subscription),
      const ProductsPage(),
      const ShoppingListPage(),
      const ScannerPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(255, 188, 185, 190),
            height: 1.0,
          ),
        ),
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Text(
            widget.title,
            style: GoogleFonts.kadwa(
              color: Colors.black,
              fontSize: 32.0,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _bottomBarIndex,
        children: _widgetOptions(_subscription!),
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
        ],
        currentIndex: _bottomBarIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      floatingActionButton: Visibility(
        visible: _showFAB,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(244, 178, 218, 94),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text('Aggiungi prodotto non tracciato',
                      style: GoogleFonts.kadwa(), textAlign: TextAlign.center),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autofocus: true,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nome prodotto',
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Inserisci un nome valido';
                                  }
                                  _productName = value.trim();
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: TextFormField(
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Quantità',
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.tryParse(value) == null ||
                                        int.tryParse(value)! <= 0) {
                                      return 'Inserisci una quantità valida';
                                    }
                                    _productQuantity = int.parse(value);
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: ButtonTheme(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          244, 178, 218, 94),
                                    ),
                                    child: const Text(
                                      'Aggiungi',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 82, 100, 45)),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<ShoppingListProvider>()
                                            .addToItemsList(
                                              ListItem(
                                                title: _productName,
                                                quantity: _productQuantity,
                                                status: false,
                                              ),
                                            );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Prodotto aggiunto'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Transform.scale(
            scale: 1.2,
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 82, 100, 45),
            ),
          ),
        ),
      ),
    );
  }
}
