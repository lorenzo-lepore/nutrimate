import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/groceries3.svg',
            height: 300.0,
            width: 300.0,
          ),
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
        ],
      ),
    );
  }
}
