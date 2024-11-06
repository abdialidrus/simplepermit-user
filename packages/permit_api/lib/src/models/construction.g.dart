// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Construction _$ConstructionFromJson(Map<String, dynamic> json) => Construction(
      state: json['state'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zip: json['zip'] as String,
      street: json['street'] as String,
      description: json['description'] as String,
      totalEstimatedCost: (json['totalEstimatedCost'] as num).toDouble(),
      permitNumber: json['permitNumber'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ConstructionToJson(Construction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'city': instance.city,
      'country': instance.country,
      'zip': instance.zip,
      'street': instance.street,
      'description': instance.description,
      'totalEstimatedCost': instance.totalEstimatedCost,
      'permitNumber': instance.permitNumber,
    };
