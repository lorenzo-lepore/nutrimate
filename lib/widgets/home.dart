import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String assetName = 'assets/groceries3.svg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName, height: 300.0, width: 300.0, ),
            // Image.asset('assets/groceries.svg'),
            Text(
              'lista vuota',
              style: GoogleFonts.nunito(color: Colors.black, fontSize: 32.0),
            ),
            const Text(
              'La tua lista è vuota. Aggiungi dei prodotti manualmente o scannerizzandoli.',
              style: TextStyle(fontSize: 16.0),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            /* const SizedBox(height: 16.0),
              Text(
                'La tua lista',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      child: ListTile(
                        title: Text('Card $index'),
                      ),
                    ),
                  ),
                ),
              ), */
          ],
        ),
      ),
    );
  }
}
