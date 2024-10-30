import 'dart:convert';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_view.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/voucher/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/models/voucher_response/voucher_response.dart';

class VoucherView extends GetView<VoucherController> {
  const VoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final voucher = Get.arguments as Voucher;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFB12623),
        body: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Center(
                    // Centraliza todo o conteúdo da coluna
                    child: Column(
                      children: [
                        Text(
                          'QR Code de ${voucher.nomeOficina}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Centraliza o texto
                        ),
                        SizedBox(
                            height: 20.h), // Espaçamento entre os elementos
                        Text(
                          'Apresente ele na entrada da oficina',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center, // Centraliza o texto
                        ),
                        SizedBox(height: 6.h), // Espaçamento antes do QR Code
                        Center(
                          child: Image.network(
                            controller.apiHelpers.buildUrl(url: utf8.decode(base64Decode(voucher.qrcode)), endpoint: Endpoints.MINIO),
                            height: 280.h,
                            width: 280.w,
                          ),
                        ),
                        SizedBox(
                            height: 30.h), // Espaçamento antes da descrição
                        Text(
                          voucher.descricao,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center, // Centraliza o texto
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Color(0xFFB12623),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10).h,
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icons/mingcute_arrow-up-fill-branco.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Box(String text, String descricao, Uint8List qrcode) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.memory(
            qrcode,
            height: 130.h,
            width: 130.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 180.w,
                  child: Text(
                    text,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  width: 180.w,
                  child: Text(
                    descricao,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
