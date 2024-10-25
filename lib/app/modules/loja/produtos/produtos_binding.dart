import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_controller.dart';
import 'package:get/get.dart';

class ProdutosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdutosController>(() => ProdutosController());
  }
}
