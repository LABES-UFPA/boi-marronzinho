import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BoiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String texto;
  final IconData? icon;
  final String backArrowImagePath;
  final Function? customCallbackOnExit;

  const BoiAppBar(
      {super.key,
      required this.texto,
      required this.icon,
      this.backArrowImagePath = 'assets/images/icons/mingcute_arrow-up-fill.png',
      this.customCallbackOnExit
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: 100.h,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icons/mingcute_arrow-up-fill.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                    onPressed: () {
                      if (customCallbackOnExit != null) {
                        customCallbackOnExit!();
                      }
                      Get.back();
                    },
                  ),
                  Visibility(
                    visible: icon != null,
                    child: Icon(icon),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5.w),
                        Expanded(
                          child: AutoSizeText(
                            texto,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

  @override
  Size get preferredSize =>
      Size.fromHeight(100.h); // Define a altura preferida da AppBar
}

// Caso precise
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

