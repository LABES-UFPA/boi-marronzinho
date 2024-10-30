import 'dart:io';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';
import 'package:dio/dio.dart';

final class OficinasRepository extends RequestRepository implements IOficinasRepository {
  static const String oficinasUrl = '/oficinas/lista-oficinas';
  static const String criarOficinasUrl = '/oficinas/cria-oficinas';
  static const String deletarOficinasUrl = '/oficinas/deleta-oficinas';
  static const String inscreverEmOficina = '/oficinas/inscricao';
  late final CachedRequest _cache;

  OficinasRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.OFICINAS);
  }

  @override
  Future<dynamic> fetchOficinas() async {
    final url = apiHelpers.buildUrl(url: oficinasUrl, endpoint: Endpoints.BOI_MARRONZINHO);

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
  Future <dynamic> cadastrarOficina(
      {required String nome,
        required String descricao,
        required double precoBoicoins,
        required double precoReal,
        required String dataOficina,
        required int limiteOficina,
        required File imagem,
        required String urlEndereco
      }) async {
    final url = apiHelpers.buildUrl(url: criarOficinasUrl);

    final formData = FormData.fromMap({
      'nome': nome,
      'descricao': descricao,
      'precoBoicoins': precoBoicoins,
      'precoReal': precoReal,
      'dataEvento': dataOficina,
      'limiteParticipantes': limiteOficina,
      'linkEndereco': urlEndereco,
      'file': await MultipartFile.fromFile(imagem.path, filename: imagem.path.split('/').last),
    });

    try {
      final response = await client.post(url, formData);
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
  Future deletarOficinas({required String id}) async {
    final url = apiHelpers.buildUrl(url: deletarOficinasUrl, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {'id':id};
    try {
      final response = await client.delete(url, bodyRequest);
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
  Future inscricaoOficina({required String usuarioId, required String oficinaId}) async {
    final url = apiHelpers.buildUrl(url: inscreverEmOficina, endpoint: Endpoints.BOI_MARRONZINHO);
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

      return (valid: true, reason: 'Inscrição confirmada com sucesso!', data: response.data);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }
}
