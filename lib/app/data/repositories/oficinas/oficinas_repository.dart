import 'dart:convert';
import 'dart:io';

import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:dio/dio.dart';

final class OficinasRepository extends RequestRepository
    implements IOficinasRepository {
  static const String oficinasUrl = '/oficinas/lista-oficinas';
  static const String criarOficinasUrl = '/oficinas/cria-oficinas';
  static const String deletarOficinasUrl = '/oficinas/deleta-oficinas/';
  static const String inscreverEmOficina = '/oficinas/inscricao';
  late final CachedRequest _cache;

  OficinasRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.OFICINAS);
  }

  @override
  Future<dynamic> fetchOficinas() async {
    final url = apiHelpers.buildUrl(
        url: oficinasUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Oficina>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);

      final oficinas = List.from(response.data)
          .map((item) => Oficina.fromMap(item))
          .toList();

      return (valid: true, reason: null, data: oficinas);
    } catch (e, stackTrace) {
      log('Error fetching oficinas', error: e, stackTrace: stackTrace);
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null
      );
    }
  }

  @override
  Future<dynamic> cadastrarOficina(
      {required String nome,
      required String descricao,
      required double precoBoicoins,
      required double precoReal,
      required String dataOficina,
      required int limiteOficina,
      required File imagem,
      required String urlEndereco}) async {
    final url = apiHelpers.buildUrl(
        url: criarOficinasUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    final oficinaData = {
      'nome': nome,
      'descricao': descricao,
      'precoBoicoins': precoBoicoins,
      'precoReal': precoReal,
      'dataEvento': dataOficina,
      'limiteParticipantes': limiteOficina,
      'linkEndereco': urlEndereco,
    };

    final productDataString = jsonEncode(oficinaData);
    final formData = FormData.fromMap({
      'request':
          productDataString, // Adicione o JSON como string no campo 'request'
      'file': await MultipartFile.fromFile(imagem.path,
          filename: imagem.path.split('/').last),
    });
    try {
      // Faça a requisição POST com multipart/form-data
      final response = await client.post(url, formData);

      if (response.statusCode == 200) {
        return (valid: true, reason: null, data: response.data);
      } else {
        return (
          valid: false,
          reason: response.statusMessage,
          data: response.data
        );
      }
    } catch (error, stacktrace) {
      print("Erro: $error");
      print("Stacktrace: $stacktrace");
      return errorResponse(error, trace: stacktrace);
    }
  }

  @override
  Future deletarOficinas({required String id}) async {
    final url = apiHelpers.buildUrl(
        url: deletarOficinasUrl+id, endpoint: Endpoints.BOI_MARRONZINHO);
    
    try {
      final response = await client.delete(url, {});
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }
      
    return Toast.success(
    'Sucesso',
    'Item deletado com sucesso!',
    delayed: true,
  );
      //return (valid: true, reason: null, data: null);
    } catch (error, trace) {
      return Toast.error(
         'Erro',
        'Falha ao tentar deletar: $error',
        delayed: true,
      );
      //return errorResponse(error, trace: trace);

    }
  }

  @override
  Future inscricaoOficina(
      {required String usuarioId, required String oficinaId}) async {
    final url = apiHelpers.buildUrl(
        url: inscreverEmOficina, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {
      'usuarioId': usuarioId,
      'oficinaId': oficinaId,
    };
    try {
      final response = await client.post(url, bodyRequest);
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (
        valid: true,
        reason: 'Inscrição confirmada com sucesso!',
        data: response.data
      );
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }

  @override
  Future<dynamic> editarOficina({
  required String id,
  required String nome,
  required String descricao,
  required double precoBoicoins,
  required double precoReal,
  required String dataOficina,
  required int limiteOficina,
  required File imagem,
  required String urlEndereco,
}) async {
  final url = apiHelpers.buildUrl(
      url: '/oficinas/$id', // Inclua o ID no endpoint
      endpoint: Endpoints.BOI_MARRONZINHO);

  final oficinaData = {
    'nome': nome,
    'descricao': descricao,
    'precoBoicoins': precoBoicoins,
    'precoReal': precoReal,
    'dataOficina': dataOficina,
    'limiteOficina': limiteOficina,
    'linkEndereco': urlEndereco,
  };

  final oficinaDataString = jsonEncode(oficinaData);

  final formData = FormData.fromMap({
    'request': oficinaDataString,
    'file': await MultipartFile.fromFile(imagem.path,
        filename: imagem.path.split('/').last),
  });

  try {
    final response = await client.put(url, formData);

    if (response.statusCode == 200) {
      return (valid: true, reason: null, data: response.data);
    } else {
      return (valid: false, reason: response.statusMessage, data: response.data);
    }
  } catch (error, stacktrace) {
    print("Erro: $error");
    print("Stacktrace: $stacktrace");
    return errorResponse(error, trace: stacktrace);
  }
}

}
