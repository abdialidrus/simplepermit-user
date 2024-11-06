import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:permit_api/src/models/applicant.dart';
import 'package:permit_api/src/models/construction.dart';
import 'package:permit_api/src/models/contractor.dart';
import 'package:permit_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'permit.g.dart';

///
@immutable
@JsonSerializable()
class Permit extends Equatable {
  /// {@macro permit_item}
  Permit({
    required this.notes,
    this.applicant,
    this.contractor,
    this.construction,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `permit`.
  ///
  /// Cannot be empty.
  final String id;

  /// The applicant of the `permit`.
  final Applicant? applicant;

  /// The contractor of the `permit`.
  final Contractor? contractor;

  /// The construction of the `permit`.
  final Construction? construction;

  /// Additional notes for the `permit`.
  final String notes;

  /// Returns a copy of this `permit` with the given values updated.
  ///
  /// {@macro permit_item}
  Permit copyWith({
    String? id,
    Applicant? applicant,
    Contractor? contractor,
    Construction? construction,
    String? notes,
  }) {
    return Permit(
      id: id ?? this.id,
      applicant: applicant ?? this.applicant,
      contractor: contractor ?? this.contractor,
      construction: construction ?? this.construction,
      notes: notes ?? this.notes,
    );
  }

  /// Deserializes the given [JsonMap] into a [Permit].
  static Permit fromJson(JsonMap json) => _$PermitFromJson(json);

  /// Converts this [Permit] into a [JsonMap].
  JsonMap toJson() => _$PermitToJson(this);

  @override
  List<Object> get props => [id];
}
