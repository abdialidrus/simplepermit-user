import 'package:equatable/equatable.dart';

class ApplicantModel extends Equatable {
  final String firstName;
  final String lastName;
  final String country;
  final String state;
  final String city;
  final String street;
  final int zip;
  final String email;
  final String phoneNumber;
  final String notes;
  final String role;

  const ApplicantModel({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
    required this.zip,
    required this.email,
    required this.phoneNumber,
    required this.notes,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'country': country,
        'state': state,
        'city': city,
        'street': street,
        'zip': zip,
        'email': email,
        'phoneNumber': phoneNumber,
        'notes': notes,
        'role': role,
      };

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        country,
        state,
        city,
        street,
        zip,
        email,
        phoneNumber,
        notes,
        role,
      ];
}
