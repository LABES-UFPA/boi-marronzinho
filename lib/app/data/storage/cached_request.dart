import 'dart:convert';

import 'package:boi_marronzinho/app/data/enumerators/storage_keys.enum.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';

import 'memory_storage.dart';

/// `CachedRequest` is an interface for managing cached requests.
/// It provides methods for invalidating, writing and reading cache.
class CachedRequest {
  late final MemoryStore _store;
  late final ApiHelpers _apiHelpers;

  /// The constructor ensures that at least an instance of MemoryStore or a StorageKeys.
  CachedRequest({ApiHelpers? apiHelpers, StorageKeys? key, MemoryStore? store}) {
    assert(
      key != null || store != null,
      'Deve ser informado pelo menos uma instância de MemoryStore ou uma StorageKeys',
    );

    _store = store ?? MemoryStore(key!);
    _apiHelpers = apiHelpers ?? ApiHelpers();
  }

  /// Method used to invalidate the cache.
  Future<void> invalidateCache() async => await _store.remove();

  /// Method used to write a request to the cache.
  Future<void> cacheRequest(dynamic payload, {int? timestamp}) async {
    assert(
      payload != null && payload.toString().isNotEmpty,
      'Conteúdo do cache não pode ser nulo',
    );

    await _store.write(jsonEncode({
      'timestamp': timestamp ?? DateTime.now().millisecondsSinceEpoch,
      'data': payload,
    }));
  }

  /// Method used to read existing data from the cached request.
  /// It can optionally bypass the lifespan of the cache.
  Future<T?> readDataFromCache<T>({bool bypassLifespan = false, int? timestamp}) async {
    final exists = _store.read<String>();
    if (exists == null) {
      return null;
    }

    final entry = jsonDecode(exists);

    final timeDiff = (timestamp ?? DateTime.now().millisecondsSinceEpoch) - entry['timestamp'];
    if (!bypassLifespan && timeDiff >= _apiHelpers.getCacheLifespan()) {
      await invalidateCache();
      return null;
    }

    return entry['data'];
  }

  Future<Map<String, dynamic>?> readEntryFromCache() async {
    final exists = _store.read<String>();
    if (exists == null) {
      return null;
    }

    return jsonDecode(exists);
  }
}
