import 'package:boi_marronzinho/app/modules/eventos/eventos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EventosView extends GetView<EventosController> {
  const EventosView({super.key});

  static const Color bgColor = Color(0xFFF69302);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: AppBarClipper(),
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/images/icons/mingcute_arrow-up-fill.png',
                            height: 40,
                            width: 40,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.event,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 5),
                              Center(
                                child: Text(
                                  'Eventos',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EventoCard(
                      nome: '1° Berro do Marronzinho',
                      localizacao:
                          'Barracão Boi Marronzinho, Pass. Brasilia 170, Terra Firme',
                      data:
                          'Barracão Boi Marronzinho, Pass. Brasilia 170, Terra Firme',
                      descricao:
                          'Bora iniciar nosso período junino com muita comidas tipicas e música pra dançar com...'),
                  EventoCard(
                      nome: 'Cortejo Cultural Boi Marronzinho',
                      localizacao: 'Pelas ruas da Terra Firme',
                      data: 'Domingo 23 de junho às 14:00 horas',
                      descricao:
                          'É o dia do cortejo mais esperado por todos, o Boi Marronzinho e seu batalhão cheio de cor e alegria saem pelas ruas do bairro cantando suas toadas que falam...'),
                  EventoCard(
                      nome: 'Berrante Regional',
                      localizacao: 'UFPA perto do Rio',
                      data: 'Domingo 23 de junho às 14:00 horas',
                      descricao:
                          'Venha comer mingau de milho. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum convallis risus ut sodales viverra. Integer eu tempus nulla. Proin gravida leo maximus purus tristique dignissim. Sed blandit, dui sed venenatis lobortis, justo dui mattis orci, nec egestas sapien lacus egestas massa. Fusce ligula diam, scelerisque vitae leo vel, ultricies placerat eros. Aenean in ante convallis, commodo elit et, tempor ipsum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras semper sodales arcu, at elementum dui convallis et. '),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

/* Clipper */
class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 60, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/* Widget de Evento */
class EventoCard extends StatelessWidget {
  final String nome;
  final String localizacao;
  final String data;
  final String descricao;
  // Callback para a rota do evento

  const EventoCard(
      {super.key,
      required this.nome,
      required this.localizacao,
      required this.data,
      required this.descricao});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
        child: SizedBox(
      width: screenWidth * 0.8, // 80% da tela
      height: screenHeight * 0.3, // 30% da tela
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Text(
                nome,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'Localização: $localizacao\nData: $data\nDescrição: $descricao',
                    overflow: TextOverflow.fade,
                  )),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => print("Abra o Google Maps"),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 1))),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text("Ver Localização")
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
