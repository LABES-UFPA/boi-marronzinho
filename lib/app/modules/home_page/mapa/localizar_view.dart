import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/modules/home_page/mapa/localizar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../componentes/AppBarClipper.dart';

class LocalizarView extends GetView<LocalizarController> {
  static const Color bgColor = Color(0xFFF69302);

  const LocalizarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
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
                                Icons.location_on,
                                color: Colors.black,
                                size: 30.sp,
                              ),
                              SizedBox(width: 5.w),
                              Center(
                                child: Text(
                                  'Localização',
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
          SizedBox(height: 20.h),
          Center(
              child: SizedBox(
            width: 0.85.sw, // 80% da tela
            height: 0.3.sh, // 30% da tela
            child: Card(
              margin: EdgeInsets.all(10.0.w),
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título -- Nome do Evento
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 22.h, horizontal: 10.w),
                      child: Text(
                        'Barracão do Boi Marronzinho',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0.sp,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                        onTap: () => controller.onVerLocationPressed(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(width: 1.w))),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              Text("Ver Localização")
                            ],
                          ),
                        )),
                  ),

                  // Botão para Ver Localização
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }

  Widget _buildAppBar({required String texto}) {
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
                          Icons.event,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        Center(
                          child: Text(
                            texto,
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
}
