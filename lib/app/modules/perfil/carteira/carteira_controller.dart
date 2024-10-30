import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_model.dart';
import 'package:get/get.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';

class CarteiraController extends BaseController {
  List<ItemExtrato> extrato = <ItemExtrato>[];
  RxBool showExtrato = false.obs;
  RxInt boicoins = 0.obs;
  final credentialsRepo = UserCredentialsRepository();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    setLoading(true);
    getDados();
    setLoading(false);
  }

  void getDados() async {
    final userId = credentialsRepo.getCredentials().userId;
    final response = await ProfileRepository().getExtrato(id: userId);

    if (response.valid) {
      if (response.data!.isEmpty) {
        extrato = [];
        return;
      }
      extrato = response.data!.map((t) {
        return ItemExtrato(value: t.quantidade.toInt(), description: t.descricao);
      }).toList();
    }

    boicoins.value = extrato.map((item) => item.value).reduce((val1, val2) => val1 + val2);

    update();
  }

  void onExtratoPressed() {
    showExtrato.toggle();
  }
}
