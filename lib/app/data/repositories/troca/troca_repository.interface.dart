import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/models/troca/troca.dart';

abstract interface class ITroca {
  Future<dynamic> getItensTroca();
  Future<dynamic> addItensTroca({
    required String nome, 
    required String descricao, 
    required String unidadeMedida, 
    required double boicoinsPorUnidade});
  Future<dynamic> atualizarItemTroca({
    required String itemId,
    String? nome,
    String? descricao,
    String? unidadeMedida,
    double? boicoinsPorUnidade,
  });
  Future<dynamic> deletarItemTroca({
    required String id
  });
  Future<dynamic> realizarTroca({
    required Troca troca
  });
}
