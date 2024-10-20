import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_controller.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarteiraView extends GetView<CarteiraController> {
  static const Color bgColor = Color(0xFFBA400A);

  CarteiraView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    10.verticalSpace,
                    CoinCounter(coins: controller.boicoins.value),
                    10.verticalSpace,
                    _buildExtratoButton('Extrato', controller.onExtratoPressed),
                    10.verticalSpace,
                    Expanded(
                      child: Obx(() {
                        if (controller.showExtrato == true.obs) {
                          return ListView.builder(
                              itemCount: controller.extrato.length,
                              itemBuilder: (context, index) {
                                final item = controller.extrato[index];
                                return Column(
                                  children: [
                                    _buildExtratoItem(item),
                                    10.verticalSpace,
                                  ],
                                );
                              });
                        }
                        return 10.verticalSpace;
                      }),
                    ),
                  ],
                );
              }),
            )],
        ),
      ),
    );
  }

  // Retirado da página de doações
  // TODO: Colocar em um lugar só
  Widget _buildExtratoButton(String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 329.w,
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(20).r,
            bottomRight: const Radius.circular(20).r,
            topLeft: const Radius.circular(20).r,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold, // Deixar o texto em negrito
              color: Colors.black, // Cor do texto (preto)
            ),
          ),
        ),
      ),
    );
  }

  // Constrói o Widget para cada item do extrato
  Widget _buildExtratoItem(ItemExtrato item) {
    String textValue;
    TextStyle labelStyle;

    // Muda a cor se é positivo, ou negativo
    if (item.value > 0) {
      labelStyle = TextStyle(color: const Color(0xFF229C1F), fontSize: 20.sp);
      textValue = "+${item.value}";
    } else {
      labelStyle = TextStyle(color: const Color(0xFFB12623), fontSize: 20.sp);
      textValue = "${item.value}";
    }

    // TODO: Botar Expanded na altura do Coitainer
    return Container(
      width: 0.87.sw,
      height: 99.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20).r,
              bottomLeft: const Radius.circular(20).r,
              bottomRight: const Radius.circular(20).r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            CoinCounter.boicoinImagePath,
            width: 50.w,
            height: 50.h,
          ),
          15.horizontalSpace,
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textValue,
                    style: labelStyle,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: Color(0xFF908F8F),

                    ),
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  )
                ],
              )
          )
        ],
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
                          Icons.account_balance_wallet,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        Center(
                          child: Text(
                            'Carteira',
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

/* CoinCounter Widget*/
class CoinCounter extends StatelessWidget {
  static const String boicoinImagePath = "assets/images/icons/boicoin.png";

  final int coins;

  const CoinCounter({required this.coins, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        CoinCounter.boicoinImagePath,
        width: 178.w,
      ),
      Text(
        coins.toString(),
        style: TextStyle(fontSize: 40.sp, color: Colors.white),
      ),
    ]);
  }
}
