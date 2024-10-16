import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_controller.dart';

import 'package:get/get.dart';

class MeusDadosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeusDadosController>(() => MeusDadosController());
  }
}
