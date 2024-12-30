import 'package:equatable/equatable.dart';
import 'package:permit_user_app/models/attachment_model.dart';

class LocationModel extends Equatable {
  final String state;
  final String city;
  final String country;
  final int zip;
  final String street;
  final String description;
  final double cost;
  final String permitType;
  final List<AttachmentModel> locationAttachments;

  const LocationModel({
    required this.state,
    required this.city,
    required this.country,
    required this.zip,
    required this.street,
    required this.description,
    required this.cost,
    required this.permitType,
    required this.locationAttachments,
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
        'locationFiles': locationAttachments.map((e) => e.id!).toList(),
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
        locationAttachments,
      ];
}
