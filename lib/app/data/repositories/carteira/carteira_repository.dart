import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/repositories/carteira/carteira_repository.interface.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/storage/cached_request.dart';


final class CarteiraRepository implements ICarteiraRepositoryInterface {
  // TODO: Como pego o ID?
  static const String extratoUrl = '/extrato/:id';

  late final CachedRequest _cache;

  CarteiraRepository({CachedRequest? cachedRequest}) {
    _cache = cachedRequest ?? CachedRequest(key: StorageKeys.PROFILE_INFO);
  }

  @override
  Future<dynamic> fetchBoicoins() async {
    // TODO: implement fetchBoicoins
    throw UnimplementedError();
  }

  @override
  Future<dynamic> fetchExtrato() {
    // TODO: implement fetchExtrato
    throw UnimplementedError();
  }
}