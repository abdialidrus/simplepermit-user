import 'package:equatable/equatable.dart';
import 'package:stacked_permit_user_app/models/applicant_model.dart';
import 'package:stacked_permit_user_app/models/contractor_model.dart';
import 'package:stacked_permit_user_app/models/location_model.dart';

class ApplicationModel extends Equatable {
  final ApplicantModel applicant;
  final List<ContractorModel> contractors;
  final LocationModel location;

  const ApplicationModel({
    required this.applicant,
    required this.contractors,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'applicant': applicant.toJson(),
        'contractors': contractors.map((e) => e.toJson()).toList(),
        'location': location.toJson(),
      };

  @override
  List<Object?> get props => [applicant, contractors, location];
}
