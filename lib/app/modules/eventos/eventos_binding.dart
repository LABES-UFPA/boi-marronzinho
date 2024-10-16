import 'package:boi_marronzinho/app/modules/eventos/eventos_controller.dart';
import 'package:get/get.dart';

class EventosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventosController>(
      () => EventosController(),
    );
  }
}
