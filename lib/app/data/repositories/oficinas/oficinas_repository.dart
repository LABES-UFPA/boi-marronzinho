import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

final class OficinasRepository extends RequestRepository implements IOficinasRepository {
  static const String oficinasUrl = '/oficinas';
  
  late final CachedRequest _cache;

  OficinasRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.OFICINAS);
  }
  
  @override
  Future <dynamic> fetchOficinas() async {
    final url = apiHelpers.buildUrl(url: oficinasUrl);

    try {
      //final cachedVouchers = await _cache.readDataFromCache<List>();
      //if (cachedVouchers != null) {
       // return (valid: true, reason: null, data: cachedVouchers.map((x) => Voucher.fromMap(x)).toList());
      //}

      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Oficina>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);

      final vouchers = List.from(response.data).map((item) => Oficina.fromMap(item)).toList();

      return (valid: true, reason: null, data: vouchers);
    } catch (e, stackTrace) {
      log('Error fetching vouchers', error: e, stackTrace: stackTrace);
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
    throw UnimplementedError();
  }

}
