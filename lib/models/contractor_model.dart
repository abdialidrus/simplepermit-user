import 'package:equatable/equatable.dart';
import 'package:permit_user_app/models/attachment_model.dart';

class ContractorModel extends Equatable {
  final String individualName;
  final String trade;
  final String email;
  final String phoneNumber;
  final String state;
  final String city;
  final String country;
  final int zip;
  final String street;
  final List<AttachmentModel> licenseDocuments;

  const ContractorModel({
    required this.individualName,
    required this.trade,
    required this.email,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.country,
    required this.zip,
    required this.street,
    required this.licenseDocuments,
  });

  Map<String, dynamic> toJson() => {
        'individualName': individualName,
        'trade': trade,
        'email': email,
        'phoneNumber': phoneNumber,
        'state': state,
        'city': city,
        'country': country,
        'zip': zip,
        'street': street,
        'license': licenseDocuments.map((e) => e.id!).toList(),
      };

  @override
  List<Object?> get props => [
        individualName,
        trade,
        email,
        phoneNumber,
        state,
        city,
        country,
        zip,
        street,
        licenseDocuments,
      ];
}
