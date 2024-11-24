import 'package:credit_card_number_validation/util/card_type_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardTypeColors', () {
    test('getCardColor returns correct color for each card type', () {
      expect(CardTypeColors.getCardColor('CardType.mastercard'),
          equals(const Color(0xFFFFFDE7)));
      expect(
          CardTypeColors.getCardColor('CardType.visa'), equals(Colors.black));
      expect(
          CardTypeColors.getCardColor('CardType.rupay'), equals(Colors.blue));
      expect(CardTypeColors.getCardColor('CardType.americanExpress'),
          equals(Colors.green));
      expect(CardTypeColors.getCardColor('CardType.unionPay'),
          equals(Colors.cyan));
      expect(CardTypeColors.getCardColor('CardType.discover'),
          equals(const Color(0xFFFFFDE7)));
      expect(CardTypeColors.getCardColor('CardType.elo'), equals(Colors.blue));
      expect(CardTypeColors.getCardColor('CardType.hipercard'),
          equals(const Color(0xFFDA291C)));
      expect(CardTypeColors.getCardColor('CardType.otherBrand'),
          equals(Colors.black)); // Default color
    });

    test('getCardColor returns default color for invalid card type', () {
      expect(
          CardTypeColors.getCardColor('InvalidCardType'), equals(Colors.black));
    });

    test('getCardColor returns default color for empty card type', () {
      expect(CardTypeColors.getCardColor(''),
          equals(Colors.black)); // Default color
    });
  });
}
