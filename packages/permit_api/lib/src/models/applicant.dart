import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:permit_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'applicant.g.dart';

///
@immutable
@JsonSerializable()
class Applicant extends Equatable {
  /// {@macro applicant_item}
  Applicant({
    required this.name,
    required this.email,
    required this.phone,
    required this.state,
    required this.city,
    required this.zip,
    required this.street,
    String? id,
    this.isOwner = false,
    this.isContractor = false,
    this.isReprensentative = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `applicant`.
  ///
  /// Cannot be empty.
  final String id;

  /// The name of the `applicant`.
  ///
  /// Cannot be empty.
  final String name;

  /// The email of the `applicant`.
  ///
  /// Cannot be empty.
  final String email;

  /// The phone number of the `applicant`.
  ///
  /// Cannot be empty.
  final String phone;

  /// The state of the `applicant`.
  ///
  /// Cannot be empty.
  final String state;

  /// The city of the `applicant`.
  ///
  /// Cannot be empty.
  final String city;

  /// The zip code of the `applicant`.
  ///
  /// Cannot be empty.
  final String zip;

  /// The street of the `applicant`.
  ///
  /// Cannot be empty.
  final String street;

  /// Whether the `applicant` is the owner.
  ///
  /// Defaults to `false`.
  final bool isOwner;

  /// Whether the `applicant` is the contractor.
  ///
  /// Defaults to `false`.
  final bool isContractor;

  /// Whether the `applicant` is the owner representative.
  ///
  /// Defaults to `false`.
  final bool isReprensentative;

  /// Returns a copy of this `applicant` with the given values updated.
  ///
  /// {@macro applicant_item}
  Applicant copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? state,
    String? city,
    String? zip,
    String? street,
    bool? isOwner,
    bool? isContractor,
    bool? isReprensentative,
  }) {
    return Applicant(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      street: street ?? this.street,
      isOwner: isOwner ?? this.isOwner,
      isContractor: isContractor ?? this.isContractor,
      isReprensentative: isReprensentative ?? this.isReprensentative,
    );
  }

  /// Deserializes the given [JsonMap] into a [Applicant].
  static Applicant fromJson(JsonMap json) => _$ApplicantFromJson(json);

  /// Converts this [Applicant] into a [JsonMap].
  JsonMap toJson() => _$ApplicantToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phone,
        state,
        city,
        zip,
        street,
        isOwner,
        isContractor,
        isReprensentative,
      ];
}
