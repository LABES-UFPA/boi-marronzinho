import 'dart:convert';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/modules/vouchers/voucher_model.dart';
import 'package:boi_marronzinho/app/modules/vouchers/vouchers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VouchersView extends GetView<VouchersController> {
  const VouchersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Voucher> vouchers = [
      Voucher(
        id: '1',
        usuarioId: 'user123',
        nomeOficina: 'Oficina A',
        descricao: 'Descrição do voucher A bla bla bla',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAUoAAAFKAQAAAABTUiuoAAACAUlEQVR4nO2bQcrbMBCFv6kFWcrQA+Qo8g16ph6pN7CPkgMUrGVA5nVhOb//QMFuceLSmUUiK9/iwaDozUxiYmMMX7aS4KijjjrqqKNHolYjAExmXQ5AXra7wwU4ugdNkqQRGOwifW/BOhpJkj6jxwhwdEuE+p5bSD+AJLA0fkVkMGjKoQIc/QvUOoDhWurq5QIc3YMOLah/owBHfx/LN2EUkEEwBdItFNXHgwU4uh8dzMysBevyZU6RdUyzJXyFAEe3xHy2Po6QyJOJPFk9b0cLcHQHSvXoUVIPqI9l3lt9IEnq367V0ZqtNL8UID4KrFhWiGfrRGg2U58vIt1C9YRprEfNuhcIcHRD1HtraJvC8K2g4Vow4oiRW4BGdqQAR3dnq+YjGxCnAEzV2qfxYAGO/qHLkMrSMZxXBUnF763ToA+X8XAUI0uiRpitRvJsnQvNgcUTFtTTqPaglmL5RFr/X3Tt4IHqBLV6bLzeOg266mUIwIiqc5LUgz2KrhNodXRGn2bHs8sgV19o3eECHN2Dfp4dm7WTLb2MyeoA5SxaHSXXn1/UNsYtzH15yBdZ9wIBjm6I8LxRh/xNWYb8d5+YnBcdrnezLt7r5TWYO/jzoM+zYyOCyC1G/BlIHzOut2t1dF1bQaO5wOo/VrFWY15vnQA1/9eCo4466qij/xD6Cwn5KvJjPSxjAAAAAElFTkSuQmCC',
      ),
      Voucher(
        id: '2',
        usuarioId: 'user456',
        nomeOficina: 'Oficina B',
        descricao: 'Descrição do voucher B',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAUoAAAFKAQAAAABTUiuoAAACAUlEQVR4nO2bQcrbMBCFv6kFWcrQA+Qo8g16ph6pN7CPkgMUrGVA5nVhOb//QMFuceLSmUUiK9/iwaDozUxiYmMMX7aS4KijjjrqqKNHolYjAExmXQ5AXra7wwU4ugdNkqQRGOwifW/BOhpJkj6jxwhwdEuE+p5bSD+AJLA0fkVkMGjKoQIc/QvUOoDhWurq5QIc3YMOLah/owBHfx/LN2EUkEEwBdItFNXHgwU4uh8dzMysBevyZU6RdUyzJXyFAEe3xHy2Po6QyJOJPFk9b0cLcHQHSvXoUVIPqI9l3lt9IEnq367V0ZqtNL8UID4KrFhWiGfrRGg2U58vIt1C9YRprEfNuhcIcHRD1HtraJvC8K2g4Vow4oiRW4BGdqQAR3dnq+YjGxCnAEzV2qfxYAGO/qHLkMrSMZxXBUnF763ToA+X8XAUI0uiRpitRvJsnQvNgcUTFtTTqPaglmL5RFr/X3Tt4IHqBLV6bLzeOg266mUIwIiqc5LUgz2KrhNodXRGn2bHs8sgV19o3eECHN2Dfp4dm7WTLb2MyeoA5SxaHSXXn1/UNsYtzH15yBdZ9wIBjm6I8LxRh/xNWYb8d5+YnBcdrnezLt7r5TWYO/jzoM+zYyOCyC1G/BlIHzOut2t1dF1bQaO5wOo/VrFWY15vnQA1/9eCo4466qij/xD6Cwn5KvJjPSxjAAAAAElFTkSuQmCC',
      ),
      Voucher(
        id: '3',
        usuarioId: 'user789',
        nomeOficina: 'Oficina C',
        descricao: 'Descrição do voucher C',
        qrcode:
            'iVBORw0KGgoAAAANSUhEUgAAAUoAAAFKAQAAAABTUiuoAAACAUlEQVR4nO2bQcrbMBCFv6kFWcrQA+Qo8g16ph6pN7CPkgMUrGVA5nVhOb//QMFuceLSmUUiK9/iwaDozUxiYmMMX7aS4KijjjrqqKNHolYjAExmXQ5AXra7wwU4ugdNkqQRGOwifW/BOhpJkj6jxwhwdEuE+p5bSD+AJLA0fkVkMGjKoQIc/QvUOoDhWurq5QIc3YMOLah/owBHfx/LN2EUkEEwBdItFNXHgwU4uh8dzMysBevyZU6RdUyzJXyFAEe3xHy2Po6QyJOJPFk9b0cLcHQHSvXoUVIPqI9l3lt9IEnq367V0ZqtNL8UID4KrFhWiGfrRGg2U58vIt1C9YRprEfNuhcIcHRD1HtraJvC8K2g4Vow4oiRW4BGdqQAR3dnq+YjGxCnAEzV2qfxYAGO/qHLkMrSMZxXBUnF763ToA+X8XAUI0uiRpitRvJsnQvNgcUTFtTTqPaglmL5RFr/X3Tt4IHqBLV6bLzeOg266mUIwIiqc5LUgz2KrhNodXRGn2bHs8sgV19o3eECHN2Dfp4dm7WTLb2MyeoA5SxaHSXXn1/UNsYtzH15yBdZ9wIBjm6I8LxRh/xNWYb8d5+YnBcdrnezLt7r5TWYO/jzoM+zYyOCyC1G/BlIHzOut2t1dF1bQaO5wOo/VrFWY15vnQA1/9eCo4466qij/xD6Cwn5KvJjPSxjAAAAAElFTkSuQmCC',
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFB12623),
        body: Column(
          children: [
            Stack(
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
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  Uint8List qrCodeImage = voucher.getQRCodeImage();
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 10.h),
                      child: Box(voucher.nomeOficina, voucher.descricao,
                          voucher.getQRCodeImage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Box(String text, String descricao, Uint8List qrcode) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
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
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 180.w,
                  child: Text(
                    descricao,
                    softWrap:
                        true, // Permite que o texto quebre para a próxima linha
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

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 60, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
