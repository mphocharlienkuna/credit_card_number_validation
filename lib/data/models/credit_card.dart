import 'package:flutter/foundation.dart' show immutable;

/// The name of the credit card table in the database.
const String creditCardTable = 'credit_card';

/// An immutable representation of a credit card.
@immutable
class CreditCard {
  /// The unique identifier for the credit card.
  final int? id;

  /// The credit card number.
  final String cardNumber;

  /// The credit card type (e.g., Visa, MasterCard).
  final String cardType;

  /// The credit card expiry date.
  final String expiredDate;

  /// The credit card CVV code.
  final String cvv;

  /// The credit card holder's name.
  final String cardHolder;

  /// The credit card issuing country.
  final String issuingCountry;

  /// Creates a new [CreditCard] instance.
  const CreditCard({
    this.id,
    required this.cardNumber,
    required this.cardType,
    required this.expiredDate,
    required this.cvv,
    required this.cardHolder,
    required this.issuingCountry,
  });

  /// Creates a copy of this [CreditCard] with the given fields replaced.
  CreditCard copyWith({
    int? id,
    String? cardNumber,
    String? cardType,
    String? expiredDate,
    String? cvv,
    String? cardHolder,
    String? issuingCountry,
  }) =>
      CreditCard(
        id: id ?? this.id,
        cardNumber: cardNumber ?? this.cardNumber,
        cardType: cardType ?? this.cardType,
        expiredDate: expiredDate ?? this.expiredDate,
        cvv: cvv ?? this.cvv,
        cardHolder: cardHolder ?? this.cardHolder,
        issuingCountry: issuingCountry ?? this.issuingCountry,
      );

  /// Converts this [CreditCard] to a map representation.
  Map<String, dynamic> toMap() => {
        'id': id,
        'cardNumber': cardNumber,
        'cardType': cardType,
        'expiredDate': expiredDate,
        'cvv': cvv,
        'cardHolder': cardHolder,
        'issuingCountry': issuingCountry,
      };

  /// Creates a new [CreditCard] instance from a map representation.
  factory CreditCard.fromMap(Map<String, dynamic> map) => CreditCard(
        id: map['id'] as int?,
        cardNumber: map['cardNumber'] as String,
        cardType: map['cardType'] as String,
        expiredDate: map['expiredDate'] as String,
        cvv: map['cvv'] as String,
        cardHolder: map['cardHolder'] as String,
        issuingCountry: map['issuingCountry'] as String,
      );
}
