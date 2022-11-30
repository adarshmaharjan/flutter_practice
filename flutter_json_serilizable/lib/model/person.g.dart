// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      creditCardNumber: json['creditCardNumber'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'creditCardNumber': instance.creditCardNumber,
      'birthday': instance.birthday.toIso8601String(),
    };
