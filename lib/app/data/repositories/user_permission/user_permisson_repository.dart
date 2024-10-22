import 'package:boi_marronzinho/app/data/models/user_permission/user_permission.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

final class UserPermissionRepository extends RequestRepository {
  //static final StorageKeys userPermissionTag = StorageKeys.USER_PERMISSION_INFO;
  static final String userPermissionUrl = '/userPermissions/';

  late final CachedRequest _cache;

  UserPermissionRepository({CachedRequest? cachedRequest}) {
    //_cache = cachedRequest ?? CachedRequest(key: userPermissionTag);
  }

  @override
  Future<dynamic> fetchAllUserPermissions() async {
    final url = apiHelpers.buildUrl(url: userPermissionUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final cachedInfo = await _cache.readDataFromCache();
      if (cachedInfo != null) {
        final userPermissionsCache = List.from(cachedInfo).map((item) => UserPermission.fromMap(item)).toList();
        return (valid: true, reason: null, data: userPermissionsCache);
      }

      final response = await client.get(url);
      final invalidResponse = isValidResponse<List<UserPermission>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      await _cache.cacheRequest(response.data);
      final userPermissions = List.from(response.data)
          .map((item) => UserPermission.fromMap(item))
          .toList();

      return (valid: true, reason: null, data: userPermissions);
    } catch (e) {
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null,
      );
    }
  }

  @override
  Future<dynamic> deleteUserPermission({required String id}) async {
    final url = apiHelpers.buildUrl(url: userPermissionUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);
    /*
    try {
      final response = await client.delete(url);
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }
      return (valid: true, reason: null, data: null);
    } catch (e) {
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null,
      );
    }*/
  }
}
