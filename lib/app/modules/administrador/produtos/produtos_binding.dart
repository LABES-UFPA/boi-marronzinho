import 'package:boi_marronzinho/app/modules/administrador/produtos/produtos_controller.dart';
import 'package:get/get.dart';

class ProdutosAdmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdutosAdmController>(
      () => ProdutosAdmController(),
    );
  }
}
