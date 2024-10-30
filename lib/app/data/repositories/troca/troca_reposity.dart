import 'dart:convert';

import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/models/troca/troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:dio/dio.dart';
import '../../enumerators/endpoints.enum.dart';


final class TrocaReposity extends RequestRepository implements ITroca {
  static const String listarItensTrocaUrl = '/trocas/itens-troca';
  static const String realizarTrocaUrl = '/trocas';
  static const String criarItensTrocaUrl = '/trocas/adiciona-item-troca';
  static const String deletarItensTrocaUrl = '/trocas/deleta-item-troca';
  static const String atualizarItensTrocaUrl = '/trocas';

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
  Future addItensTroca({required String nome, required String descricao, required String unidadeMedida, required double boicoinsPorUnidade}) async {
    // Defina a URL usando o helper, caso disponível
    final url = apiHelpers.buildUrl(
        url: criarItensTrocaUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    // Converte o item para um mapa (usando o método toMap do model ItemTroca)
    final itemData = {
      'nomeItem': nome,
      'descricao': descricao,
      'unidadeMedida': unidadeMedida,
      'boicoinsPorUnidade': boicoinsPorUnidade,
    };
    // final itemDataString = jsonEncode(itemData);

    // // Monta o FormData para a requisição multipart/form-data
    // final formData = FormData.fromMap({
    //   'request': itemDataString,
    // });

    try {
      // Realiza a requisição POST com FormData
      final response = await client.post(url, itemData);

      if (response.statusCode == 200) {
        return (valid: true, reason: null, data: response.data);
      } else {
        return (
          valid: false,
          reason: response.statusMessage,
          data: response.data,
        );
      }
    } catch (error, stacktrace) {
      print("Erro ao cadastrar item: $error");
      print("Stacktrace: $stacktrace");
      return errorResponse(error, trace: stacktrace);
    }
  }
  
  @override
  Future atualizarItemTroca({
  required String itemId,
  String? nome,
  String? descricao,
  String? unidadeMedida,
  double? boicoinsPorUnidade,
}) async {
  // Defina a URL usando o helper, caso disponível
  final url = apiHelpers.buildUrl(
      url: atualizarItensTrocaUrl, endpoint: Endpoints.BOI_MARRONZINHO);

  // Cria um mapa para armazenar os campos a serem atualizados
  final Map<String, dynamic> itemData = {};

  // Adiciona os campos que não são nulos ao mapa
  if (nome != null) itemData['nomeItem'] = nome;
  if (descricao != null) itemData['descricao'] = descricao;
  if (unidadeMedida != null) itemData['unidadeMedida'] = unidadeMedida;
  if (boicoinsPorUnidade != null) itemData['boicoinsPorUnidade'] = boicoinsPorUnidade;

  try {
    // Realiza a requisição PATCH com os dados do item
    final response = await client.post('$url/$itemId', itemData);

    if (response.statusCode == 200) {
      return (valid: true, reason: null, data: response.data);
    } else {
      return (
        valid: false,
        reason: response.statusMessage,
        data: response.data,
      );
    }
  } catch (error, stacktrace) {
    print("Erro ao atualizar item: $error");
    print("Stacktrace: $stacktrace");
    return errorResponse(error, trace: stacktrace);
  }
}
  @override
  Future deletarItemTroca({required String id}) async {
    final url = apiHelpers.buildUrl(
        url: deletarItensTrocaUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.delete(url, {});
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (valid: true, reason: null, data: null);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
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
  
   @override
   Future deletarItemTroca({required String id}) async {
  //   final url = apiHelpers.buildUrl(
  //       url: deletarItemTrocaUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);

  //   try {
  //     final response = await client.delete(url, {});
  //     final invalidResponse = isValidResponse(response);
  //     if (!invalidResponse.valid) {
  //       return invalidResponse;
  //     }

  //     return (valid: true, reason: null, data: null);
  //   } catch (error, trace) {
  //     return errorResponse(error, trace: trace);
  //   }
   }


  




