import 'dart:async';

import 'package:credit_card_number_validation/data/models/credit_card.dart';
import 'package:flutter/material.dart';

import '../common/widgets/credit_card_detail_bottom_sheet.dart';
import '../common/widgets/credit_card_list.dart';
import '../data/bin_api.dart';
import '../data/database/credit_card_database.dart';
import '../util/constants.dart';
import 'add_credit_card_screen.dart';

class CreditCardListScreen extends StatefulWidget {
  final BinApi binApi;

  const CreditCardListScreen({
    super.key,
    required this.binApi,
  });

  @override
  State<CreditCardListScreen> createState() => _CreditCardListScreenState();
}

class _CreditCardListScreenState extends State<CreditCardListScreen> {
  late StreamSubscription<void> _subscription;
  List<CreditCard> _creditCards = [];

  @override
  void initState() {
    super.initState();
    _fetchCreditCards();
    _subscription = CreditCardDatabase.instance.changes.listen((_) {
      _fetchCreditCards();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    CreditCardDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _creditCards.isEmpty
          ? const Center(child: Text(cardNotFound))
          : ListView.builder(
              itemCount: _creditCards.length,
              itemBuilder: (context, index) {
                final creditCard = _creditCards[index];
                return GestureDetector(
                  onTap: () {
                    _showCardDetailBottomSheet(
                        context, creditCard, widget.binApi);
                  },
                  child: CreditCardList(creditCard: creditCard),
                );
              },
            ),
    );
  }

  /// Fetches all credit cards from the database and updates the state.
  Future<void> _fetchCreditCards() async {
    try {
      final creditCards = await CreditCardDatabase.instance.readAllCreditCard();
      setState(() {
        _creditCards = creditCards;
      });
    } catch (e) {
      print('Error fetching credit cards: $e');
    }
  }

  /// Displays a bottom sheet with details of the provided [creditCard].
  void _showCardDetailBottomSheet(
      BuildContext context, CreditCard creditCard, BinApi binApi) {
    _showBottomSheet(
      context,
      SizedBox(
        height: 290,
        child: CreditCardDetailBottomSheet(
          creditCard: creditCard,
          onEditPressed: () {
            Navigator.pop(context);
            _showCardScreenBottomSheet(context, creditCard, binApi);
          },
        ),
      ),
      false,
    );
  }

  /// Displays a bottom sheet containing the [AddCreditCardScreen].
  void _showCardScreenBottomSheet(
      BuildContext context, CreditCard creditCard, BinApi binApi) {
    _showBottomSheet(
      context,
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
        child: AddCreditCardScreen(
          cardNumber: creditCard.cardNumber,
          expiryDate: creditCard.expiredDate,
          cardHolderName: creditCard.cardHolder,
          binApi: binApi,
        ),
      ),
      true,
    );
  }

  /// Displays a bottom sheet with the given [content].
  void _showBottomSheet(
      BuildContext context, Widget content, bool isScrollControlled) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white,
      builder: (context) => content,
    );
  }
}
