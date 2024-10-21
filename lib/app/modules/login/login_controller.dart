import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/login/login_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/cadastro/cadastro_module.dart';
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

    if (value!.length < 6) {
      return 'Senha não pode ser menor que 6 dígitos';
    }

    return null;
  }

  Future<void> onLogin() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        final loginRepo = await LoginRepository().login(
          email: "vlad@example.com",
          password: "senhaSegura123",
        );

        if (!loginRepo.valid) {
          setLoading(false);
          return Toast.error(
              'Não foi possível realizar o login',
              loginRepo.reason!,
              delayed: true
          );
        }
        Get.offAllNamed(HomeModule.path);
      }
      finally {
        setLoading(false);
      }
    }

  }

  void onCadastroPressed() {
    Get.toNamed(CadastroModule.path);
  }
}
