abstract interface class IProfileRepository {
  Future<dynamic> getProfileInfo({required String id});
  Future<dynamic> getExtrato({required String id});
  Future<dynamic> deletarConta({required String id});
}
