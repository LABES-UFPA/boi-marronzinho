import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_controller.dart';
import 'package:get/get.dart';

class AddProdutoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProdutoController>(
      () => AddProdutoController(),
    );
  }
}
