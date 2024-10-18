import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/models/user_credentials/user_credentials.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.inteface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/storage/memory_storage.dart';

final class UserCredentialsRepository extends RequestRepository implements IUserCredentialsRepository {
  final _credentialsStore = MemoryStore(StorageKeys.USER_CREDENTIALS);

  @override
  UserCredentials getCredentials() {
    final credential = _credentialsStore.read<Map<String, dynamic>>();

    if (credential == null) {
      return UserCredentials.clean();
    }

    return UserCredentials.fromMap(credential);
  }

  @override
  Future<void> saveCredentials(UserCredentials credentials) async {
    await _credentialsStore.write(credentials.toMap());
  }

  @override
  Future<void> clearCredentials() async {
    await _credentialsStore.remove();
  }
}