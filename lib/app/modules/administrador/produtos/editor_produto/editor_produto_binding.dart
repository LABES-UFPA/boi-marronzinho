import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_controller.dart';
import 'package:get/get.dart';

class EditorProdutoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorProdutoController>(
      () => EditorProdutoController(),
    );
  }
}
