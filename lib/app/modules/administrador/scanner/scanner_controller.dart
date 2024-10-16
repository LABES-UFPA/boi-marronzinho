import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends BaseController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    controller?.dispose();
    super.onClose();
  }

  
  void onQRViewCreated(QRViewController controller) {
    controller = controller;
    controller!.scannedDataStream.listen((scanData) {
      result = scanData;
      if (scanData.code == "VALOR_ESPERADO") {
        print("QR Code válido!");
      } else {
        print("QR Code inválido!");
      }
      update(); 
    });
  }
}
