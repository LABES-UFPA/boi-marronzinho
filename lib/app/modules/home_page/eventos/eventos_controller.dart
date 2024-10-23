import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/data/repositories/evento/evento_repository.dart';
import 'package:get/get.dart';

class EventosController extends BaseController {
  RxBool isDescriptionOpen = false.obs;
  late Evento selectedEvent;

  // TODO: Integrar com a API
  List<Evento> eventos = [];

  @override
  void onInit() {
    super.onInit();
    setLoading(true);
    // TODO: tirar isso na produção. colocar getOficinas()
    getEventosTeste();
    setLoading(false);
  }

  void toggleDescription() {
    isDescriptionOpen.toggle();
  }

  // Mesmo da Scarlet
  Future<void> getOficinas() async {
    final response = await EventosRepository().fetchEventos();
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar lista de oficinas');
    if (isValid && response.data != null) {
      eventos = response.data;
    }
  }

  void getEventosTeste() async {
    eventos = [
      Evento(id: 'aaaaa', nome: 'Evento do Boi', descricao: 'descricao', dataEvento: DateTime.now(), linkEndereco: 'linkEndereco')
    ];
  }

  // TODO: Precisa abrir o Google Maps aqui
  onVerLocationPressed() {
    print("Abre o Google Maps");
  }
}
