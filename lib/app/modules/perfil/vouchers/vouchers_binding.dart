import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_controller.dart';
import 'package:get/get.dart';

class VouchersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VouchersController>(
      () => VouchersController(),
    );
  }
}
