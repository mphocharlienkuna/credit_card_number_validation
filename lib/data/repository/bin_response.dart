import 'package:json_annotation/json_annotation.dart';

import '../models/bin/bank.dart';
import '../models/bin/country.dart';

part 'bin_response.g.dart';

/// Represents a response from the Bin list.net API.
@JsonSerializable()
class BinResponse {
  /// The payment card scheme (e.g., "visa", "mastercard").
  final String? scheme;

  /// The payment card type (e.g., "debit", "credit").
  final String? type;

  /// The payment card brand (e.g., "Visa", "MasterCard").
  final String? brand;

  /// Whether the payment card is prepaid.
  final bool? prepaid;

  /// The country where the payment card was issued.
  final Country? country;

  /// The bank that issued the payment card.
  final Bank? bank;

  /// Creates a new [BinResponse] instance.
  BinResponse(
      {this.scheme,
      this.type,
      this.brand,
      this.prepaid,
      this.country,
      this.bank});

  /// Creates a new [BinResponse] instance from a JSON map.
  factory BinResponse.fromJson(Map<String, dynamic> json) =>
      _$BinResponseFromJson(json);

  /// Converts this [BinResponse] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BinResponseToJson(this);
}
