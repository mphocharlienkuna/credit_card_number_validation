// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      numeric: json['numeric'] as String?,
      alpha2: json['alpha2'] as String?,
      name: json['name'] as String?,
      currency: json['currency'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'numeric': instance.numeric,
      'alpha2': instance.alpha2,
      'name': instance.name,
      'currency': instance.currency,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
