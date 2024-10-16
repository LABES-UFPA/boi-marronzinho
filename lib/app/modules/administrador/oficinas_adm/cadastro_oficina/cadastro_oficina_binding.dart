import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_controller.dart';
import 'package:get/get.dart';

class AddOficinaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOficinaController>(
      () => AddOficinaController(),
    );
  }
}
