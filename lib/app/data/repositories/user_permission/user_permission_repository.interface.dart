
abstract class IUserPermissionRepository {
  Future<dynamic> fetchAllUsers();
  Future<dynamic> deleteUser({required String id});
  Future<dynamic> atualizarPermissaoUsuario({required String id, required String novaPermissao});
  Future<dynamic> atualizarUsuario({required String id});
}
