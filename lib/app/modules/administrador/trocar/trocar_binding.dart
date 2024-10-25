import 'package:boi_marronzinho/app/modules/administrador/trocar/trocar_controller.dart';
import 'package:get/get.dart';

class TrocarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrocarController>(
      () => TrocarController(),
    );
  }
}
