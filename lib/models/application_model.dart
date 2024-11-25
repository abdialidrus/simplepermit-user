import 'package:equatable/equatable.dart';
import 'package:permit_user_app/models/applicant_model.dart';
import 'package:permit_user_app/models/community_model.dart';
import 'package:permit_user_app/models/contractor_model.dart';
import 'package:permit_user_app/models/location_model.dart';

class ApplicationModel extends Equatable {
  final ApplicantModel applicant;
  final List<ContractorModel> contractors;
  final LocationModel location;
  // final CommunityModel community;
  final String communityRefId;

  const ApplicationModel({
    required this.applicant,
    required this.contractors,
    required this.location,
    // required this.community,
    required this.communityRefId,
  });

  Map<String, dynamic> toJson() => {
        'applicant': applicant.toJson(),
        'contractors': contractors.map((e) => e.toJson()).toList(),
        'location': location.toJson(),
        // 'community': community.toJson(),
        'communityRefId': communityRefId,
      };

  @override
  List<Object?> get props => [
        applicant,
        contractors,
        location,
        // community,
        communityRefId,
      ];
}
