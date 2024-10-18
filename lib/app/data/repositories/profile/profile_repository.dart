
import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/extrato/extrato.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

import '../../enumerators/endpoints.enum.dart';
import '../../models/profile/profile.dart';
import 'profile_repository.interface.dart';

final class ProfileRepository extends RequestRepository implements IProfileRepository {
  static final StorageKeys profileTag = StorageKeys.PROFILE_INFO;
  static final String profileUrl = '/usuarios/';
  static final String extratoUrl = '/usuarios/extrato/';

  late final CachedRequest _cache;

  ProfileRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: profileTag);
  }

  @override
  Future<ValidResponse<Profile>> getProfileInfo({required String id}) async {
    final url = apiHelpers.buildUrl(url: profileUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final cachedInfo = await _cache.readDataFromCache();
      if (cachedInfo != null) {
        return (valid: true, reason: null, data: Profile.fromMap(cachedInfo));
      }

      final response = await client.get(url);

      final invalidResponse = isValidResponse<Profile>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);
      return (valid: true, reason: null, data: Profile.fromMap(response.data));
    } catch (_) {
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

  @override
  Future<ValidResponse<BoicoinsTransacoes>> getExtrato({required String id}) async {
    final url = apiHelpers.buildUrl(url: extratoUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final cachedInfo = await _cache.readDataFromCache();
      if (cachedInfo != null) {
        return (valid: true, reason: null, data: BoicoinsTransacoes.fromMap(cachedInfo));
      }

      final response = await client.get(url);

      final invalidResponse = isValidResponse<BoicoinsTransacoes>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);
      return (valid: true, reason: null, data: BoicoinsTransacoes.fromMap(response.data));
    } catch (_) {
      return (valid: false, reason: 'Erro interno durante a requisição', data: null);
    }
  }

}
