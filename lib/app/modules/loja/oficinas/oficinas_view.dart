import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OficinasView extends GetView<OficinasController> {
  const OficinasView({super.key});

  static const bgColor = Color(0xFFBA400A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _buildAppBar(),
              // Oficinas
              Expanded(
                child: ListView.builder(
                  itemCount: controller.oficinas.length,
                  itemBuilder: (context, index) {
                    return _buildOficina(controller.oficinas[index]);
                  }
                ),
              ),
            ],
          );
        })
      ),
    );
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
    );
  }


  Widget _buildOficina(Oficina oficina) {
    return EventoCard(oficina: oficina);
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
  final Oficina oficina;

  // TODO: Callback para a rota do evento
  static const _boldStyle = TextStyle(fontWeight: FontWeight.bold);

  const EventoCard({super.key, required this.oficina});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 0.85.sw, // 80% da tela
      height: 0.3.sh, // 30% da tela
      child: InkWell(
        onTap: () => Get.to(() {
          return _buildDescriptionPage(
            oficina.nomeOficina,
            oficina.descricao,
            oficina.precoReal,
            oficina.precoBoicoin.toInt(),
            'assets/images/eventos/evento-1.jpg'
          );
        }),
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
                  oficina.nomeOficina,
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
                              // TODO: receber localizaçao da API
                              const TextSpan(text: "Localização: ", style: _boldStyle),
                              TextSpan(text: "PLACEHOLDER\n"),

                              const TextSpan(text: "Data: ", style: _boldStyle),
                              TextSpan(text: "${oficina.dataOficina.toString()}\n"),
                              
                              const TextSpan(text: "Descrição: ", style: _boldStyle),
                              TextSpan(text: "${oficina.descricao}\n"),
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
      )
    ));
  }

  // Coloca a página de descrição mais detalhada
  Widget _buildDescriptionPage(
      String nomeOficina,
      String longDescription,
      double precoReais,
      int precoBoicoins,
      String imagePath
      ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFBA400A),
        appBar: AppBar(title: Text(nomeOficina)),
        // Column, Padding, Column
        body: Column(
          children: [

            // Imagem
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath),
              )
            ),

            // Descrição - Scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    longDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
            ),

            // Footer
            Container(
              width: 1.sw,
              height: 0.2.sh,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20),
                  topEnd: Radius.circular(20),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Valor em reais e bois
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'R\$ ${precoReais.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                              ),
                            )
                          ),
                          Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                      scale: 1,
                                      child: Image.asset('assets/images/icons/boicoin.png')
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    precoBoicoins.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.sp)
                                  )
                                ],
                              )
                          )
                        ]
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${DateFormat('dd/MM/yyyy - HH:mm').format(oficina.dataOficina)}hrs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp
                            ),
                          ),
                        ),
                        // TODO: Colocar vagas restantes
                        Expanded(
                          child: Text(
                              '${oficina.limiteParticipantes} vagas restantes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.sp
                              ),
                          ),
                        )
                      ],
                    ),
                  ),

                  5.verticalSpace,

                  // Botão de Inscrever-se
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => print('Se inscreveu'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                                )
                              ),
                              child: const Text('Inscrever-se', style: TextStyle(
                                color: Colors.white
                              ),)
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),

            // Preço
            // Inscrever-se
          ],
        )
      ),
    );


  }

}
