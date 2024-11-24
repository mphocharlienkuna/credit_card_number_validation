// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      name: json['name'] as String?,
      url: json['url'] as String?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'phone': instance.phone,
      'city': instance.city,
    };
