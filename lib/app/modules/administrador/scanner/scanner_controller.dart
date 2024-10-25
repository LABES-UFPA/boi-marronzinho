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
  bool isRequestInProgress = false; // Controle de requisição
  bool _isValidating = false; // Controle de validação

  void onQRViewCreated(QRViewController qrController) {
    controller = qrController;

    controller?.scannedDataStream.listen((scanData) {
      if (!isRequestInProgress) {
        // Se não há uma requisição em andamento
        isRequestInProgress = true;
        controller?.pauseCamera(); // Pausa a câmera para evitar múltiplas leituras
        result.value = scanData;

        // Faz a validação do QR code
        validarCode(scanData.code).then((_) {
          // Após a validação, retoma a câmera
          isRequestInProgress = false;
          controller?.resumeCamera(); // Retoma a câmera após a validação
        });
      }
    });
  }

  Future<void> validarCode(String? qrCode) async {
    try {
      // Impede novas validações enquanto uma está em andamento
      if (_isValidating) return;

      _isValidating = true; // Marca que a validação está em andamento

      final voucherRepo = await VoucherRepository().validaVouchers(codigoQRCode: qrCode!);
      if (voucherRepo != null) {
        Get.dialog(
          Dialog(
            child: Lottie.asset('assets/animation/valid.json'),
          ),
        );

        // Aguarda 2 segundos antes de fechar o diálogo e a câmera
        await Future.delayed(Duration(seconds: 3));

        // Fecha o diálogo da animação
        Get.back();

        // Chama a função para fechar a câmera
        fecharCamera(); 
      } else {
        // Exibe erro se a validação falhar
        print('Validação falhou');
      }
    } catch (e) {
      print('Erro ao validar o QR code: $e');
    } finally {
      _isValidating = false; // Reseta a flag independentemente do resultado
    }
  }

  void fecharCamera() {
    // Fecha a câmera (ou navega de volta para outra tela)
    Get.back(); 
  }

  @override
  void onInit() {
    super.onInit();
    isRequestInProgress = false; // Reseta a flag quando o controlador é inicializado
  }

  @override
  void onClose() {
    controller?.dispose(); // Libera o controlador de QRView
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    isRequestInProgress = false; // Reseta a flag ao reentrar na view
  }
}
