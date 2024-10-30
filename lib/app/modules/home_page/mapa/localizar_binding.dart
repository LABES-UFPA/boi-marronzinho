import 'package:boi_marronzinho/app/modules/home_page/mapa/localizar_controller.dart';
import 'package:get/get.dart';

class LocalizarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalizarController>(
      () => LocalizarController(),
    );
  }
}
