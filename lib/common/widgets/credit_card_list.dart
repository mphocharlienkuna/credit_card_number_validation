import 'package:credit_card_number_validation/data/models/credit_card.dart';
import 'package:flutter/material.dart';

import 'credit_card_display.dart';

class CreditCardList extends StatefulWidget {
  final CreditCard creditCard;

  const CreditCardList({
    super.key,
    required this.creditCard,
  });

  @override
  State<StatefulWidget> createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {
  @override
  Widget build(BuildContext context) {
    return CreditCardDisplay(
      cardNumber: widget.creditCard.cardNumber,
      expiryDate: widget.creditCard.expiredDate,
      cardHolderName: widget.creditCard.cardHolder,
      cvvCode: widget.creditCard.cvv,
      isCvvFocused: false,
      isSwipeGestureEnabled: false,
    );
  }
}
