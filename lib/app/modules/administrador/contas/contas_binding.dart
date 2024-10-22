import 'package:boi_marronzinho/app/modules/administrador/contas/contas_controller.dart';
import 'package:get/get.dart';

class ContasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContasController>(
      () => ContasController(),
    );
  }
}
