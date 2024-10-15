import 'package:boi_marronzinho/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      controller.nextScreen();
    });
    return Scaffold(
        backgroundColor: const Color(0xFFF69302),
        body: Center(
            child: SizedBox(
              width: 200.0.w,
            height: 375.0.h,
          child: Image.asset(
            "assets/images/logo/logo_boi_marronzinho.png",
            fit: BoxFit.contain,
          ),
        )));
  }
}
