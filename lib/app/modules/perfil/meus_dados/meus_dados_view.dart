import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_controller.dart';
import 'package:boi_marronzinho/app/modules/meus_dados/meus_dados_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeusDadosView extends GetView<MeusDadosController> {
  const MeusDadosView({super.key});

  static const Color bgColor = Color(0xFFF69302);
  static const String userImagePath = "assets/images/icons/user_alt.png";
  static const String emailImagePath = "assets/images/icons/email.png";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            body: Column(children: [
              _buildAppBar(),
              50.verticalSpace,
              Expanded(child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return _buildMeusDados(dados: controller.dadosExemplo);
              }))
            ])));
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
                          Icons.account_box_rounded,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        Center(
                          child: Text(
                            'Meus Dados',
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

  Widget _buildMeusDados({required MeusDados dados}) {
    return Column(children: [
      50.verticalSpace,
      UserIcon(dados.username),
      15.verticalSpace,
      UserInfoCard(
        label: "Nome de Usuário",
        iconImagePath: userImagePath,
        text: dados.username,
      ),
      20.verticalSpace,
      UserInfoCard(
          label: "Email", iconImagePath: emailImagePath, text: dados.email),
      20.verticalSpace,
      _buildButton("Logout", Colors.deepOrangeAccent, () {
        controller.onLogoutPressed();
      }),
      20.verticalSpace,
      _buildButton("Deletar Conta", Colors.redAccent, () {
        print("Deletei a conta");
      }),
    ]);
  }

  // Para logout e deletar conta
  Widget _buildButton(String buttonText, Color buttonColor, Function callback,) {
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
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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

// Widget para ícone e nome do usuário
// Recebe parâmetro "name"
class UserIcon extends StatelessWidget {
  final String _name;
  static const String _userImagePath = "assets/images/icons/user_alt.png";

  const UserIcon(this._name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 4.2.w)),
            child: CircleAvatar(
              radius: 0.2.sw,
              backgroundColor: Colors.white,
              child: Image.asset(
                _userImagePath,
                fit: BoxFit.contain,
                width: 100.w,
              ),
            )),
        Text(
          _name,
          style: TextStyle(fontSize: 25.29.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Contém informações genéricas de Nome de Usuário e Email
// Recebe label, text e o endereço da imagem do ícone
class UserInfoCard extends StatelessWidget {
  final String label;
  final String text;
  final String iconImagePath;

  const UserInfoCard(
      {required this.label,
      required this.iconImagePath,
      required this.text,
      super.key});

  static final Radius _cardRadius = const Radius.circular(20).r;
  static final TextStyle _labelStyle = TextStyle(
      color: const Color(0xFFF69302),
      fontSize: 20.sp,
      fontWeight: FontWeight.bold);
  static final TextStyle _textStyle =
      TextStyle(color: Colors.black, fontSize: 16.sp);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.87.sw,
      height: 100.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: _cardRadius,
              bottomLeft: _cardRadius,
              bottomRight: _cardRadius)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            iconImagePath,
            width: 50.w,
            height: 50.h,
          ),
          15.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: _labelStyle,
                overflow: TextOverflow.fade,
              ),
              Text(
                text,
                style: _textStyle,
                overflow: TextOverflow.fade,
              )
            ],
          )
        ],
      ),
    );
  }
}
