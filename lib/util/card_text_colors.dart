import 'package:flutter/material.dart';

/// A utility class for getting the text color associated with a card type.
class CardTextColors {
  /// Returns the text color associated with the given [cardType].
  ///
  /// If the [cardType] is `CardType.mastercard` or `CardType.discover`,
  /// the text color is black. Otherwise, the text color is white.
  static Color getCardTextColor(String cardType) {
    return cardType == 'CardType.mastercard' || cardType == 'CardType.discover'
        ? Colors.black
        : Colors.white;
  }
}
