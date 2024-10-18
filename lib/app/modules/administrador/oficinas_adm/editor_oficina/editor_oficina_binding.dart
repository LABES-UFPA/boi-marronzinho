import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_controller.dart';
import 'package:get/get.dart';

class EditorOficinaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorOficinaController>(
      () => EditorOficinaController(),
    );
  }
}
