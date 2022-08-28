import 'package:amond/widget/platform_based_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool _read = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_read) {
        _readData(scanData);
        Future.delayed(const Duration(seconds: 2))
            .then((_) => Navigator.of(context).pop());
      }
      setState(() {
        result = scanData;
      });
    });
  }

  void _readData(Barcode data) {
    print(data.code);
    // value 조건을 만족하면 동작 실행
    if (data.code == "value") {
      showDialog(
        context: context,
        builder: (_) => const AbsorbPointer(
          child: PlatformBasedIndicator(),
        ),
      );
      _read = true;
    }
    return;
  }
}
