import 'package:credit_card_number_validation/screens/add_credit_card_screen.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/bin_api.dart';
import '../util/constants.dart';
import 'credit_card_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BinApi api;

  /// Options for customizing the credit card scanning behavior.
  CardScanOptions scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    api = BinApi(dio);
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: currentBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: CreditCardListScreen(binApi: api)),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16.0, top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: FilledButton(
                        onPressed: () {
                          _showCardScreenBottomSheet(context, '', '', '', api);
                        },
                        style: buttonStyle,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            addCardButtonText,
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed Regular',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: FilledButton(
                        onPressed: _scanAndShowCardDetails,
                        style: buttonStyle,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            scanCardButtonText,
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed Regular',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Scans a credit card using the device's camera.
  Future<CardDetails?> scanCard() async {
    try {
      final CardDetails? cardDetails =
          await CardScanner.scanCard(scanOptions: scanOptions);
      if (!mounted || cardDetails == null) return null;

      return cardDetails;
    } catch (e) {
      return null;
    }
  }

  /// Scans a credit card and displays its details in a bottom sheet.
  Future<void> _scanAndShowCardDetails() async {
    final cardDetails = await scanCard();
    if (mounted) {
      if (cardDetails != null) {
        _showCardScreenBottomSheet(context, cardDetails.cardNumber,
            cardDetails.expiryDate, cardDetails.cardHolderName, api);
      } else {
        showToast(context, scanFailed);
      }
    }
  }

  /// The style for the "Add Card" and "Scan Card" buttons.
  final buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

/// Displays a bottom sheet containing the [AddCreditCardScreen].
void _showCardScreenBottomSheet(BuildContext context, String cardNumber,
    String expiryDate, String cardHolderName, BinApi binApi) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
      child: AddCreditCardScreen(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        binApi: binApi,
      ),
    ),
  );
}

/// Displays a toast message with the given [message] in the provided [context].
void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
