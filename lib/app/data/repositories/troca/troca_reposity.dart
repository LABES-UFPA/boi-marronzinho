import 'dart:convert';

import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/models/troca/troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import '../../enumerators/endpoints.enum.dart';


final class TrocaReposity extends RequestRepository implements ITroca {
  static const String listarItensTrocaUrl = '/trocas/itens-troca';
  static const String realizarTrocaUrl = '/trocas';
  // static const String listarItensTrocaUrl = '/trocas';
  // static const String listarItensTrocaUrl = '/trocas';
  // static const String listarItensTrocaUrl = '/trocas';


  @override
  Future addItensTroca({required String nome, required String descricao, required String unidadeMedida, required double boicoinsPorUnidade}) {
    // TODO: implement addItensTroca
    throw UnimplementedError();
  }

  @override
  Future atualizarItemTroca({required ItemTroca itemTroca}) {
    // TODO: implement atualizarItemTroca
    throw UnimplementedError();
  }

  @override
  Future deletarItemTroca({required String id}) {
    // TODO: implement deletarItemTroca
    throw UnimplementedError();
  }

  @override
  Future getItensTroca() async {
    final url = apiHelpers.buildUrl(url: listarItensTrocaUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<ItemTroca>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);

      final itensTroca = List.from(response.data)
          .map((item) => ItemTroca.fromMap(item))
          .toList();

      return (valid: true, reason: 'Sucesso ao pegar as trocas', data: itensTroca);
    } catch (e, stackTrace) {
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

  @override
  Future realizarTroca({required String itemTrocaId, required String usuarioId, required double quantidade, required double boicoins}) async {
    final url = apiHelpers.buildUrl(url: realizarTrocaUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    final bodyRequest = {
      'itemTrocaId': itemTrocaId,
      'usuarioId': usuarioId,
      'quantidade':quantidade,
      'boicoinsRecebidos': boicoins,
    };

    try {
      final response = await client.post(url, bodyRequest);

      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      final qrcode_base64 = response.data["qrcode_base64"];
      
      // await _cache.cacheRequest(response.data);


      return (valid: true, reason: 'Sucesso ao realizar a troca', data: qrcode_base64);
    } catch (e, stackTrace) {
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }


}
