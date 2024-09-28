import 'package:boi_marronzinho/app/data/repositories/register/register_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import '../../enumerators/endpoints.enum.dart';


final class RegisterRepository extends RequestRepository implements IRegisterRepository {
  static const String registerUser = '/usuarios/singup';

  @override
  Future register({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
  }) async {
    final url = apiHelpers.buildUrl(url: registerUser, endpoint: Endpoints.BOI_MARRONZINHO);

    final Map<String, dynamic> bodyRegister = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    try {
      final response = await client.post(url, bodyRegister);
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (valid: true, reason: null, data: null);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }

}
