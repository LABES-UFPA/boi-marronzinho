import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarteiraView extends GetView<CarteiraController> {
  CarteiraView({super.key});
  static const Color bgColor = Color(0xFFBA400A);

  final List<ItemExtrato> testeExtrato = [
    ItemExtrato(value: 100, description: "Troca de Óleo"),
    ItemExtrato(value: -300, description: "Camisa Boi Marronzinho"),
    ItemExtrato(value: 100, description: "Troca de Óleo Usado"),
    ItemExtrato(value: 100, description: "Troca de Óleo Usado"),
    ItemExtrato(value: 100, description: "Troca de Óleo Usado"),
  ];

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
            ),

            // Conteúdo
            Padding(
              padding: const EdgeInsets.all(16.0).h,
              child: Column(
                children: [
                  CoinCounter(),
                  20.verticalSpace,
                  buildPaymentButton("Extrato", () {
                    throw UnimplementedError();
                  }),
                ],
              ),
            ),
            buildExtratoItem(
                ItemExtrato(value: 100, description: "Troca de Óleo Usado")),
            10.verticalSpace,
            buildExtratoItem(
                ItemExtrato(value: -300, description: "Blusa Boi Marronzinho")),
          ],
        ),
      ),
    );
  }

  // Retirado da página de doações
  // TODO: Colocar em um lugar só
  Widget buildPaymentButton(String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
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
  Widget buildExtratoItem(ItemExtrato item) {
    String textValue;
    TextStyle labelStyle;
    if (item.value > 0) {
      labelStyle = TextStyle(color: const Color(0xFF229C1F), fontSize: 20.sp);
      textValue = "+${item.value}";
    } else {
      labelStyle = TextStyle(color: const Color(0xFFB12623), fontSize: 20.sp);
      textValue = "${item.value}";
    }

    return Container(
      width: 0.87.sw,
      height: 88.h,
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
          Column(
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
              )
            ],
          )
        ],
      ),
    );
  }
}

// Para usar com o Builder
class ItemExtrato {
  int value;
  String description;
  ItemExtrato({required this.value, required this.description});
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

class CoinCounter extends StatefulWidget {
  const CoinCounter({super.key});
  static const String boicoinImagePath = "assets/images/icons/boicoin.png";

  @override
  State<CoinCounter> createState() => CoinCounterState();
}

class CoinCounterState extends State<CoinCounter> {
  int _qtdBoiCoins = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        CoinCounter.boicoinImagePath,
        width: 178.w,
      ),
      Text(
        _qtdBoiCoins.toString(),
        style: TextStyle(fontSize: 40.sp, color: Colors.white),
      ),
    ]);
  }

  void updateBoiCoins() {
    throw UnimplementedError();
  }
}

class Carteira extends StatefulWidget {
  const Carteira({super.key});

  @override
  State<Carteira> createState() => _CarteiraState();
}

class _CarteiraState extends State<Carteira> {
  bool _isExtratoPressed = false;

  @override
  Widget build(BuildContext context) {
    if (_isExtratoPressed) {
      return Text("Trueeee");
    }
    return Text("FAAALSE");

    return const Placeholder();
  }
}
