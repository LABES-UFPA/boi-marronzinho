import 'package:boi_marronzinho/app/modules/administrador/item_troca/item_controller.dart';
import 'package:get/get.dart';

class ItemsAdmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(
      () => ItemController(),
    );
  }
}
