import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/carteira/carteira_module.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/modules/administrador/admin_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_module.dart';
import 'package:get/get.dart';

class PerfilController extends BaseController {
  //final MemoryStore _userTokenStore;
  //PerfilController(this._userTokenStore);
  bool isAdmin = false;

  @override
  void onInit() {
    super.onInit();
  }

  void onProdutosPressed() {
    //Get.toNamed(ProdutosModule.path);

  void onMeusDadosPressed() {
    Get.toNamed(MeusDadosModule.path);
  }

  void onCarteiraPressed() {
    throw UnimplementedError();
  }

  void onCarteiraPressed() {
    Get.toNamed(CarteiraModule.path);
  }

  void onVouchersPressed() {
    Get.toNamed(VouchersModule.path);
  }
  void onAdminPressed() {
    Get.toNamed(AdminModule.path);
  }

  void onBoiMarronzinhoPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onLojaPressed() {
    Get.toNamed(LojaModule.path);
  }

  void onPerfilPressed() {
    Get.toNamed(PerfilModule.path);
  }

  void setUserRole(){
    
  }


  //Admin
  Future<void> checkUSerType() async {
    //Map<String,dynamic> decodedToken = Jwt.parseJwt(token);
  }

}
