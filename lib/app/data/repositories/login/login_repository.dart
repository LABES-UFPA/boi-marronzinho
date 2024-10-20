import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/user_credentials/user_credentials.dart';
import 'package:boi_marronzinho/app/data/repositories/register/register_repository.interface.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';
import 'package:boi_marronzinho/app/data/util/helpers/index.dart';
import '../../enumerators/endpoints.enum.dart';
import 'login_repository.interface.dart';

final class LoginRepository extends RequestRepository implements ILoginRepository {
  static const String registerUser = '/usuarios/login';

  late final MemoryStore _userTokenStore;
  late final UserCredentialsRepository _credentialsRepository;

  LoginRepository({MemoryStore? store, Helpers? helpers, UserCredentialsRepository? credentialsRepository}) {
    _userTokenStore = store ?? MemoryStore(StorageKeys.USER_TOKEN);
    _credentialsRepository = credentialsRepository ?? UserCredentialsRepository();
  }

  @override
  Future login({
    required String password,
    required String email,
  }) async {
    final url = apiHelpers.buildUrl(url: registerUser, endpoint: Endpoints.BOI_MARRONZINHO);

    final Map<String, dynamic> bodyRegister = {
      'email': email,
      'password': password,
    };

    try {
      final response = await client.post(url, bodyRegister);
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      final token = response.data['login']['token'];
      final userId = response.data['login']['id'];
      final userEmail = response.data['login']['email'];
      final userName = response.data['login']['firstName'] + ' ' + response.data['login']['lastName'];

      await _userTokenStore.write(token);
      await _credentialsRepository.saveCredentials(UserCredentials(userId: userId, email: userEmail, name: userName));

      return (valid: true, reason: null, data: null);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }
}
