// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contractor _$ContractorFromJson(Map<String, dynamic> json) => Contractor(
      trade: json['trade'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zip: json['zip'] as String,
      street: json['street'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ContractorToJson(Contractor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trade': instance.trade,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'state': instance.state,
      'city': instance.city,
      'country': instance.country,
      'zip': instance.zip,
      'street': instance.street,
    };
