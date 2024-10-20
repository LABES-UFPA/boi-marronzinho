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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setLoading(true);
    getExtrato();
    setLoading(false);
  }

  void getExtrato() async {
    setLoading(true);

    final response = await ProfileRepository().getExtrato(id: credentialsRepo.getCredentials().userId);

    if (response.valid) {
      extrato = response.data!.map((t) {
        return ItemExtrato(value: t.quantidade.toInt(), description: t.descricao);
      }).toList();
    }

    boicoins.value = extrato.map((item) => item.value).reduce((val1, val2) => val1 + val2);

    setLoading(false);
    update();
  }

  void getBoicoins() {
  }


  void onExtratoPressed() {
    showExtrato.toggle();
  }
}
