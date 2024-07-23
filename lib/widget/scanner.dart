import 'package:flutter/material.dart';
import 'package:nutrimate/service/api_service.dart';
import 'package:nutrimate/screen/product_details_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  bool isValidBarcode(String? barcode) {
    return barcode != null && barcode.length == 13;
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
      ),
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          if (isValidBarcode(barcode.displayValue)) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Codice a barre valido. Fetch del prodotto...'),
                duration: Duration(seconds: 1),
              ),
            );
            ApiService().fetchProduct(barcode.displayValue!).then(
              (product) {
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      product: product,
                      showAddButton: true,
                    ),
                  ),
                );
                });
              },
            );
          }
        }
      },
    );
  }
}
