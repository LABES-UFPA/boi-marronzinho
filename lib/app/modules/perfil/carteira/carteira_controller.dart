import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CarteiraController extends BaseController {
  List<ItemExtrato> extrato = <ItemExtrato>[];
  RxBool showExtrato = false.obs;
  RxInt boicoins = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setLoading(true);
    getExtrato();
    setLoading(false);
  }

  void getExtrato() {
    extrato = <ItemExtrato> [
      ItemExtrato(value: -100, description: "Compra de Sabão"),
      ItemExtrato(value: -100, description: "Compra de Sabão"),
      ItemExtrato(value: 100, description: "Troca de Óleo Usado"),
      ItemExtrato(value: 100, description: "Troca de Óleo Usado"),
    ];
  }

  void getBoicoins() {

  }

  void onExtratoPressed() {
    showExtrato.toggle();
  }
}
