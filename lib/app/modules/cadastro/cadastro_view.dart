import 'package:boi_marronzinho/app/modules/cadastro/cadastro_controller.dart';
import 'package:boi_marronzinho/app/modules/componentes/ButtonBox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroView extends GetView<CadastroController> {
  CadastroView({Key? key}) : super(key: key);
  // final controller = Get.put(CadastroController());

  // TODO: Adicionar tela de Ok quando cadastrar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF69302),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 34.h),
                child: Text(
                  'Cadastre-se',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBA400A),
                  ),
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFBA400A),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80.r),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.registerFormKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 25.w),
                            child: Column(
                              children: [
                                SizedBox(height: 16.h),
                                InputBox(
                                  text: 'Nome',
                                  hint: 'João',
                                  type: TextInputType.text,
                                  controller: controller.nomeController,
                                  validation: controller.validateName,
                                ),
                                SizedBox(height: 22.h),
                                InputBox(
                                  text: 'Sobrenome',
                                  hint: 'Silva',
                                  type: TextInputType.text,
                                  controller: controller.sobrenomeController,
                                  validation: controller.validateName,
                                ),
                                SizedBox(height: 22.h),
                                InputBox(
                                  text: 'Email',
                                  hint: 'email@exemplo.com',
                                  type: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  validation: controller.validateEmail,
                                ),
                                SizedBox(height: 22.h),
                                InputBox(
                                  text: 'Senha',
                                  hint: '**********',
                                  type: TextInputType.visiblePassword,
                                  isPassword: true,
                                  controller: controller.passwordController,
                                  validation: controller.validatePassword,
                                ),
                                SizedBox(height: 22.h),
                                InputBox(
                                  text: 'Confirmar Senha',
                                  hint: '**********',
                                  type: TextInputType.visiblePassword,
                                  isPassword: true,
                                  controller: controller.confirmpasswordController,
                                  validation: controller.validatePassword,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                ButtonBox(
                                  text: 'Cadastrar',
                                  function: controller.onCadastro,
                                  colortext: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30).h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Já possui conta?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.onLoginPressed();
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 6.w)
                                        ),
                                        child: Text(
                                          'Faça Login',
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
                                ),
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
              controller: controller,
              obscureText: isPassword,
              keyboardType: type,
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

