import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrocaController extends BaseController{
  final TextEditingController quantidadeController = TextEditingController();
  RxInt boicoins = 0.obs;
  List<ItemTroca> itensTroca = <ItemTroca>[];

  @override
  void onInit() {
    super.onInit();
    getItensTroca();
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

  int calcularBoicoinsUnidade(int unidades, double boicoinsPorUnidade) {
    return (unidades * boicoinsPorUnidade).toInt();
  }

  int calcularBoicoinsMl(double ml, double boicoinsPorUnidade) {
    return ((ml * boicoinsPorUnidade)).toInt(); // Coloca em Litro
  }

  void onCalcularPressed(ItemTroca item) {
    if (quantidadeController.text.isEmpty) {
      boicoins.value = 0;
      update();
      return;
    }
    switch (item.unidadeMedida.toUpperCase()) {
      case 'UNIDADE':
        boicoins.value = calcularBoicoinsUnidade(int.parse(quantidadeController.text), item.boicoinsPorUnidade).toInt();
        break;
      case 'LITRO':
        boicoins.value = calcularBoicoinsMl(double.parse(quantidadeController.text), item.boicoinsPorUnidade).toInt();
        break;
      default:
        throw Exception('O item não tem uma unidade definida!');
    }
    update();
  }

}