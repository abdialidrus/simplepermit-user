// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      zip: json['zip'] as String,
      street: json['street'] as String,
      id: json['id'] as String?,
      isOwner: json['isOwner'] as bool? ?? false,
      isContractor: json['isContractor'] as bool? ?? false,
      isReprensentative: json['isReprensentative'] as bool? ?? false,
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'state': instance.state,
      'city': instance.city,
      'zip': instance.zip,
      'street': instance.street,
      'isOwner': instance.isOwner,
      'isContractor': instance.isContractor,
      'isReprensentative': instance.isReprensentative,
    };
