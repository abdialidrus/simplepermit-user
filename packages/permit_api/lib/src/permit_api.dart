import 'package:permit_api/src/models/permit.dart';

/// {@template permit_api}
/// The interface and models for an API providing access to permit.
/// {@endtemplate}
abstract class PermitApi {
  /// {@macro permit_api}
  const PermitApi();

  /// Provides a [Stream] of all permits.
  Stream<List<Permit>> getPermits();

  /// Saves a [permit].
  ///
  /// If a [permit] with the same id already exists,
  /// it will be replaced.
  Future<void> savePermit(Permit permit);

  /// Deletes the `permit` with the given id.
  ///
  /// If no `permit` with the given id exists, a [PermitNotFoundException]
  /// error isthrown.
  Future<void> deletePermit(String id);

  /// Closes the client and frees up any resources.
  Future<void> close();
}

/// Exception thrown when a permit is not found.
class PermitNotFoundException implements Exception {}
