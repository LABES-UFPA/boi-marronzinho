import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';

class TrocaController extends BaseController{

  List<ItemTroca> itensTroca = <ItemTroca>[];

  @override
  void onInit() {
    super.onInit();
    getItensTroca();
  }

  // Mesmo da Scarlet
  Future<void> getItensTroca() async {
    setLoading(true);

    final response = await TrocaReposity().getItensTroca();
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      itensTroca = response.data;
    }
    setLoading(false);
    update();
  }

}