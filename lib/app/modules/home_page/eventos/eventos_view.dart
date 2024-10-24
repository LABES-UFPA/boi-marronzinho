import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../componentes/AppBarClipper.dart';

class EventosView extends GetView<EventosController> {
  static const Color bgColor = Color(0xFFF69302);

  const EventosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator()
              );
            }
            return Column(
              children: [
                _buildAppBar(texto: 'Eventos'),
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
                evento.nome,
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
                    Get.to(() => _buildDetalhesEvento(evento));
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
                            TextSpan(text: "${evento.linkEndereco}\n"),
                            const TextSpan(
                                text: "Data: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " ${ DateFormat('dd/MM/yyyy - HH:mm').format(evento.dataEvento)}hrs\n"),
                            // const TextSpan(
                            //     text: "Descrição: ",
                            //     style: TextStyle(fontWeight: FontWeight.bold)),
                            // TextSpan(text: "${evento.descricao}\n"),
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

  // Coloca a página de descrição mais detalhada
  Widget _buildDetalhesEvento(Evento evento) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFBA400A),
          // Column, Padding, Column
          body: Column(
            children: [
              _buildAppBar(texto: evento.nome),
              // Imagem
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // TODO: substituir com imagem aqui
                    child: Image.asset('assets/images/eventos/evento-1.jpg'),
                  )
              ),

              // Descrição - Scrollable
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        evento.descricao,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildAppBar({required String texto}) {
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
                            texto,
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

