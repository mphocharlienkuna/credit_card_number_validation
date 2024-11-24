import 'package:flutter/material.dart';

import '../../data/models/credit_card.dart';
import '../../util/constants.dart';

class CreditCardDetailBottomSheet extends StatefulWidget {
  final CreditCard creditCard;
  final VoidCallback onEditPressed;

  const CreditCardDetailBottomSheet({
    super.key,
    required this.creditCard,
    required this.onEditPressed,
  });

  @override
  State<CreditCardDetailBottomSheet> createState() =>
      _CreditCardDetailBottomSheetState();
}

class _CreditCardDetailBottomSheetState
    extends State<CreditCardDetailBottomSheet> {
  static const TextStyle _detailTextStyle = TextStyle(
    fontFamily: 'Roboto Condensed Regular',
    fontSize: 14,
  );

  static const TextStyle _detailLabelStyle = TextStyle(
    fontFamily: 'Roboto Condensed Regular',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle _buttonTextStyle = TextStyle(
    fontFamily: 'Roboto Condensed Regular',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(
                textAlign: TextAlign.center,
                creditCardInfoTitle,
                style: TextStyle(
                  fontFamily: 'Roboto Condensed Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            _buildDetailRow(
                creditCardNumberLabel, widget.creditCard.cardNumber),
            _buildDetailRow(expiryDateLabel, widget.creditCard.expiredDate),
            _buildDetailRow(cvvLabel, widget.creditCard.cvv),
            _buildDetailRow(
                issuingCountryLabel, widget.creditCard.issuingCountry),
            _buildDetailRow(cardHolderLabel, widget.creditCard.cardHolder),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 4.0, right: 4.0),
                child: FilledButton(
                  onPressed: widget.onEditPressed,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      editCardButtonText,
                      style: _buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(label, style: _detailLabelStyle),
          Text(value, style: _detailTextStyle),
        ],
      ),
    );
  }
}
