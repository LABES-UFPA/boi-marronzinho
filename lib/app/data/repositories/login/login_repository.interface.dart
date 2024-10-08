abstract interface class ILoginRepository {
  Future<dynamic> login({
    required String password,
    required String email,
  });
}
