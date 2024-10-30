import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:boi_marronzinho/app/modules/meus_dados/meus_dados_model.dart';
import 'package:get/get.dart';

class MeusDadosController extends BaseController {
  late MeusDados meusDados;
  final credentialsRepo = UserCredentialsRepository();

  @override
  void onInit() {
    super.onInit();
    getUserdata();
  }

  void getUserdata() {
    setLoading(true);

    meusDados = MeusDados(username: credentialsRepo.getCredentials().name, email: credentialsRepo.getCredentials().email);

    setLoading(false);
    update();
  }

  void onLogoutPressed() {
    cleanCacheEndStore();
    Get.offAllNamed(LoginModule.path);
    return Toast.success(
        'Deslogado com sucesso!',
        'Volte sempre! MUUUUUUUUU 🐂🐂🐂',
        delayed: true
    );
  }

}
