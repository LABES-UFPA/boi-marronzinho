import 'package:boi_marronzinho/app/modules/loja/loja_controller.dart';
import 'package:get/get.dart';

class LojaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LojaController>(
      () => LojaController(),
    );
  }
}