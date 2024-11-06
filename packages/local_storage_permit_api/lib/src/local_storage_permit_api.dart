import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:permit_api/permit_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_permit_api}
/// A Flutter implementation of the [PermitApi] that uses local storage.
/// {@endtemplate}
class LocalStoragePermitApi extends PermitApi {
  /// {@macro local_storage_permit_api}
  LocalStoragePermitApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  late final _permitStreamController = BehaviorSubject<List<Permit>>.seeded(
    const [],
  );

  /// The key used for storing the permits locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kPermitsCollectionKey = '__permits_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final permitsJson = _getValue(kPermitsCollectionKey);
    if (permitsJson != null) {
      final permits = List<Map<dynamic, dynamic>>.from(
        json.decode(permitsJson) as List,
      )
          .map((jsonMap) => Permit.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _permitStreamController.add(permits);
    } else {
      _permitStreamController.add(const []);
    }
  }

  @override
  Stream<List<Permit>> getPermits() =>
      _permitStreamController.asBroadcastStream();

  @override
  Future<void> savePermit(Permit permit) {
    final permits = [..._permitStreamController.value];
    final permitIndex = permits.indexWhere((t) => t.id == permit.id);
    if (permitIndex >= 0) {
      permits[permitIndex] = permit;
    } else {
      permits.add(permit);
    }

    _permitStreamController.add(permits);
    return _setValue(kPermitsCollectionKey, json.encode(permits));
  }

  @override
  Future<void> deletePermit(String id) async {
    final permits = [..._permitStreamController.value];
    final permitIndex = permits.indexWhere((t) => t.id == id);
    if (permitIndex == -1) {
      throw PermitNotFoundException();
    } else {
      permits.removeAt(permitIndex);
      _permitStreamController.add(permits);
      return _setValue(kPermitsCollectionKey, json.encode(permits));
    }
  }

  @override
  Future<void> close() {
    return _permitStreamController.close();
  }
}
