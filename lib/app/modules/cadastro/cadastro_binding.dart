import 'package:boi_marronzinho/app/modules/cadastro/cadastro_controller.dart';
import 'package:get/get.dart';

class CadastroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroController>(
      () => CadastroController(),
    );
  }
}
