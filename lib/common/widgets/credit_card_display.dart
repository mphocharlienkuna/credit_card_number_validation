import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../util/card_text_colors.dart';
import '../../util/card_type_colors.dart';

class CreditCardDisplay extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool isCvvFocused;
  final bool isSwipeGestureEnabled;

  const CreditCardDisplay({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.isCvvFocused,
    required this.isSwipeGestureEnabled,
  });

  @override
  State<CreditCardDisplay> createState() => _CreditCardDisplayWidgetState();
}

class _CreditCardDisplayWidgetState extends State<CreditCardDisplay> {
  String cardTypeColor = '';

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      enableFloatingCard: true,
      cardNumber: widget.cardNumber,
      expiryDate: widget.expiryDate,
      cardHolderName: widget.cardHolderName,
      cvvCode: widget.cvvCode,
      showBackView: widget.isCvvFocused,
      obscureCardNumber: true,
      obscureCardCvv: true,
      isHolderNameVisible: true,
      cardBgColor: CardTypeColors.getCardColor(cardTypeColor),
      textStyle: TextStyle(
        color: CardTextColors.getCardTextColor(cardTypeColor),
      ),
      isSwipeGestureEnabled: widget.isSwipeGestureEnabled,
      onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {
        if (creditCardBrand.brandName != CardType.otherBrand) {
          _onChangeCardColor(creditCardBrand);
        }
      },
      customCardTypeIcons: const <CustomCardTypeIcon>[],
    );
  }

  /// Updates the card type color based on the selected credit card brand.
  ///
  /// This method is called when the user selects a credit card brand. It updates
  /// the [cardTypeColor] state variable with the brand name of the selected
  /// credit card brand.
  ///
  /// The color update is delayed by 500 milliseconds using [Future.delayed] to
  /// provide a smooth visual transition.
  ///
  /// @param creditCardBrand The selected credit card brand.
  void _onChangeCardColor(CreditCardBrand creditCardBrand) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        cardTypeColor = "${creditCardBrand.brandName}";
      });
    });
  }
}
