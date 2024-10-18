import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobre_nos_controller.dart';
import 'package:get/get.dart';

class SobreNosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SobreNosController>(() => SobreNosController());
  }
  
}