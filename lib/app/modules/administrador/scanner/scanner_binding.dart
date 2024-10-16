import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_controller.dart';
import 'package:get/get.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(
      () => ScannerController(),
    );
  }
}
