import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/data/repositories/evento/evento_repository.dart';
import 'package:boi_marronzinho/app/data/util/url.dart';
import 'package:get/get.dart';

class EventosController extends BaseController {
  RxBool isDescriptionOpen = false.obs;
  final eventosRepo = EventosRepository();
  late Evento selectedEvent;
  List<Evento> eventos = <Evento>[];

  @override
  void onInit() {
    super.onInit();
    getEventos();
  }

  void toggleDescription() {
    isDescriptionOpen.toggle();
  }

  Future<void> getEventos() async {
    setLoading(true);

    final response = await eventosRepo.fetchEventos();
    final isValid = isValidResponse(
        response: response, title: 'Sucesso ao carregar a lista');
    if (isValid && response.data != null) {
      eventos = response.data;
    }

    setLoading(false);
    update();
  }

  onVerLocationPressed(Evento evento) {
    OpenUrl.openGoogleMaps(evento.linkEndereco);
  }
}
