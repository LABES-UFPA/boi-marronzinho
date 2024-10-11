import 'package:boi_marronzinho/app/modules/administrador/admin_controller.dart';
import 'package:boi_marronzinho/app/modules/loja/troca/item_troca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF660D0D),
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
                                  Icons.manage_accounts_outlined,
                                  color: Colors.black,
                                  size: 30.sp,
                                ),
                                SizedBox(width: 5.w),
                                Center(
                                  child: Text(
                                    'Administrador',
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
            SizedBox(height: 44.h,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 22.w),
              child: Column(
                children: [
                  Box('Eventos', (){controller.onEventosPressed();}),
                  SizedBox(height: 20.h),
                  Box('Produtos',(){controller.onProdutosPressed();}),
                  SizedBox(height: 20.h),
                  Box('Oficinas', (){controller.onOficinasPressed();}),
                  SizedBox(height: 20.h),
                  Box('Troca Produto por BC', (){controller.onTrocarProdutoPressed();}),
                  SizedBox(height: 20.h),
                  Box('Contas Cadastradas', (){controller.onContasPressed();}),
                  SizedBox(height: 20.h),
                  Box('Scannear QR Code', (){controller.onScannerPressed();}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Box(String text, VoidCallback onPressed) {
    return InkWell(
      onTap:(){},
        //onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20).r,
            bottomRight: Radius.circular(20).r,
            topLeft: Radius.circular(20).r,
          ),
        ),
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
