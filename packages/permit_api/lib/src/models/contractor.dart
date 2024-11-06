import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:permit_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'contractor.g.dart';

///
@immutable
@JsonSerializable()
class Contractor extends Equatable {
  /// {@macro contractor_item}
  Contractor({
    required this.trade,
    required this.name,
    required this.email,
    required this.phone,
    required this.state,
    required this.city,
    required this.country,
    required this.zip,
    required this.street,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `contractor`.
  final String id;

  /// The trade of the `contractor`.
  final String trade;

  /// The name of the `contractor`.
  final String name;

  /// The email of the `contractor`.
  final String email;

  /// The phone number of the `contractor`.
  final String phone;

  /// The state of the `contractor`.
  final String state;

  /// The city of the `contractor`.
  final String city;

  /// The country of the `contractor`.
  final String country;

  /// The zip code of the `contractor`.
  final String zip;

  /// The street of the `contractor`.
  final String street;

  /// Returns a copy of this `contractor` with the given values updated.
  Contractor copyWith({
    String? id,
    String? trade,
    String? name,
    String? email,
    String? phone,
    String? state,
    String? city,
    String? country,
    String? zip,
    String? street,
  }) {
    return Contractor(
      id: id ?? this.id,
      trade: trade ?? this.trade,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      street: street ?? this.street,
    );
  }

  /// Deserializes the given [JsonMap] into a [Contractor].
  static Contractor fromJson(JsonMap json) => _$ContractorFromJson(json);

  /// Converts this [Contractor] into a [JsonMap].
  JsonMap toJson() => _$ContractorToJson(this);

  @override
  List<Object> get props => [
        id,
        trade,
        name,
        email,
        phone,
        state,
        city,
        country,
        zip,
        street,
      ];
}
