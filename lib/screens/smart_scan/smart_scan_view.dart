import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/smart_scan_viewmodel.dart';

class SmartScanView extends StatelessWidget {
  const SmartScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final scanVM = Provider.of<SmartScanViewModel>(context, listen: false);

    final controller = MobileScannerController(); // allowDuplicates REMOVED

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Scan"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          for (final barcode in capture.barcodes) {
            final code = barcode.rawValue ?? "Unknown";

            // Save to Firebase
            scanVM.saveScannedData(code);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Scanned: $code")),
            );
          }
        },
      ),
    );
  }
}
