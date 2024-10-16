import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:boi_marronzinho/app/modules/sobre_nos/sobrenos_module.dart';
import 'package:boi_marronzinho/app/modules/eventos/eventos_module.dart';
import 'package:get/get.dart';

class HomePageController extends BaseController {
  @override
  void onInit() {
    super.onInit();

    getBoiCoins();
  }

  void onEventosPressed() {
    Get.toNamed(EventosModule.path);
  }

  void onMapaPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onSobreNosPressed() {
    Get.toNamed(SobreNosModule.path);
  }

  void onDoeAgoraPressed() {
    Get.toNamed(DoacoesModule.path);
  }

  Future<double> getBoiCoins() async {
    return 0.1;
  }

  void onBoiMarronzinhoPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onLojaPressed() {
    Get.toNamed(LojaModule.path);
  }

  void onPerfilPressed() {
    Get.toNamed(PerfilModule.path);
  }
}
