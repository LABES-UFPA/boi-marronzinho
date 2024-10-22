import 'package:boi_marronzinho/app/modules/administrador/pontos_mapa/pontos_controller.dart';
import 'package:get/get.dart';

class PontosAdmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PontosAdmController>(
      () => PontosAdmController(),
    );
  }
}
