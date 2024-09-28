abstract interface class IRegisterRepository {
  Future<dynamic> register({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
  });
}
