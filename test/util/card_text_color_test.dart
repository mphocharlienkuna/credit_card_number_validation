import 'package:credit_card_number_validation/util/card_text_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardTextColors', () {
    test('getCardTextColor returns black for Mastercard and Discover', () {
      expect(CardTextColors.getCardTextColor('CardType.mastercard'),
          equals(Colors.black));
      expect(CardTextColors.getCardTextColor('CardType.discover'),
          equals(Colors.black));
    });

    test('getCardTextColor returns white for other card types', () {
      expect(CardTextColors.getCardTextColor('CardType.visa'),
          equals(Colors.white));
      expect(CardTextColors.getCardTextColor('CardType.americanExpress'),
          equals(Colors.white));
      expect(CardTextColors.getCardTextColor('CardType.otherBrand'),
          equals(Colors.white));
    });

    test('getCardTextColor returns default color for invalid card type', () {
      expect(CardTextColors.getCardTextColor('InvalidCardType'),
          equals(Colors.white)); // Default color
    });

    test('getCardTextColor returns default color for empty card type', () {
      expect(CardTextColors.getCardTextColor(''),
          equals(Colors.white)); // Default color
    });
  });
}
