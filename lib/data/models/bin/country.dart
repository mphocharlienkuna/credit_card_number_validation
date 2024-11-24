import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

/// Represents a country.
@JsonSerializable()
class Country {
  /// The numeric code of the country.
  final String? numeric;

  /// The alpha-2 code of the country/**/.
  final String? alpha2;

  /// The name of the country.
  final String? name;

  /// The currency of the country.
  final String? currency;

  /// The latitude of the country.
  final double? latitude;

  /// The longitude of the country.
  final double? longitude;

  /// Creates a new [Country] instance.
  Country(
      {this.numeric,
      this.alpha2,
      this.name,
      this.currency,
      this.latitude,
      this.longitude});

  /// Creates a new [Country] instance from a JSON map.
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  /// Converts this [Country] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
