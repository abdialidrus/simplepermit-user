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

  /// Closes the client and frees up any resources.
  Future<void> close();
}
