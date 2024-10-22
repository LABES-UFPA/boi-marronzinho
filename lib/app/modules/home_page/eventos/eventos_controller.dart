import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_model.dart';
import 'package:get/get.dart';

class EventosController extends BaseController {
  RxBool isDescriptionOpen = false.obs;
  late Evento selectedEvent;

  // TODO: Integrar com a API
  List<Evento> eventos = [
    Evento(
        name: '1° Berro do Marronzinho',
        description:
            'Barracão Boi Marronzinho, Pass. Brasilia 170, Terra Firme',
        data: 'Barracão Boi Marronzinho, Pass. Brasilia 170, Terra Firme',
        longDescription: "1° Berro do Boi Marronzinho  2024 Bora iniciar nosso período junino com muita comidas tipicas e  música pra dançar  com o Grupo de carimbó Parananin. Será dia 26 de Maio de 2024 No curral  do Boi Marronzinho Na pass. Brasília n°170 A partir das 14hs Venda de mesas ( 80 reias ) e ingressos (20 reias) Para adquirir  e só entra em contatos conosco por aqui no nosso Instagram  ou com um dos nossos componentes do batalhão.",
        location: 'Bora iniciar nosso período junino com muita comidas tipicas e música pra dançar com...',
        imagePath: 'assets/images/eventos/evento-1.jpg'
    ),
    Evento(
      name: '2° Berro do Marronzinho',
      description: 'Barracão do Berro, Terra Firme',
      data: 'Barracão Boi Marronzinho, Pass. Brasilia 170, Terra Firme',
      location:
          'Bora iniciar nosso período junino com muita comidas tipicas e música pra dançar com...',
      longDescription:
          'de produtos artesanais feitos pelos próprios membros da '
          'comunidade. Essa atividade não apenas gera renda para os '
          'artesãos locais, mas também valoriza as habilidades e '
          'técnicas tradicionais de produção, ajudando a manter viva '
          'a herança cultural da região.\n\n'
          'e celebrações culturais no bairro da Terra Firme e em toda Belém.',
      imagePath: 'assets/images/eventos/evento-2.jpg',
    )
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void toggleDescription() {
    isDescriptionOpen.toggle();
  }

  // TODO: Precisa abrir o Google Maps aqui
  onVerLocationPressed() {
    print("Abre o Google Maps");
  }
}
