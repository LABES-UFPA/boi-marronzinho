import 'package:auto_size_text/auto_size_text.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class ProdutosView extends GetView<ProdutosController> {
  const ProdutosView({super.key});

  static const bgColor = Color(0xFFF69302);
  static final _pagamentoBoldStyle = TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);

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
                _buildAppBar(texto: 'Produtos'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: controller.produtos.length,
                        itemBuilder: (context, index) {
                          return ProdutoCard(
                              produto: controller.produtos[index],
                            onTap: () => Get.to(_buildDescricaoProduto(controller.produtos[index], context))
                          );
                        }),
                  ),
                ),
              ],
            );
          })),
    );
  }

  Widget _buildAppBar({required String texto, bool showIcon = true}) {
    if (showIcon) {
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
                    const Icon(
                      Icons.storefront_sharp,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5.w),
                          Expanded(
                            child: AutoSizeText(
                              texto,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                        SizedBox(width: 5.w),
                        Expanded(
                          child: AutoSizeText(
                            texto,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

  Widget _buildDescricaoProduto(Produto produto, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildAppBar(texto: '', showIcon: false),

                // Imagem, Valores e Descrição
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        // Imagem
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(produto.imagemURL),
                            ),

                            // Nome do Produto
                            Text(
                              produto.nome,
                              style: TextStyle(
                                  fontSize: 30.sp
                              ),
                            ),

                            // Valores e Quantidade
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Valores
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'R\$ ${produto.precoReal.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: Row(
                                          children: [
                                            Image.asset('assets/images/icons/boicoin.png'),
                                            Text(produto.precoBoicoins.toInt().toString(),
                                                style: TextStyle(
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                10.horizontalSpace,

                                // Quantidade
                                _buildQuantidadeSelector(),
                              ],
                            ),

                            // Descrição
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                      children: [
                                      const TextSpan(
                                        text: 'Descrição: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )
                                      ),
                                      TextSpan(
                                          text: produto.descricao,
                                      ),
                                    ]
                                  )
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Adicionar ao Carrinho ou Comprar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: PagamentoButton(
                        text: 'Adicionar ao Carrinho',
                        callback: () {
                          controller.onCarrinhoPressed();
                        },
                        color: const Color(0xFFF69302),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      flex: 1,
                      child: PagamentoButton(
                        text: 'Comprar',
                        callback: () {
                          Get.to(() => _buildPaginaCompra(produto));
                        },
                        color: const Color(0xFF00A91B),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuantidadeSelector() {
    return Obx(() {
      return Row(
        children: [
          QuantidadeButton(icon: Icons.remove, callback: () => controller.onMinusPressed()),
          10.horizontalSpace,
          Text(
              controller.quantidade.value.toString(),
            style: TextStyle(
              fontSize: 23.sp
            ),
          ),
          10.horizontalSpace,
          QuantidadeButton(icon: Icons.add, callback: () => controller.onPlusPressed()),
        ],
      );
    });
  }

  Widget _buildPaginaCompra(Produto produto) {
    // Carrega saldo
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
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
                    Text('1x (${produto.nome})')
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
                        'R\$ ${produto.precoReal.toStringAsFixed(2)}',
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
                      child: MostraSaldoBoicoins(produto.precoBoicoins.toInt()),
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
                            PagamentoButton(text: 'Pix', callback: () { controller.pagarComPix(produto); }, color: const Color(0xFFF69302),),

                            10.verticalSpace,

                            PagamentoButton(text: 'Boicoins', callback: () { controller.pagarComBoicoins(produto); }, color: const Color(0xFFF69302),),
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

class ProdutoCard extends StatelessWidget {
  final Produto produto;
  final Function onTap;

  const ProdutoCard({super.key, required this.produto, required this.onTap});

  static final _precoRealStyle =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);
  static final _precoBoicoins =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 0.5.sw,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Imagem
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // TODO: Pegar pelo Bucket
                child: Image.asset(produto.imagemURL),
              ),

              // Nome
              Text(
                produto.nome,
                style: TextStyle(fontSize: 14.sp),
              ),

              // Row
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text('R\$ ${produto.precoReal.toStringAsFixed(2)}',
                            style: _precoRealStyle, textAlign: TextAlign.center)),
                    Expanded(
                        child: SizedBox(
                      height: 22.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/icons/boicoin.png'),
                            Text(produto.precoBoicoins.toInt().toString(),
                                style: _precoBoicoins,
                                textAlign: TextAlign.center)
                          ]),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PagamentoButton extends StatelessWidget {
  final String text;
  final Function callback;
  final Color color;

  const PagamentoButton({required this.text, required this.callback, required this.color ,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62.h,
      child: ElevatedButton(
          onPressed: () => callback(),
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              )
          ),
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp
          ),
            textAlign: TextAlign.center,
          )
      ),
    );
  }
}


class QuantidadeButton extends StatelessWidget {
  final IconData icon;
  final Function callback;

  const QuantidadeButton({super.key, required this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
            Radius.circular(10)
        ),
        child: Container(
          width: 34.w,
          height: 34.h,
          color: const Color(0xFF908F8F),
          child: Icon(icon),
        ),
      ),
    );
  }
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
