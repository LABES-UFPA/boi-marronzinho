import 'package:boi_marronzinho/app/modules/doacoes/doacoes_controller.dart';
import 'package:get/get.dart';

class DoacoesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoacoesController>(
      () => DoacoesController(),
    );
  }
}
