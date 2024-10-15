import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/pix/pix_module.dart';
import 'package:get/get.dart';

class DoacoesController extends BaseController {
  
  @override
  void onInit() {
    super.onInit();
  }

  void onPixPressed() {
    Get.toNamed(PixModule.path);
  }

  void onCartaoPressed() {
    //Get.toNamed(CartaoModule.path);
  }

  void onBoletoPressed() {
    //Get.toNamed(BoletoModule.path);
  }

  void onOutroPressed() {
    //Get.toNamed(PixModule.path);
  }
}
