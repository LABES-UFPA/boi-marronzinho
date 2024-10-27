import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/util/url.dart';
import 'package:boi_marronzinho/app/modules/componentes/BoiAppBar.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OficinasView extends GetView<OficinasController> {
  const OficinasView({super.key});

  static const bgColor = Color(0xFFBA400A);
  static const _boldStyle = TextStyle(fontWeight: FontWeight.bold);
  static final _pagamentoBoldStyle = TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BoiAppBar(texto: 'Oficinas', icon: Icons.co_present),
        backgroundColor: bgColor,
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.oficinas.isEmpty) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Não há oficinas cadastradas no momento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              // Oficinas
              Expanded(
                child: ListView.builder(
                  itemCount: controller.oficinas.length,
                  itemBuilder: (context, index) {
                    return _buildEventoCard(controller.oficinas[index], context);
                  }
                ),
              ),
            ],
          );
        })
      ),
    );
  }

  Widget _buildEventoCard(Oficina oficina, BuildContext context) {
    return Center(
        child: SizedBox(
            width: 0.85.sw, // 80% da tela
            height: 0.3.sh, // 30% da tela
            child: InkWell(
              // DEIXA ASSIM
              onTap: () => Get.to(() {
                return _buildDescriptionPage(oficina);
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

                                    // TODO: Máscara na Data
                                    const TextSpan(text: "Data: ", style: _boldStyle),
                                    TextSpan(text: "${ DateFormat('dd/MM/yyyy - HH:mm').format(oficina.dataOficina)}hrs\n"),

                                    const TextSpan(text: "Descrição: ", style: _boldStyle),
                                    TextSpan(text: "${oficina.descricao}\n"),
                                  ]))),
                    ),

                    // Botão para Ver Localização
                    Expanded(
                      child: InkWell(
                        // TODO: Abrir Mapa e retirar o print
                          onTap: () {
                            OpenUrl.openGoogleMaps(oficina.linkEndereco);
                          },
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
  Widget _buildDescriptionPage(Oficina oficina) {
    return SafeArea(
      child: Scaffold(
        appBar: BoiAppBar(texto: oficina.nomeOficina, icon: null),
          backgroundColor: const Color(0xFFBA400A),
          // Column, Padding, Column
          body: Column(
            children: [


              // Scrollable Container
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Imagem
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            controller.apiHelpers.buildUrl(
                              url: oficina.imagem,
                              endpoint: Endpoints.MINIO,
                            ),
                          ),
                        ),
                      ),

                      // Descrição
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          oficina.descricao,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                child: MostraInfo(
                                    info: 'R\$ ${oficina.precoReal
                                        .toStringAsFixed(2)}',
                                    fontSize: 20.sp
                                )
                            ),
                            Expanded(
                                child: MostraSaldoBoicoins(oficina.precoBoicoin.toInt())
                            ),
                          ]
                      ),
                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: MostraInfo(
                                  info: '${DateFormat('dd/MM/yyyy - HH:mm')
                                      .format(oficina.dataOficina)}hrs',
                                  fontSize: 15.sp
                              )
                          ),
                          Expanded(
                              child: MostraInfo(
                                  info: '${oficina.limiteParticipantes - oficina
                                      .participantesAtual} vagas restantes',
                                  fontSize: 15.sp
                              )
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
                                  onPressed: () => Get.to(_buildInscreverSePage(oficina)),
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
                                  child: const Text(
                                    'Inscrever-se',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildInscreverSePage(Oficina oficina) {
    // Carrega saldo
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const BoiAppBar(texto: '', icon: null),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            const Divider(),
            5.verticalSpace,

            // Seu slado boicoins
            Expanded(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Text(
                        'Seu saldo BoiCoins: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        child: MostraSaldoBoicoins(controller.saldo.toInt()),
                      ),
                  ],
                ),
                ),

            5.verticalSpace,
            const Divider(),
            5.verticalSpace,

            // Descrição da Compra
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Descrição da Compra', style: _pagamentoBoldStyle),
                  Text('1x (${oficina.nomeOficina})')
                ],
              )
            ),

            5.verticalSpace,
            const Divider(),
            5.verticalSpace,

            // Total a ser pago
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Total a ser pago',
                      style: _pagamentoBoldStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'R\$ ${oficina.precoReal.toStringAsFixed(2)}',
                      style: _pagamentoBoldStyle
                    ),
                  ),
                  Text('ou', style: TextStyle(
                    fontSize: 20.sp
                  )),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 60.h,
                      child: MostraSaldoBoicoins(oficina.precoBoicoin.toInt()),
                    ),
                  )
                ],
              ),
            ),

            5.verticalSpace,
            const Divider(),
            5.verticalSpace,

            // Método de Pagamento
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Método de Pagamento',
                      style: _pagamentoBoldStyle,
                    ),

                    10.verticalSpace,

                    Expanded(
                      child: Column(
                        children: [
                          PagamentoButton(text: 'Pix', callback: () { controller.pagarComPix(); }),

                          10.verticalSpace,

                          PagamentoButton(text: 'Boicoins', callback: () { controller.pagarComBoicoins(oficina); }),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class PagamentoButton extends StatelessWidget {
  final String text;
  final Function callback;

  const PagamentoButton({required this.text, required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62.h,
      child: ElevatedButton(
          onPressed: () => callback(),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF69302),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              )
          ),
          child: Text(text, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp
          ),)
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

// Mostra valor com Boicoin do lado
class MostraSaldoBoicoins extends StatelessWidget {
  final int saldo;

  const MostraSaldoBoicoins(this.saldo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
            scale: 1,
            child: Image.asset('assets/images/icons/boicoin.png')
        ),
        10.horizontalSpace,
        Text(
            saldo.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}

// Mostra qualquer informação, para usar dentro do Footer
class MostraInfo extends StatelessWidget {
  final String info;
  final double fontSize;  // com .sp na frente!!!

  const MostraInfo({required this.info, required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      info,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontSize
      ),
    );
  }
}

