import 'package:boi_marronzinho/app/modules/componentes/BoiAppBar.dart';
import 'package:boi_marronzinho/app/modules/componentes/MostraSaldoBoicoins.dart';
import 'package:boi_marronzinho/app/modules/componentes/boiButton.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageRevisaoDeCompra extends StatelessWidget {
  static final _pagamentoBoldStyle =
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);

  final List<ItemCarrinho> produtos;
  final int saldo;
  final Function callbackOnPixPressed;
  final Function callbackOnBoicoinsPressed;

  double _precoRealTotal = 0.0;
  int _precoBoicoinsTotal = 0;

  PageRevisaoDeCompra(
      {super.key,
      required this.callbackOnPixPressed,
      required this.callbackOnBoicoinsPressed,
      required this.produtos,
      required this.saldo}) {
    getDescricaoCompra();
    calcularValorTotal();
  }

  String getDescricaoCompra() {
    String s = '';
    for (var item in produtos) {
      s += '${item.quantidade}x (${item.produto.nome}); ';
    }
    return s;
  }

  void calcularValorTotal() {
    for (var item in produtos) {
      _precoRealTotal += item.produto.precoReal * item.quantidade;
      _precoBoicoinsTotal +=
          (item.produto.precoBoicoins * item.quantidade).toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BoiAppBar(texto: '', icon: null),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            const Divider(),
            5.verticalSpace,

            // Seu saldo BoiCoins
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: MostraSaldoBoicoins(saldo),
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
                  Text(getDescricaoCompra())
                ],
              ),
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
                      'R\$ ${_precoRealTotal.toStringAsFixed(2)}',
                      style: _pagamentoBoldStyle,
                    ),
                  ),
                  Text('ou', style: TextStyle(fontSize: 20.sp)),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 60.h,
                      child: MostraSaldoBoicoins(_precoBoicoinsTotal),
                    ),
                  ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            BoiButton(
                              text: 'Pix',
                              callbackOnPressed: () {
                                callbackOnPixPressed();
                              },
                              color: const Color(0xFFF69302),
                              width: double.infinity,
                              height: 60.h,
                            ),
                            10.verticalSpace,
                            BoiButton(
                              text: 'Boicoins',
                              callbackOnPressed: () {
                                callbackOnBoicoinsPressed();
                              },
                              color: const Color(0xFFF69302),
                              width: double.infinity,
                              height: 60.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
