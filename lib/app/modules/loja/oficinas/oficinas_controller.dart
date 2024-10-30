import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_model.dart';
import 'package:get/get.dart';

class OficinasController extends BaseController {
  late ApiHelpers apiHelpers = ApiHelpers();
  List<Oficina> oficinas = <Oficina>[];
  int saldo = 0;

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    await getOficinas();
    await getSaldo();
    setLoading(false);
    update();
  }

  // Mesmo da Scarlet
  Future<void> getOficinas() async {
    final response = await OficinasRepository().fetchOficinas();
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar lista de oficinas');
    if (isValid && response.data != null) {
      oficinas = response.data;
    }
  }

  Future<void> getSaldo() async {
    // TODO: Ver se tem em cache
    var extrato = [];
    final userId = UserCredentialsRepository().getCredentials().userId;
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

    saldo = extrato.map((item) => item.value).reduce((val1, val2) => val1 + val2);
  }

  // TODO: Pagar com Pix aqui
  void pagarComPix() {
    throw UnimplementedError();
  }

  Future<void> pagarComBoicoins(Oficina oficina) async {
    if (oficina.precoBoicoin.toInt() > saldo) {
      Get.until((route) => route.settings.name == OficinasModule.path);
      return Toast.error(
          'Erro na Inscrição',
          'Você não tem boicoins suficientes',
          delayed: true
      );
    }

    final response = await OficinasRepository().inscricaoOficina(
        usuarioId: UserCredentialsRepository().getCredentials().userId,
        oficinaId: oficina.id
    );

    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      Get.until((route) => route.settings.name == OficinasModule.path);
      return Toast.success(
          'Inscrição confirmada!',
          'Você se inscreveu na oficina ${oficina.nomeOficina}! Te esperamos lá!'
      );
    }

    Get.until((route) => route.settings.name == OficinasModule.path);
    return Toast.alert('Você já está inscrito!', 'Você já se inscreveu nesta oficina!');
  }

}
