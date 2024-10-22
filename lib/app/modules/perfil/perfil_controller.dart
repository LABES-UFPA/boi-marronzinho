import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/admin_module.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:get/get.dart';

class PerfilController extends BaseController {
  late final MemoryStore _userTokenStore;
  var userCheck = false.obs;
  //final MemoryStore _userTokenStore;
  //PerfilController(this._userTokenStore);
  

  @override
  void onInit() {
    super.onInit();
    _userTokenStore = MemoryStore(StorageKeys.USER_TOKEN);
  }

  void onProdutosPressed() {
    //Get.toNamed(ProdutosModule.path);
  }

  void onMeusDadosPressed() {
    Get.toNamed(MeusDadosModule.path);
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

  Future<void> checkUserType() async {
    try {
      // Token de teste
      // TODO: Tirar token de teste
      const String teste = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA4NGI2NGUxLTI1MGMtNDRkZi1hODA5LTRjYWEzMmIwZTBmZCIsInVzZXJuYW1lIjoidmxhZCIsInJvbGUiOiJBZG1pbmlzdHJhZG9yIiwiaXNzIjoiYm9pLW1hcnJvbnppbmhvLWFwaSIsImF1ZCI6WyJhcGktY2xpZW50Il0sImV4cCI6MTcyOTEyMjM0NH0.JwQcCkEG8d6Q84npmdy6WFvxbMO_QLOgGi1pCbUgUCU';

      final token = await _userTokenStore.read();
      //final token = teste;

      // TODO: Acho que era melhor ver se é nulo. Tá dando erro aqui

      if (token == null) {
        print("Token é Nulo!");
        throw UnimplementedError();
      }

      if (token.isEmpty) {
        print('Token não encontrado');
        return;
      }
      final jwt = JWT.decode(token);

      print('Dados do Token: ${jwt.payload}');

      final role = jwt.payload['role'];
      
      if (role == 'Administrador') {
        userCheck.value = true;
      } else {
        userCheck.value = false;
      }
    } on JWTException catch (e) {
      print('Erro ao decodificar o token: $e');
    }
  }
}
