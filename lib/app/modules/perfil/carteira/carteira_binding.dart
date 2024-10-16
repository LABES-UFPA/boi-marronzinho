import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_controller.dart';
import 'package:get/get.dart';

class CarteiraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarteiraController>(() => CarteiraController());
  }
}
