import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/meus_dados/meus_dados_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.dart';
import 'package:boi_marronzinho/app/modules/meus_dados/meus_dados_model.dart';

class MeusDadosController extends BaseController {
  final voucherRepo = VoucherRepository();
  late MeusDados dadosExemplo;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserdata();
  }

  void getUserdata() {
    setLoading(true);
    dadosExemplo = MeusDados(username: 'José Carlos', email: 'josecarlos@exemplo.com');
    setLoading(false);
    update();
  }
  
}
