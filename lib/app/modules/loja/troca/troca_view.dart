import 'package:auto_size_text/auto_size_text.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/modules/loja/troca/troca_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrocaView extends GetView<TrocaController> {
  const TrocaView({super.key});


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
              _buildAppBar(texto: 'Trocas'),
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
                      child: Box(item),
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

  Widget Box(ItemTroca item) {
    return InkWell(
      onTap: () {
          Get.to(() => _buildConversor(item));
      },
      child: Container(
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
                  item.nomeItem,
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
      ),
    );
  }
  
  Widget _buildConversor(ItemTroca item) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildAppBar(
                    texto: '',
                    showIcon: false,
                    customCallbackOnExit: () {
                      controller.quantidadeController.clear();
                      controller.boicoins.value = 0;
                    }),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: AutoSizeText(
                            'Conversor de Boicoins',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        10.verticalSpace,
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Expanded(child: Icon(Icons.arrow_circle_right_outlined)),
                                    Expanded(
                                      flex: 2,
                                      child: AutoSizeText(
                                        item.nomeItem,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: controller.quantidadeController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: item.unidadeMedida.capitalizeFirst,
                                    hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Icon(
                          Icons.swap_horiz_outlined,
                          size: 50.sp,
                        ),
                        20.verticalSpace,
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/icons/boicoin.png', scale: 0.5),
                                    Text(
                                      'Boicoins',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Obx(() {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150), // Duração mais rápida
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      return ScaleTransition(
                                        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut), // Curva mais rápida e suave
                                        child: child,
                                      );
                                    },
                                    child: Text(
                                      controller.boicoins.value.toString(),
                                      key: ValueKey<int>(controller.boicoins.value),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        SizedBox(
                          width: 1.sw,
                          height: 100,
                          child: _buildButton('Calcular', Colors.red, () {
                            controller.onCalcularPressed(item);
                          })
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

  Widget _buildAppBar({required String texto, bool showIcon = true, Function? customCallbackOnExit}) {
    if (showIcon) {
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
                        if (customCallbackOnExit != null) {
                          customCallbackOnExit();
                        }
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
                      if (customCallbackOnExit != null) {
                        customCallbackOnExit();
                      }
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
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
    
  // Butao
  Widget _buildButton(String buttonText, Color buttonColor, Function callback) {
    return InkWell(
      onTap: () => callback(),
      child: Container(
        width: 0.87.sw,
        height: 50.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20).r,
                bottomLeft: const Radius.circular(20).r,
                bottomRight: const Radius.circular(20).r)),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
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
