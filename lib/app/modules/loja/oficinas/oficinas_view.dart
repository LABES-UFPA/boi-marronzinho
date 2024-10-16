import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OficinasView extends GetView<OficinasController> {
  const OficinasView({super.key});

  static const bgColor = Color(0xFFBA400A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: AppBarClipper(),
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10).h,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/icons/mingcute_arrow-up-fill.png',
                              height: 40.h,
                              width: 40.w,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.w),
                                Icon(
                                  Icons.co_present,
                                  color: Colors.black,
                                  size: 30.sp,
                                ),
                                SizedBox(width: 5.w),
                                Center(
                                  child: Text(
                                    'Oficinas',
                                    style: TextStyle(
                                      fontSize: 36.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Oficinas
            EventoCard(
                nome: "Oficina de Violão",
                localizacao:
                    "Curral Cultural Seu Cici Pass. Brasilia 170, Terra Firme",
                data: "Sabado 16 de março de 15 às 17 horas",
                descricao:
                    "Você que sempre quis aprender a tocar um instrumento se liga nessa oportunidade. O IAC instituto Amazônia..."),
            EventoCard(
                nome: "Aulas de Dança",
                localizacao:
                    "Curral Cultural Seu Cici Pass. Brasilia 170, Terra Firme",
                data: "Segunda 25 de março de 15 às 17 horas",
                descricao:
                    "Venha dançar com o Boi! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec augue purus, faucibus at sapien ut, molestie posuere libero. Proin imperdiet suscipit commodo. Cras porttitor, neque ac molestie ultricies, ligula est mollis libero, nec finibus metus nisi vitae elit. Vestibulum mattis efficitur laoreet. In aliquam, neque "),
          ],
        ),
      ),
    );
  }
}

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
// O mesmo usado na tela de eventos na branch feature/eventos. Esse aqui tá mais
// atualizado
// TODO: Colocar todos os Widgets numa pasta só
class EventoCard extends StatelessWidget {
  final String nome;
  final String localizacao;
  final String data;
  final String descricao;
  // TODO: Callback para a rota do evento

  static const _boldStyle = TextStyle(fontWeight: FontWeight.bold);

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
            // Título -- Nome da Oficina
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

            // Detalhes -- Localização, Data e Descrição
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                        const TextSpan(text: "Localização:", style: _boldStyle),
                        TextSpan(text: "$localizacao\n"),
                        const TextSpan(text: "Data:", style: _boldStyle),
                        TextSpan(text: "$data\n"),
                        const TextSpan(text: "Descrição:", style: _boldStyle),
                        TextSpan(text: "$descricao\n"),
                      ]))),
            ),

            // Botão para Ver Localização
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
