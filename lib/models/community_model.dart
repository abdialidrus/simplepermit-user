import 'package:equatable/equatable.dart';

class CommunityModel extends Equatable {
  const CommunityModel({
    required this.communityId,
    required this.communityName,
    required this.workEmail,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.country,
    required this.zipcode,
    required this.street,
    required this.region,
    required this.permitType,
    required this.status,
    required this.userId,
  });

  final int communityId;
  final String communityName;
  final String workEmail;
  final String phoneNumber;
  final String state;
  final String city;
  final String country;
  final String zipcode;
  final String street;
  final String region;
  final String permitType;
  final String status;
  final int userId;

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      communityId: json['communityId'] as int,
      communityName: json['communityName'] as String,
      workEmail: json['workEmail'] as String,
      phoneNumber: json['phoneNumber'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zipcode: json['zipcode'] as String,
      street: json['street'] as String,
      region: json['region'] as String,
      permitType: json['permitType'] as String,
      status: json['status'] as String,
      userId: json['userId'] as int,
    );
  }

  @override
  List<Object?> get props => [
        communityId,
        communityName,
        workEmail,
        phoneNumber,
        state,
        city,
        country,
        zipcode,
        street,
        region,
        permitType,
        status,
        userId,
      ];
}
