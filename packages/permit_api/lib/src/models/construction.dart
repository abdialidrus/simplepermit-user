import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:permit_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'construction.g.dart';

///
@immutable
@JsonSerializable()
class Construction extends Equatable {
  /// {@macro construction_item}
  Construction({
    required this.state,
    required this.city,
    required this.country,
    required this.zip,
    required this.street,
    required this.description,
    required this.totalEstimatedCost,
    required this.permitNumber,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `construction`.
  ///
  /// Cannot be empty.
  final String id;

  /// The state of the `construction`.
  ///
  /// Cannot be empty.
  final String state;

  /// The city of the `construction`.
  ///
  /// Cannot be empty.
  final String city;

  /// The country of the `construction`.
  ///
  /// Cannot be empty.
  final String country;

  /// The zip code of the `construction`.
  ///
  /// Cannot be empty.
  final String zip;

  /// The street of the `construction`.
  ///
  /// Cannot be empty.
  final String street;

  /// The city of the `construction`.
  ///
  /// Cannot be empty.
  final String description;

  /// The total estimated cost of the `construction`.
  final double totalEstimatedCost;

  /// The permit number of the `construction`.
  final String permitNumber;

  /// Returns a copy of this `construction` with the given values updated.
  Construction copyWith({
    String? id,
    String? state,
    String? city,
    String? country,
    String? zip,
    String? street,
    String? description,
    double? totalEstimatedCost,
    String? permitNumber,
  }) {
    return Construction(
      id: id ?? this.id,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      street: street ?? this.street,
      description: description ?? this.description,
      totalEstimatedCost: totalEstimatedCost ?? this.totalEstimatedCost,
      permitNumber: permitNumber ?? this.permitNumber,
    );
  }

  /// Deserializes the given [JsonMap] into a [Construction].
  static Construction fromJson(JsonMap json) => _$ConstructionFromJson(json);

  /// Converts this [Construction] into a [JsonMap].
  JsonMap toJson() => _$ConstructionToJson(this);

  @override
  List<Object> get props => [
        id,
        state,
        city,
        country,
        zip,
        street,
        description,
        totalEstimatedCost,
        permitNumber,
      ];
}
