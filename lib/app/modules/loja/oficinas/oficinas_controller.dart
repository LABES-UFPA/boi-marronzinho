import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';

class OficinasController extends BaseController {
  
  List<Oficina> oficinas = <Oficina>[];

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

}
