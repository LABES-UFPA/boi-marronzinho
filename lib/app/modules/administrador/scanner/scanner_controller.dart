import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends BaseController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Rx<Barcode?> result = Rx<Barcode?>(null);
  QRViewController? controller;

  
  void onQRViewCreated(QRViewController qrController) {
    controller = qrController; // Armazena o controlador na variável de classe

    controller?.scannedDataStream.listen((scanData) {
      result.value = scanData; // Atualiza o resultado escaneado

      
      Future.delayed(Duration(seconds: 2), () {
        
        validarCode(scanData.code); 
      });
    });
  }

  // Defina sua função aqui
  Future<void> validarCode(String? qrCode) async {
    final voucherRepo = await VoucherRepository().validaVouchers(codigoQRCode: qrCode!);
    Lottie.asset('assets/animation/valid.json');
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
