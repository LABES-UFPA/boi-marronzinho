import 'package:boi_marronzinho/app/modules/loja/troca/troca_controller.dart';
import 'package:get/get.dart';

class TrocaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrocaController>(
      () => TrocaController(),
    );
  }
}
