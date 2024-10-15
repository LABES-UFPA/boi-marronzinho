
// import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
// import 'package:boi_marronzinho/app/data/request_repository.dart';
// import 'package:boi_marronzinho/app/data/storage/cached_request.dart';

// import 'profile_repository.interface.dart';

// final class ProfileRepository extends RequestRepository implements IProfileRepository {
//   static final StorageKeys profileTag = StorageKeys.PROFILE_INFO;
//   static final String profileUrl = '/account';

//   late final CachedRequest _cache;

//   ProfileRepository({CachedRequest? cachedRequest}) {
//     _cache = cachedRequest ?? CachedRequest(key: profileTag);
//   }

//   @override
//   Future<ValidResponse<Profile>> getProfileInfo() async {
//     // final url = apiHelpers.buildUrl(url: profileUrl, endpoint: Endpoints.B);

//     try {
//       // final cachedInfo = await _cache.readDataFromCache();
//       // if (cachedInfo != null) {
//       //   return (valid: true, reason: null, data: Profile.fromMap(cachedInfo));
//       // }

//       final response = await client.get('url');

//       final invalidResponse = isValidResponse<Profile>(response);
//       if (!invalidResponse.valid) {
//         return invalidResponse;
//       }

//       await _cache.cacheRequest(response.data);
//       return (valid: true, reason: null, data: Profile.fromMap(response.data));
//     } catch (_) {
//       return (valid: false, reason: 'Erro interno durante a requisição', data: null);
//     }
//   }
// }
