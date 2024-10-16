import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_controller.dart';
import 'package:get/get.dart';

class OficinasAdmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OficinasAdmController>(
      () => OficinasAdmController(),
    );
  }
}
