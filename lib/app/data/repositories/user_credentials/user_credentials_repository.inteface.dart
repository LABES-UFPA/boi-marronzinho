import 'package:boi_marronzinho/app/data/models/user_credentials/user_credentials.dart';

abstract interface class IUserCredentialsRepository {
  Future<void> saveCredentials(UserCredentials credentials);
  Future<void> clearCredentials();
  UserCredentials getCredentials();
}
