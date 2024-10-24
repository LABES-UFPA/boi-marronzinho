import 'dart:convert';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_view.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/voucher_response/voucher_response.dart';

class VouchersView extends GetView<VouchersController> {
  const VouchersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFB12623),
        body: Column(
          children: [
            _buildAppBar(),
            SizedBox(height: 30.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading == true) {
                  return Center(
                      child: CircularProgressIndicator()); // Mostra um loading.
                }
                if (controller.vouchers.isEmpty) {
                  return Center(
                      child: Text(
                    'Nenhum voucher disponível.',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ));
                }

                return ListView.builder(
                  itemCount: controller.vouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = controller.vouchers[index];
                    Uint8List qrCodeImage = voucher.getQRCodeImage();
                    return InkWell(
                      onTap: voucher.validado ? null : () {
                        controller.onVoucherDetailPressed(voucher);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 10.h),
                        child: Box(voucher.nomeOficina, voucher.descricao,
                            qrCodeImage, voucher),
                      ),
                    );
                  },
                );
              }),
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
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10).h,
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icons/mingcute_arrow-up-fill.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.confirmation_num,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        Center(
                          child: Text(
                            'Vouchers',
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Box(String text, String descricao, Uint8List qrcode, Voucher voucher) {
    bool validado = voucher.validado;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: validado ? Colors.black26 : Colors.white,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 220.w,
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
                  
                  width: 220.w,
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
