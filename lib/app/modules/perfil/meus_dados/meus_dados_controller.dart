import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/modules/meus_dados/meus_dados_model.dart';

class MeusDadosController extends BaseController {
  late MeusDados dadosExemplo;
  late MemoryStore _profileInfoStore;
  final credentialsRepo = UserCredentialsRepository();

  @override
  void onInit() {
    _profileInfoStore = MemoryStore(StorageKeys.PROFILE_INFO);
    super.onInit();
    getUserdata();
  }

  void getUserdata() {
    setLoading(true);

    final profileRepo = ProfileRepository().getProfileInfo(id: credentialsRepo.getCredentials().userId);
    dadosExemplo = MeusDados(username: credentialsRepo.getCredentials().name, email: credentialsRepo.getCredentials().email);

    setLoading(false);
    update();
  }
  
}
