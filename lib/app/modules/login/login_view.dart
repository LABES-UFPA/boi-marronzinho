import 'package:boi_marronzinho/app/modules/doacoes/doacoes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<DoacoesController> {
  LoginView({Key? key}) : super(key: key);

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
                height: 591,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF69302),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InputBox('Email', 'email@exemplo.com', false),
                      SizedBox(height: 30),
                      InputBox('Senha', '**********', true),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonBox('Entrar'),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100, left: 22, right: 22),
                        child: Row(
                          children: [
                            Text(
                              'Ainda não possui conta?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                print('cadastre-se');
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 5)),
                              child: Text(
                                'Cadastre-se',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      )
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

  Widget ButtonBox(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFFF69302),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Center(
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

  Widget InputBox(String text, String hintText, bool isPassword) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, left: 14, right: 14),
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
                fontSize: 18,
                fontWeight: FontWeight.bold, // Deixar o texto em negrito
                color: Color(0xFFF69302), // Cor do texto (preto)
              ),
            ),
            TextFormField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ],
        ),
      ),
    );
  }
}
