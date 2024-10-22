
abstract class IUserPermissionRepository {
  Future<dynamic> fetchAllUserPermissions();
  Future<dynamic> deleteUserPermission({required String id});
}
