import 'package:flutter/material.dart';

/// A utility class for getting the color associated with a card type.
class CardTypeColors {
  /// Returns the color associated with the given [cardType].
  ///
  /// If the [cardType] is not recognized, the default color is returned,
  /// which is black.
  static Color getCardColor(String cardType) {
    switch (cardType) {
      case 'CardType.mastercard':
        return const Color(0xFFFFFDE7);
      case 'CardType.visa':
        return Colors.black;
      case 'CardType.rupay':
        return Colors.blue;
      case 'CardType.americanExpress':
        return Colors.green;
      case 'CardType.unionPay':
        return Colors.cyan;
      case 'CardType.discover':
        return const Color(0xFFFFFDE7);
      case 'CardType.elo':
        return Colors.blue;
      case 'CardType.hipercard':
        return const Color(0xFFDA291C);
      default:
        return Colors.black;
    }
  }
}
