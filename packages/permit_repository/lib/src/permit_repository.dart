import 'package:permit_api/permit_api.dart';

/// {@template permit_repository}
/// A repository that handles permit related requests.
/// {@endtemplate}
class PermitRepository {
  /// {@macro permit_repository}
  const PermitRepository({
    required PermitApi permitApi,
  }) : _permitApi = permitApi;

  final PermitApi _permitApi;

  /// Provides a [Stream] of all permits.
  Stream<List<Permit>> getPermits() => _permitApi.getPermits();

  /// Saves a [permit].
  ///
  /// If a [permit] with the same [Permit.id] already exists, it will be
  /// overwritten.
  Future<void> savePermit(Permit permit) => _permitApi.savePermit(permit);

  /// Deletes a `permit` with the given [id].
  ///
  /// If no `permit` with the given id exists, a [PermitNotFoundException] will
  /// be thrown.
  Future<void> deletePermit(String id) => _permitApi.deletePermit(id);
}
