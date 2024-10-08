import 'package:boi_marronzinho/app/modules/pix/pix_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PixView extends GetView<PixController> {
  PixView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF660D0D),
        body: Column(
          children: [
            Container(
              height: 100.h,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
              child: Column(
                children: [
                  Text(
                    'QR CODE',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/teste.png",
                      width: 200.0.w,
                      height: 275.0.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Chave Pix',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Box(context, '55518695000190', true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Box(BuildContext context, String text, bool canCopy) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (canCopy)
            IconButton(
              icon: Icon(Icons.copy, color: Colors.grey),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Texto copiado!')),
                );
              },
            ),
        ],
      ),
    );
  }
}
