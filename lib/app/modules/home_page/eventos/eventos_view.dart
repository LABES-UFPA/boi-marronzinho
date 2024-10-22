import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventosView extends GetView<EventosController> {
  static const Color bgColor = Color(0xFFF69302);

  const EventosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Obx(() {
            if (controller.isDescriptionOpen.isTrue) {
              return _buildDetalhesEvento(controller.selectedEvent, context);
            }
            return Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.eventos.length,
                    itemBuilder: (context, index) {
                      final evento = controller.eventos[index];
                      return Column(
                        children: [_buildEventoCard(evento, context)],
                  );
                },
              ),
            )
          ],
        );
      }),
    ));
  }

  Widget _buildDetalhesEvento(Evento evento, BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.all(0.05.sw),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.toggleDescription();
                },
                child: Image.asset('assets/images/icons/mingcute_arrow-up-fill.png', scale: 1.3,),
              ),
              10.verticalSpace,
            ],
          ),
          Image.asset(evento.imagePath),
          10.verticalSpace,
          Text(
            evento.longDescription,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    height: 1.sp,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildEventoCard(Evento evento, BuildContext context) {
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
            // Título -- Nome do Evento
            Expanded(
              flex: 0,
              child: Text(
                evento.name,
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
                child: InkWell(
                  onTap: () {
                    controller.selectedEvent = evento;
                    controller.toggleDescription();
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: RichText(
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                            const TextSpan(
                                text: "Localização: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "${evento.location}\n"),
                            const TextSpan(
                                text: "Data: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "${evento.data}\n"),
                            const TextSpan(
                                text: "Descrição: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "${evento.description}\n"),
                          ]))),
                )),

            // Botão para Ver Localização
            Expanded(
              child: InkWell(
                  // TODO: Abrir Mapa e retirar o print
                  onTap: () => controller.onVerLocationPressed(),
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

  Widget _buildAppBar() {
    return Stack(
      children: [
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            height: 100.h,
            decoration: const BoxDecoration(
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
                          Icons.event,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        Center(
                          child: Text(
                            'Eventos',
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
    );
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
