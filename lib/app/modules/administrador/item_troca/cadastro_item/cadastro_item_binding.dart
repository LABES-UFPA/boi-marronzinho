import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_controller.dart';
import 'package:get/get.dart';

class AddItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddItemController>(
      () => AddItemController(),
    );
  }
}
