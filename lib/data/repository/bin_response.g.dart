// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinResponse _$BinResponseFromJson(Map<String, dynamic> json) => BinResponse(
      scheme: json['scheme'] as String?,
      type: json['type'] as String?,
      brand: json['brand'] as String?,
      prepaid: json['prepaid'] as bool?,
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      bank: json['bank'] == null
          ? null
          : Bank.fromJson(json['bank'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BinResponseToJson(BinResponse instance) =>
    <String, dynamic>{
      'scheme': instance.scheme,
      'type': instance.type,
      'brand': instance.brand,
      'prepaid': instance.prepaid,
      'country': instance.country,
      'bank': instance.bank,
    };
