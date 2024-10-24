import 'package:boi_marronzinho/app/modules/administrador/eventos/eventos_controller.dart';
import 'package:get/get.dart';

class EventosAdmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventosAdmController>(
      () => EventosAdmController(),
    );
  }
}
