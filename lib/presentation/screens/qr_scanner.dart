import 'package:amond/presentation/screens/grow/util/mission.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  static const String routeName = '/qr-scanner';

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
    controller?.pauseCamera();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.grey,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              '미션완료 QR코드를 스캔해주세요!',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 16.0, height: 1.5),
            )),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!_read) {
        _readData(scanData);
      }
    });
  }

  void _readData(Barcode data) {
    if (missionMap.containsKey(data.code)) {
      _read = true;
      Navigator.of(context).pop(missionMap[data.code]);
    }
    return;
  }
}
