import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';

class OficinasController extends BaseController {
  
  List<Oficina> oficinas = <Oficina>[];
  int saldo = 0;

  @override
  void onInit() {
    super.onInit();
    getOficinas();
  }

  // Mesmo da Scarlet
  Future<void> getOficinas() async {
    setLoading(true);

    final response = await OficinasRepository().fetchOficinas();
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar lista de oficinas');
    if (isValid && response.data != null) {
      oficinas = response.data;
    }
    setLoading(false);
    update();
  }

  Future<void> getSaldo() async {
    setLoading(true);

    final response = await ProfileRepository().getProfileInfo(id: UserCredentialsRepository().getCredentials().userId);
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar saldo de boicoins');
    if (isValid && response.data != null) {
      saldo = response.data!.saldoBoicoins.toInt();
    }
    setLoading(false);
    update();
  }

  // TODO: Pagar com Pix aqui
  void pagarComPix() {
    throw UnimplementedError();
  }

  void pagarComBoicoins() {
    throw UnimplementedError();
  }

}
