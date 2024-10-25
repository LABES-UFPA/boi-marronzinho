import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_controller.dart';
import 'package:get/get.dart';

class AddEventoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEventoController>(
      () => AddEventoController(),
    );
  }
}
