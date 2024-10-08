import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/voucher_response/voucher_response.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

final class VoucherRepository extends RequestRepository implements IVoucherRepository {
  static const String vouchersUrl = '/oficinas/meus-tickets';
  
  late final CachedRequest _cache;

  VoucherRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.VOUCHERS);
  }

  @override
  Future<dynamic> fetchVouchers() async {
    final url = apiHelpers.buildUrl(url: vouchersUrl);

    try {
      final cachedVouchers = await _cache.readDataFromCache<List>();
      if (cachedVouchers != null) {
        return (valid: true, reason: null, data: cachedVouchers.map((x) => VoucherResponse.fromMap(x)).toList());
      }

      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<VoucherResponse>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);

      final vouchers = List.from(response.data).map((item) => VoucherResponse.fromMap(item)).toList();

      return (valid: true, reason: null, data: vouchers);
    } catch (e, stackTrace) {
      log('Error fetching vouchers', error: e, stackTrace: stackTrace);
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }
}
