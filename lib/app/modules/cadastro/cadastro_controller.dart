import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/register/register_repository.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  RxString email = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (!GetUtils.isEmail(value!)) {
      return 'Formato inválido de email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (GetUtils.isNullOrBlank(value) == true) {
      return 'Senha não válida';
    }

    if (value!.length < 6) {
      return 'Senha não pode ser menor que 6 dígitos';
    }

    return null;
  }

  Future<void> onCadastro() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        final register = await RegisterRepository().register(
          firstName: nomeController.text,
          lastName: sobrenomeController.text,
          password: passwordController.text,
          email: emailController.text,
        );

        if (!register.valid) {
          setLoading(false);
          return Toast.error(
              'Não foi possível realizar o login',
              register.reason!,
              delayed: true
          );
        }

        Get.offAllNamed(HomeModule.path);
      } finally {
        setLoading(false);
      }
    }
  }

  void onCadastroPressed() {
    Get.toNamed(LoginModule.path);
  }
}