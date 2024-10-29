import 'package:auto_size_text/auto_size_text.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/componentes/BoiAppBar.dart';
import 'package:boi_marronzinho/app/modules/componentes/PageRevisaoDeCompra.dart';
import 'package:boi_marronzinho/app/modules/componentes/boiButton.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class ProdutosView extends GetView<ProdutosController> {
  const ProdutosView({super.key});

  static const bgColor = Color(0xFFF69302);
  static final _pagamentoBoldStyle =
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: BoiAppBar(
            icon: Icons.storefront_sharp,
            customCallbackOnExit: () {},
            texto: 'Produtos',
          ),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              controller.onFloatingCarrinhoPressed();
              Get.to(_buildCarrinho());
            },
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.shopping_cart_rounded, size: 50,)
          ),
          backgroundColor: bgColor,
          body: Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
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
                              onTap: () => Get.to(_buildDescricaoProduto(
                                  controller.produtos[index], context)));
                        }),
                  ),
                ),
              ],
            );
          })),
    );
  }

  // PopScope pra que resete a quantidade da página
  Widget _buildDescricaoProduto(Produto produto, BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        controller.resetDescricaoPage();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const BoiAppBar(texto: '', icon: null),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // _buildAppBar(
                  //     texto: '',
                  //     showIcon: false,
                  //     customCallbackOnExit: () {
                  //       controller.quantidade.value = 1;
                  //     }),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.network(produto.imagemURL),
                              ),

                              // Nome do Produto
                              Text(
                                produto.nome,
                                style: TextStyle(fontSize: 30.sp),
                              ),

                              // Valores e Quantidade
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Valores
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              Image.asset(
                                                  'assets/images/icons/boicoin.png'),
                                              Text(
                                                  produto.precoBoicoins
                                                      .toInt()
                                                      .toString(),
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
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                        const TextSpan(
                                            text: 'Descrição: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        TextSpan(
                                          text: produto.descricao,
                                        ),
                                      ]))
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
                          // TODO: devia estar no controller
                          callback: () async {
                            final result = await controller.onAdicionarAoCarrinhoPressed(produto, controller.quantidade.value);
                            if (result) {
                              Get.off(() => _buildCarrinho());
                              return;
                            }
                            Toast.error('Erro ao adicionar produto ao carrinho', 'Tente novamente mais tarde');
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
                            Get.to(() => PageRevisaoDeCompra(
                                callbackOnPixPressed: () => print('pix'),
                                callbackOnBoicoinsPressed: () =>
                                    print('Boicoins'),
                                produtos: [
                                  ItemCarrinho(
                                      produto: produto,
                                      quantidade: controller.quantidade.value)
                                ],
                                saldo: controller.saldo.value));
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
      ),
    );
  }

  Widget _buildQuantidadeSelector() {
    return Obx(() {
      return Row(
        children: [
          QuantidadeButton(
              icon: Icons.remove, callback: () => controller.onMinusPressed()),
          10.horizontalSpace,
          Text(
            controller.quantidade.value.toString(),
            style: TextStyle(fontSize: 23.sp),
          ),
          10.horizontalSpace,
          QuantidadeButton(
              icon: Icons.add, callback: () => controller.onPlusPressed()),
        ],
      );
    });
  }

  Widget _buildCarrinho() {
    return SafeArea(
      child: Scaffold(
        appBar: const BoiAppBar(texto: 'Carrinho', icon: Icons.storefront_sharp),
        backgroundColor: Colors.white,
        body: Obx(
          () {
            return Column(
              children: [
                const Divider(),
                Expanded(
                  // Adicionado para ajustar o ListView.builder
                  child: ListView.builder(
                    itemCount: controller.carrinho.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _buildItemCarrinho(
                            produto: controller.carrinho[index].produto,
                            quantidade: controller.carrinho[index].quantidade,
                            indexOnCarrinho: index,
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Valores
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: AutoSizeText(
                              'Total R\$${controller.carrinhoTotalReais.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Ou',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 40.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/images/icons/boicoin.png'),
                                  AutoSizeText(
                                    controller.carrinhoTotalBoicoins.value
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      // Botão de Método de Pagamento
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BoiButton(
                            text: 'Método de Pagamento',
                            color: const Color(0xFFF69302),
                            width: double.infinity,
                            height: 50.h,
                            callbackOnPressed: () {
                              if (controller.carrinho.isEmpty) {
                                return Toast.error('O carrinho está vazio!',
                                    'Tente inserir algo no seu carrinho');
                              }
                              Get.to(() => PageRevisaoDeCompra(
                                    produtos: controller.carrinho,
                                    saldo: controller.saldo.value,
                                    callbackOnBoicoinsPressed: () => controller.onBoicoinsPressed(),
                                    callbackOnPixPressed: () => print('Pix'),
                                  ));
                            }),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemCarrinho(
      {required Produto produto,
      required int quantidade,
      required int indexOnCarrinho}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Foto
          Expanded(
            flex: 2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(produto.imagemURL)),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text('${quantidade}x ${produto.nome}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'R\$ ${produto.precoReal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                            child: Row(
                              children: [
                                Image.asset('assets/images/icons/boicoin.png'),
                                Text(produto.precoBoicoins.toInt().toString(),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                  ],
                )
              ],
            ),
          ),
          // Botão de remover
          Expanded(
            child: IconButton(
              onPressed: () {
                controller.removeProdutoFromCarrinho(indexOnCarrinho);
              },
              icon: const Icon(Icons.highlight_remove),
            ),
          )
        ],
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
                        child: Text(
                            'R\$ ${produto.precoReal.toStringAsFixed(2)}',
                            style: _precoRealStyle,
                            textAlign: TextAlign.center)),
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

  const PagamentoButton(
      {required this.text,
      required this.callback,
      required this.color,
      super.key});

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
              ))),
          child: AutoSizeText(
            text,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
            textAlign: TextAlign.center,
          )),
    );
  }
}

class QuantidadeButton extends StatelessWidget {
  final IconData icon;
  final Function callback;

  const QuantidadeButton(
      {super.key, required this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
