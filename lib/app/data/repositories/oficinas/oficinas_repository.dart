import 'dart:io';

import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';
import 'package:dio/dio.dart';

final class OficinasRepository extends RequestRepository
    implements IOficinasRepository {
  static const String oficinasUrl = '/oficinas/lista-oficinas';
  static const String criarOficinasUrl = '/oficinas/cria-oficinas';
  static const String deletarOficinasUrl = '/oficinas/deleta-oficinas';
  late final CachedRequest _cache;

  OficinasRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.OFICINAS);
  }

  @override
  Future<dynamic> fetchOficinas() async {
    final url = apiHelpers.buildUrl(url: oficinasUrl);

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
  Future cadastrarOficina(
      {required String nome,
      required String descricao,
      required double precoBoicoin,
      required double precoReal,
      required String dataOficina,
      required int limiteOficina,
      required File imagem}) async {
    final url = apiHelpers.buildUrl(url: criarOficinasUrl);

    /*final Map<String, dynamic> bodyRegister = {
      'nome': 'LABES',
      'descricao': 'ENG SOFTWARE.',
      'precoBoicoins': 150,
      'precoReal': 200,
      'dataEvento': '2024-12-15T10:00:00Z',
      'limiteParticipantes': 30,
      'participantesAtual': 0,
      'pontoMapaId': '123e4567-e89b-12d3-a456-426614174001',
    };*/
    final formData = FormData.fromMap({
      'nome': 'LABES',
      'descricao': 'ENG SOFTWARE.',
      'precoBoicoins': 150,
      'precoReal': 200,
      'dataEvento': '2024-12-15T10:00:00Z',
      'limiteParticipantes': 30,
      'participantesAtual': 0,
      'pontoMapaId': '123e4567-e89b-12d3-a456-426614174001',
      'imagem': await MultipartFile.fromFile(imagem.path,
          filename: imagem.path.split('/').last),
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
    final url = apiHelpers.buildUrl(url: deletarOficinasUrl);
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
}
