import 'package:boi_marronzinho/app/modules/doacoes/doacoes_controller.dart';
import 'package:boi_marronzinho/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF69302),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/logo/ImgBoi.png",
                  width: 200.0,
                  height: 275.0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFBA400A),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80),
                  ),
                ),
                height: 470,
                child: Form(
                  key: controller.loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF69302),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InputBox(
                          text: 'Email',
                          hint: 'email@exemplo.com',
                          type: TextInputType.emailAddress,
                          validation: controller.validateEmail,
                        ),
                        SizedBox(height: 30),
                        InputBox(
                          text: 'Senha',
                          hint: '**********',
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          validation: controller.validatePassword,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ButtonBox(
                          text: 'Entrar',
                          validation: controller.onLogin,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 60, bottom: 20),
                color: Color(0xFFBA400A),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ainda não possui conta?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.onCadastroPressed();
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
  final String? Function(String?) validation;

  InputBox({
    Key? key,
    required this.text,
    required this.hint,
    this.isPassword = false,
    required this.type,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 12, left: 14, right: 14, bottom: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF69302),
                  height: 0.8),
            ),
            TextFormField(
              obscureText: isPassword,
              keyboardType: type,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                errorStyle:
                    TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
              ),
              validator: (value) => validation(value),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonBox extends StatelessWidget {
  final String text;
  final Future<void> Function() validation;

  ButtonBox({required this.text, required this.validation});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await validation();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF69302),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(14)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Deixar o texto em negrito
            color: Colors.white, // Cor do texto (preto)
          ),
        ),
      ),
    );
  }
}
