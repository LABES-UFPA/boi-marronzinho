import 'package:boi_marronzinho/app/modules/home_page/doacoes/pix/pix_controller.dart';
import 'package:get/get.dart';

class PixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixController>(
      () => PixController(),
    );
  }
}
