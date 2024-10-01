import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxString email = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  String? validateEmail(String? value) {
    
    if (!GetUtils.isEmail(value!)) {
      return 'Formato inválido de email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (GetUtils.isNullOrBlank(value ?? '') == null) {
      return 'Senha não válida';
    }

    if (value!.length <= 6) {
      return 'Senha não pode ser menor que 6 dígitos';
    }

    return null;
  }

  Future<void> onLogin() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      print('validate');
      setLoading(true);

      //final loginRepo = await LoginRepository().login(
      // email: emailController.text,
      // password: passController.text,
      //);

      //print(loginRepo);

      Get.offAllNamed(HomeModule.path);
      setLoading(false);
    }
  }
}
