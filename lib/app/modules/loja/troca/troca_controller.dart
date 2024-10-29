import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrocaController extends BaseController{
  final TextEditingController quantidadeController = TextEditingController();
  RxInt boicoins = 0.obs;
  ItemTroca? itemSelecionado;
  List<ItemTroca> itensTroca = <ItemTroca>[];

  @override
  void onInit() {
    super.onInit();
    quantidadeController.addListener(() {
      onCalcularPressed(itemSelecionado!);
    });
    getItensTroca();
  }

  @override
  void dispose() {
    super.dispose();
    quantidadeController.dispose();
    boicoins.value = 0;
  }

  // Pega da API
  Future<void> getItensTroca() async {
    setLoading(true);

    final response = await TrocaReposity().getItensTroca();
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      itensTroca = response.data;
    }
    setLoading(false);
    update();
  }

  int calcularBoicoins(double unidades, double boicoinsPorUnidade) {
    return (unidades * boicoinsPorUnidade).toInt();
  }

  void onCalcularPressed(ItemTroca item) {
    if (quantidadeController.text.isEmpty) {
      boicoins.value = 0;
      update();
      return;
    }
    boicoins.value = calcularBoicoins(double.parse(quantidadeController.text), item.boicoinsPorUnidade).toInt();
    update();
  }

}