import 'package:boi_marronzinho/app/modules/perfil/perfil_controller.dart';
import 'package:get/get.dart';

class PerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(
      () => PerfilController(),
    );
  }
}