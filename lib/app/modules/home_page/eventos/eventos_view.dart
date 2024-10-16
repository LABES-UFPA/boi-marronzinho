import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                            height: 40.h,
                            width: 40.w,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              10.horizontalSpace,
                              const Icon(
                                Icons.event,
                                color: Colors.black,
                                size: 30,
                              ),
                              5.horizontalSpace,
                              Center(
                                child: Text(
                                  'Eventos',
                                  style: TextStyle(
                                    fontSize: 36.sp,
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
          // Body -- Onde estão os cards de eventos
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
    return Center(
        child: SizedBox(
      width: 0.85.sw, // 80% da tela
      height: 0.3.sh, // 30% da tela
      child: Card(
        margin: EdgeInsets.all(10.0.w),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Text(
                nome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0.sp,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Text(
                    'Localização: $localizacao\nData: $data\nDescrição: $descricao',
                    overflow: TextOverflow.fade,
                  )),
            ),
            Expanded(
              child: InkWell(
                  // TODO: Abrir Mapa e retirar o print
                  onTap: () => print("Abra o Google Maps"),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1.w))),
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
