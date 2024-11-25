import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String state;
  final String city;
  final String country;
  final String zip;
  final String street;
  final String description;
  final double cost;
  final String permitType;
  final List<int> locationDocumentIds;

  const LocationModel({
    required this.state,
    required this.city,
    required this.country,
    required this.zip,
    required this.street,
    required this.description,
    required this.cost,
    required this.permitType,
    required this.locationDocumentIds,
  });

  Map<String, dynamic> toJson() => {
        'state': state,
        'city': city,
        'country': country,
        'zip': zip,
        'street': street,
        'description': description,
        'cost': cost,
        'permitType': permitType,
        'locationFiles': locationDocumentIds,
      };

  @override
  List<Object?> get props => [
        state,
        city,
        country,
        zip,
        street,
        description,
        cost,
        permitType,
        locationDocumentIds,
      ];
}
