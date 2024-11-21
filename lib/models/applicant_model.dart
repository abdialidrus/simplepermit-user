import 'package:equatable/equatable.dart';

class ApplicantModel extends Equatable {
  final String name;
  final String country;
  final String state;
  final String city;
  final String street;
  final String zip;
  final String email;
  final String phoneNumber;
  final String notes;

  const ApplicantModel({
    required this.name,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    required this.zip,
    required this.email,
    required this.phoneNumber,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'country': country,
        'state': state,
        'city': city,
        'street': street,
        'zip': zip,
        'email': email,
        'phoneNumber': phoneNumber,
        'notes': notes,
      };

  @override
  List<Object?> get props => [
        name,
        country,
        state,
        city,
        street,
        zip,
        email,
        phoneNumber,
        notes,
      ];
}
