import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/contas_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/eventos_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/item_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_module.dart';
import 'package:get/get.dart';

class AdminController extends BaseController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onEventosPressed() {
    Get.toNamed(EventosAdminModule.path);
  }
  void onProdutosPressed() {
    //Get.toNamed(ProdutosModule.path);
  }
  void onOficinasPressed() {
    Get.toNamed(OficinasAdminModule.path);
  }
  void onItensPressed() {
    Get.toNamed(ItemsAdminModule.path);
  }
  void onTrocarProdutoPressed() {
    //Get.toNamed(ProdutosModule.path);
  }
  void onContasPressed() {
    Get.toNamed(ContasModule.path);
  }
  void onScannerPressed() {
    Get.toNamed(ScannerModule.path);
  }
  void onPontosPressed() {
    Get.toNamed(ScannerModule.path);
  }
  // void onOficinasPressed() {
  //   Get.toNamed(OficinasAdminModule.path);
  // }
  
  
}