import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    nextScreen(); 
  }

  
  void nextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    // Verifica se o usuário está autenticado
    bool isLoggedIn = autetication();

    if (isLoggedIn) {
      Get.offNamed(HomeModule.path);  
    } else {
      Get.offNamed(LoginModule.path);  
    }
  }

  // Simulação de verificação de autenticação
  bool autetication() {
    bool isLoggedIn = false;
    return isLoggedIn;
  }
}
