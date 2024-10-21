import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/voucher_response/voucher_response.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'dart:developer';

import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

final class VoucherRepository extends RequestRepository implements IVoucherRepository {
  static const String vouchersUrl = '/oficinas/meus-tickets/';
  static const String validaVouchersUrl = '/oficinas/scanner-voucher/';
  
  late final CachedRequest _cache;

  VoucherRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.VOUCHERS);
  }

  @override
  Future<dynamic> fetchVouchers({required String id}) async {
    final url = apiHelpers.buildUrl(url: vouchersUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);

    try {

      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Voucher>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);

      final vouchers = List.from(response.data).map((item) => Voucher.fromMap(item)).toList();

      return (valid: true, reason: null, data: vouchers);
    } catch (e, stackTrace) {
      log('Error fetching vouchers', error: e, stackTrace: stackTrace);
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

  @override
  Future<dynamic> validaVouchers({required String codigoQRCode}) async {
    final url = apiHelpers.buildUrl(url: vouchersUrl, endpoint: Endpoints.BOI_MARRONZINHO);
    final Map<String,dynamic> bodyRequest = {'idVoucher' : codigoQRCode};

    try {
      final response = await client.post(url, bodyRequest);

      final invalidResponse = isValidResponse<List<Voucher>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);
      return (valid: true, reason: null, data: response.data);
    } catch (e, stackTrace) {
      log('Error fetching vouchers', error: e, stackTrace: stackTrace);
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

}
