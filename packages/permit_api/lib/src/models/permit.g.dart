// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permit _$PermitFromJson(Map<String, dynamic> json) => Permit(
      notes: json['notes'] as String,
      applicant: json['applicant'] == null
          ? null
          : Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
      contractor: json['contractor'] == null
          ? null
          : Contractor.fromJson(json['contractor'] as Map<String, dynamic>),
      construction: json['construction'] == null
          ? null
          : Construction.fromJson(json['construction'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PermitToJson(Permit instance) => <String, dynamic>{
      'id': instance.id,
      'applicant': instance.applicant,
      'contractor': instance.contractor,
      'construction': instance.construction,
      'notes': instance.notes,
    };
