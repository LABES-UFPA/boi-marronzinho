import 'package:boi_marronzinho/app/modules/loja/troca/item_troca.dart';
import 'package:boi_marronzinho/app/modules/loja/troca/troca_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrocaView extends GetView<TrocaController> {
  const TrocaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFB12623),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: AppBarClipper(),
                    child: Container(
                      height: 100.h,
                      decoration: const BoxDecoration(
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
                                    Icons.cached,
                                    color: Colors.black,
                                    size: 30.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Center(
                                    child: Text(
                                      'Troca',
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
                child: Text(
                  'Itens aceitos para troca por Boicoins:',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.itensTroca.length,
                  itemBuilder: (context, index) {
                    final item = controller.itensTroca[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                      child: Box(item.nomeItem),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget Box(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
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
