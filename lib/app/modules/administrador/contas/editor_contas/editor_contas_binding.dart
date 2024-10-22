import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_controller.dart';
import 'package:get/get.dart';

class EditorContaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorContaController>(
      () => EditorContaController(),
    );
  }
}
