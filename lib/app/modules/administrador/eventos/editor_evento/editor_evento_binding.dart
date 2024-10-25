import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_controller.dart';
import 'package:get/get.dart';

class EditorEventoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorEventoController>(
      () => EditorEventoController(),
    );
  }
}
