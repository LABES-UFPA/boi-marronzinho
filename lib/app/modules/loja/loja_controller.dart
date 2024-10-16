import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/troca/troca_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:get/get.dart';

class LojaController extends BaseController {

  @override
  void onInit() {
    super.onInit();

  }


  void onProdutosPressed() {
    //Get.toNamed(ProdutosModule.path);
  }

  void onOficinasPressed() {
    //Get.toNamed(OficinasModule.path);
  }

  void onTrocaPressed() {
    Get.toNamed(TrocaModule.path);
  }

  void onBoiMarronzinhoPressed(){
    Get.toNamed(HomeModule.path);
  }
  void onLojaPressed() {
    Get.toNamed(LojaModule.path);
  }

  void onPerfilPressed(){
    Get.toNamed(PerfilModule.path);
  }

}