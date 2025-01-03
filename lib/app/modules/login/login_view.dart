import 'package:boi_marronzinho/app/modules/componentes/ButtonBox.dart';
import 'package:boi_marronzinho/app/modules/login/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  // final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFF69302),
        body: Column(
          children: [
            Image.asset(
              "assets/images/logo/ImgBoi.png",
              width: 200.0.w,
              height: 275.0.h,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBA400A),
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(80).r,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.loginFormKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 25.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFF69302),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                InputBox(
                                  key: UniqueKey(),
                                  text: 'Email',
                                  hint: 'email@exemplo.com',
                                  type: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  validation: controller.validateEmail,
                                ),
                                SizedBox(height: 30.h),
                                InputBox(
                                  key: UniqueKey(),
                                  text: 'Senha',
                                  hint: '**********',
                                  type: TextInputType.visiblePassword,
                                  isPassword: true,
                                  controller: controller.passwordController,
                                  validation: controller.validatePassword,
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                ButtonBox(
                                  text: 'Entrar',
                                  function: controller.onLogin,
                                  colortext: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30).h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ainda não possui conta?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.onCadastroPressed();
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 6.w)
                                        ),
                                        child: Text(
                                          'Cadastre-se',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  final String text;
  final String hint;
  final bool isPassword;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?) validation;

  InputBox({
    Key? key,
    required this.text,
    required this.hint,
    this.isPassword = false,
    required this.type,
    required this.controller,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 8.h, left: 14.w, right: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF69302),
                  height: 0.8.h),
            ),
            TextFormField(
              obscureText: isPassword,
              keyboardType: type,
              controller: controller, // Certifique-se de que o controlador está sendo utilizado
              onChanged: (value) {
                controller.text = value;
              },
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                errorStyle:
                TextStyle(fontSize: 14.sp, overflow: TextOverflow.ellipsis),
              ),
              validator: (value) => validation(value),
            ),
          ],
        ),
      ),
    );
  }
}

