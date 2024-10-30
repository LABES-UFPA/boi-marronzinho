import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/componentes/BoiAppBar.dart';
import 'package:boi_marronzinho/app/modules/componentes/boiButton.dart';
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
        appBar: const BoiAppBar(texto: 'Trocas', icon: Icons.cached),
        backgroundColor: const Color(0xFFB12623),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 10.h),
                      child: Box(item, () {
                        controller.itemSelecionado =
                            controller.itensTroca[index];
                      }, context),
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

  Widget Box(ItemTroca item, Function callbackOnPressed, BuildContext context) {
    return InkWell(
      onTap: () {
        callbackOnPressed();
        Get.to(() => _buildConversor(item, context));
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

  Widget _buildConversor(ItemTroca item, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BoiAppBar(
          texto: '',
          icon: null,
          customCallbackOnExit: () {
            controller.quantidadeController.clear();
            controller.boicoins.value = 0;
          },
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                          child: Icon(Icons
                                              .arrow_circle_right_outlined)),
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
                                      hintText:
                                          item.unidadeMedida.capitalizeFirst,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/icons/boicoin.png',
                                          scale: 0.5),
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
                                      duration: const Duration(
                                          milliseconds:
                                              150), // Duração mais rápida
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: CurvedAnimation(
                                              parent: animation,
                                              curve: Curves
                                                  .easeInOut), // Curva mais rápida e suave
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        controller.boicoins.value.toString(),
                                        key: ValueKey<int>(
                                            controller.boicoins.value),
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
                        ],
                      ),
                      20.verticalSpace,
                      SizedBox(
                          width: 1.sw,
                          height: 100,
                          child: BoiButton(
                              text: 'Realizar Troca',
                              color: const Color(0xFF00A91B),
                              callbackOnPressed: () {
                                if (controller
                                    .quantidadeController.text.isEmpty) {
                                  return Toast.error(
                                      'Insira um valor válido na unidade!',
                                      'Não deixe vazio');
                                }
                                Get.to(_buildPageConfirmacao(
                                    item,
                                    controller.boicoins.value,
                                    double.parse(
                                        controller.quantidadeController.text),
                                    context));
                              },
                              width: double.infinity,
                              height: 100.h)),
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

  Widget _buildPageConfirmacao(ItemTroca item, int boicoins,
      double quantidadeItem, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const BoiAppBar(texto: '', icon: null),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text('Você deseja realizar esta troca?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                      textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // Item
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
                                  const Expanded(
                                      child: Icon(
                                          Icons.arrow_circle_right_outlined)),
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
                                child: Text(
                              quantidadeItem.toString(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'Por',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.sp),
                      ),
                      10.verticalSpace,
                      // Quantidade de Boicoins
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
                                  Image.asset('assets/images/icons/boicoin.png',
                                      scale: 0.5),
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
                                  duration: const Duration(
                                      milliseconds: 150), // Duração mais rápida
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                      scale: CurvedAnimation(
                                          parent: animation,
                                          curve: Curves
                                              .easeInOut), // Curva mais rápida e suave
                                      child: child,
                                    );
                                  },
                                  child: Text(
                                    boicoins.toString(),
                                    key: ValueKey<int>(
                                        controller.boicoins.value),
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
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                                text: 'Selecione ',
                                style: TextStyle(fontSize: 24.sp)),
                            TextSpan(
                                text: 'CONFIRMAR ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp)),
                            TextSpan(
                                text: 'para gerar o QR Code de Troca',
                                style: TextStyle(fontSize: 24.sp)),
                          ])),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: BoiButton(
                          text: 'Confirmar Troca',
                          color: const Color(0xFF00A91B),
                          width: double.infinity,
                          height: 50.h,
                          callbackOnPressed: () async {
                            await controller.onConfirmarTrocaPressed(item, quantidadeItem, boicoins.toDouble());
                            Get.to(() => _buildQRCodePage(controller.qrcode!));
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodePage(String qrcode) {
    return SafeArea(
      child: Scaffold(
        appBar: const BoiAppBar(texto: '', icon: null),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'QR Code',
                  style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tire print da tela para não perder o QR Code!',
                  style: TextStyle(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Image.memory(base64Decode(qrcode))
                ),
                Expanded(
                    child: Text(
                      'O QR Code ficará disponivel por: 2 dias',
                      style: TextStyle(fontSize: 20.sp),
                        textAlign: TextAlign.center
                    )
                )
              ],
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
