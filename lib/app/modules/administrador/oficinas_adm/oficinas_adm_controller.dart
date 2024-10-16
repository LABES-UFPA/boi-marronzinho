import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:get/get.dart';

class OficinasAdmController extends BaseController {
  final oficinasRepo = OficinasRepository();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<Oficina> oficinas = <Oficina>[];

  @override
  void onInit() {
    super.onInit();
    getOficinas();
  }

  Future<void> getOficinas() async {
    setLoading(true);

    final response = await oficinasRepo.fetchOficinas();
    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      oficinas = response.data;
    }

    setLoading(false);
    update();
  }

  void onAddOficinasPressed() {
    Get.toNamed(AddOficinaModule.path);
  }
}
