import 'package:boi_marronzinho/app/modules/componentes/AppBarClipper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PerfilView extends GetView<PerfilController> {
  PerfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkUserType();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF5C0B32),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170.h,
                  color: Color(0xFFF69302),
                ),
                ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    height: 170.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleButton(
                              icon: 'assets/images/icons/ImgBoi.png',
                              text: 'Boi Marronzinho',
                              onPressed: () {
                                controller.onBoiMarronzinhoPressed();
                              },
                            ),
                            CircleButton(
                              icon: 'assets/images/icons/shopping-bag.png',
                              text: 'Loja',
                              onPressed: () {
                                controller.onLojaPressed();
                              },
                            ),
                            CircleButton(
                              icon: 'assets/images/icons/user.png',
                              text: 'Perfil',
                              onPressed: () {
                                controller.onPerfilPressed();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Itens da lista
            Expanded(
              child: ListView(
                //padding: EdgeInsets.zero,
                children: [
                  buildMenuItem('Meus Dados', Icons.account_box,
                      Color(0xFFF69302), Color(0xFFBA400A), () {
                    controller.onMeusDadosPressed();
                  }),
                  buildMenuItem('Carteira', Icons.account_balance_wallet,
                      Color(0xFFBA400A), Color(0xFFB12623), () {
                    controller.onCarteiraPressed();
                  }),
                  Obx(() {
                    Color voucher = controller.userCheck.value ?
                   Color(0XFF660D0D) : Color(0xFF5C0B32);
                    return buildMenuItem('Vouchers', Icons.confirmation_num,
                        Color(0xFFB12623), voucher, () {
                      controller.onVouchersPressed();
                    });
                  }),
                  //teste
                  Obx(() {
                    return controller.userCheck.value == true
                        ? buildMenuItem(
                            'Administrador',
                            Icons.manage_accounts_outlined,
                            Color(0XFF660D0D),
                            Color(0xFF5C0B32), () {
                            controller.onAdminPressed();
                          })
                        : SizedBox.shrink();
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String text, IconData? icon, Color color,
      Color nextcolor, VoidCallback onPressed) {
    return Container(
      height: 128.h,
      color: nextcolor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60).r,
        ),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(40).h,
            decoration: BoxDecoration(
              color: color,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 16.w),
                Icon(icon, color: Colors.white, size: 40.sp),
                SizedBox(width: 20.w),
                AutoSizeText(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;

  CircleButton(
      {required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent, width: 2.w),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0).h,
              child: Image.asset(
                icon,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

