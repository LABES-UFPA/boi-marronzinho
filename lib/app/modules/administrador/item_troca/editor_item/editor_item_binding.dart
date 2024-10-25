import 'package:boi_marronzinho/app/modules/administrador/item_troca/editor_item/editor_item_controller.dart';
import 'package:get/get.dart';

class EditorItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorItemController>(
      () => EditorItemController(),
    );
  }
}
