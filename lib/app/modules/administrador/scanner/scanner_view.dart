import 'dart:convert';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/componentes/BoiAppBar.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerView extends GetView<ScannerController> {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BoiAppBar(texto: 'Scannear Voucher', icon: null),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.black,
                  borderRadius: 10.r,
                  borderLength: 30.r,
                  borderWidth: 10.r,
                  cutOutSize: 300.w,
                ),
              ),
            ),
            //SizedBox(height: 10.h,),
            Expanded(
              flex: 1,
              child: Obx(() {
                if (controller.result.value != null) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 20.w), // Aplicando Padding diretamente
                    child: Center(
                      child: Text(
                        'Código QR identificado',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 20.w), // Aplicando Padding aqui também
                    child: Center(
                      child: Text(
                        'Aponte a câmera para um QR Code',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

}

class ButtonBox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ButtonBox({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF69302),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.all(14.h)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold, // Deixar o texto em negrito
            color: Colors.black, // Cor do texto (preto)
          ),
        ),
      ),
    );
  }
}
