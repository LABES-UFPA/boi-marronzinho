import 'package:boi_marronzinho/app/data/models/user_permission/user_permission.dart';
import 'package:boi_marronzinho/app/data/repositories/user_permission/user_permission_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

final class UserPermissionRepository extends RequestRepository implements IUserPermissionRepository{
  //static final StorageKeys userPermissionTag = StorageKeys.USER_PERMISSION_INFO;
  final String getTodosUsuariosUrl = '/usuarios/todos-usuarios';
  final String atualizarPermissaoUrl = '/usuarios/permissao/';

  // late final CachedRequest _cache;

  UserPermissionRepository({CachedRequest? cachedRequest}) {
    //_cache = cachedRequest ?? CachedRequest(key: userPermissionTag);
  }

  @override
  Future<dynamic> fetchAllUsers() async {
    final url = apiHelpers.buildUrl(url: getTodosUsuariosUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      // final cachedInfo = await _cache.readDataFromCache();
      // if (cachedInfo != null) {
      //   final userPermissionsCache = List.from(cachedInfo).map((item) => UserPermission.fromMap(item)).toList();
      //   return (valid: true, reason: null, data: userPermissionsCache);
      // }

      final response = await client.get(url);
      final invalidResponse = isValidResponse<List<UserPermission>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);
      final userPermissions = List.from(response.data)
          .map((item) => UserPermission.fromMap(item))
          .toList();

      return (valid: true, reason: 'Sucesso ao pegar usuários', data: userPermissions);
    } catch (e) {
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null,
      );
    }
  }

  @override
  Future atualizarPermissaoUsuario({required String id, required String novaPermissao}) async {
    final url = apiHelpers.buildUrl(url: atualizarPermissaoUrl + id, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {
      'tipoUsuario': novaPermissao
    };

    try {
      // final cachedInfo = await _cache.readDataFromCache();
      // if (cachedInfo != null) {
      //   final userPermissionsCache = List.from(cachedInfo).map((item) => UserPermission.fromMap(item)).toList();
      //   return (valid: true, reason: null, data: userPermissionsCache);
      // }

      final response = await client.put(url, bodyRequest);
      final invalidResponse = isValidResponse<List<UserPermission>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);
      // final userPermissions = List.from(response.data)
      //     .map((item) => UserPermission.fromMap(item));

      return (valid: true, reason: 'Sucesso ao pegar usuários', data: 'usuário atualizado com sucesso');
    } catch (e) {
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: null,
      );
    }
  }

  @override
  Future atualizarUsuario({required String id}) {
    // TODO: implement atualizarUsuario
    throw UnimplementedError();
  }

  @override
  Future deleteUser({required String id}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

}
