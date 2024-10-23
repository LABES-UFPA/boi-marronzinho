import 'dart:developer';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/data/repositories/evento/evento_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/storage/cached_request.dart';
import 'package:dio/dio.dart';

final class EventosRepository extends RequestRepository implements IEventosRepository {
  static const String eventosUrl = '/eventos/lista-eventos';
  static const String criarEventosUrl = '/eventos/cria-evento';
  static const String deletarEventosUrl = '/eventos/deleta-evento';
  static const String editarEventosUrl = '/eventos/atualiza-evento';
  static const String eventoPorIdUrl = '/eventos/'; // Base URL para obter evento por ID
  late final CachedRequest _cache;

  // EventosRepository({CachedRequest? cachedRequest}) {
  //   // TODO: adicionar a key dps
  //   _cache = cachedRequest ?? CachedRequest(key: StorageKeys.EVENTOS);
  // }

  @override
  Future<dynamic> fetchEventos() async {
    final url = apiHelpers.buildUrl(url: eventosUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Evento>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);

      final eventos = List.from(response.data)
          .map((item) => Evento.fromMap(item))
          .toList();

      return (valid: true, reason: null, data: eventos);
    } catch (e, stackTrace) {
      log('Error fetching eventos', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: null
      );
    }
  }

  @override
  Future<dynamic> fetchEventoPorId({required String id}) async {
    final url = apiHelpers.buildUrl(url: '$eventoPorIdUrl/$id', endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);
      final invalidResponse = isValidResponse<Evento>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      final evento = Evento.fromMap(response.data);
      return (valid: true, reason: null, data: evento);
    } catch (e, stackTrace) {
      log('Error fetching evento por ID', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: null
      );
    }
  }

  @override
  Future<dynamic> cadastrarEvento({
    required String nome,
    required String descricao,
    required String dataEvento,
    required String urlEndereco,
  }) async {
    final url = apiHelpers.buildUrl(url: criarEventosUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    final formData = FormData.fromMap({
      'nome': nome,
      'descricao': descricao,
      'dataEvento': dataEvento,
      'linkEndereco': urlEndereco,
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
  Future<dynamic> deletarEvento({required String id}) async {
    // TODO: Delete tá passando id pelo body
    final url = apiHelpers.buildUrl(url: deletarEventosUrl,  endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {'id': id};

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
  Future<dynamic> editarEvento({
    required String id,
    required String nome,
    required String descricao,
    required String dataEvento,
    required String urlEndereco,
  }) async {
    final url = apiHelpers.buildUrl(url: '$editarEventosUrl/$id',  endpoint: Endpoints.BOI_MARRONZINHO);

    final formData = FormData.fromMap({
      'nome': nome,
      'descricao': descricao,
      'dataEvento': dataEvento,
      'linkEndereco': urlEndereco,
    });

    try {
      final response = await client.put(url, formData);
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
