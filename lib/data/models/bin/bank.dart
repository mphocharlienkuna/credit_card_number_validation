import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

/// Represents a bank.
@JsonSerializable()
class Bank {
  /// The name of the bank.
  final String? name;

  /// The URL of the bank's website.
  final String? url;

  /// The phone number of the bank.
  final String? phone;

  /// The city where the bank is located.
  final String? city;

  /// Creates a new [Bank] instance.
  Bank({this.name, this.url, this.phone, this.city});

  /// Creates a new [Bank] instance from a JSON map.
  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  /// Converts this [Bank] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BankToJson(this);
}
