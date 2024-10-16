import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_controller.dart';
import 'package:get/get.dart';

class OficinasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OficinasController>(() => OficinasController());
  }
}
