import 'package:equatable/equatable.dart';

class CommunityModel extends Equatable {
  const CommunityModel({
    required this.name,
    required this.workEmail,
    required this.state,
    required this.street,
    required this.communityRefId,
  });

  final String name;
  final String workEmail;
  final String state;
  final String street;
  final String communityRefId;

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      name: json['communityName'] as String,
      workEmail: json['workEmail'] as String,
      state: json['state'] as String,
      street: json['street'] as String,
      communityRefId: json['communityRefId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'communityName': name,
        'workEmail': workEmail,
        'state': state,
        'street': street,
        'communityRefId': communityRefId,
      };

  @override
  List<Object?> get props => [
        name,
        workEmail,
        state,
        street,
        communityRefId,
      ];
}
