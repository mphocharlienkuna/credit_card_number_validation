import 'package:credit_card_number_validation/data/models/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../common/widgets/credit_card_display.dart';
import '../data/bin_api.dart';
import '../data/database/credit_card_database.dart';
import '../data/repository/bin_response.dart';
import '../util/banned_countries.dart';
import '../util/constants.dart';

class AddCreditCardScreen extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final BinApi binApi;

  const AddCreditCardScreen({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.binApi,
  });

  @override
  State<StatefulWidget> createState() => _AddCreditCardScreen();
}

class _AddCreditCardScreen extends State<AddCreditCardScreen> {
  String errorMessage = '';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardTypeColor = '';
  String cardType = '';
  String issuingCountry = 'South Africa';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CreditCardDisplay(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  isCvvFocused: isCvvFocused,
                  isSwipeGestureEnabled: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          cardNumberValidator: (String? cardNumber) {
                            return null;
                          },
                          inputConfiguration: const InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              labelText: cardNumberLabel,
                              hintText: cardNumberHint,
                              border: OutlineInputBorder(),
                            ),
                            expiryDateDecoration: InputDecoration(
                              labelText: cardExpiryDateLabel,
                              hintText: cardExpiryDateHint,
                              border: OutlineInputBorder(),
                            ),
                            cvvCodeDecoration: InputDecoration(
                              labelText: cardCvvLabel,
                              hintText: cardCvvHint,
                              border: OutlineInputBorder(),
                            ),
                            cardHolderDecoration: InputDecoration(
                              labelText: cardHolderNameLabel,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: _onValidate,
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      saveButtonText,
                                      style: TextStyle(
                                        fontFamily: 'Roboto Condensed Regular',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Roboto Condensed Regular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Adds a new credit card to the database.
  ///
  /// This method orchestrates the process of adding a credit card, including:
  /// 1. Creating a [CreditCard] object using [_createCreditCard].
  /// 2. Saving the credit card to the database using
  ///    [CreditCardDatabase.instance.createCreditCard].
  /// 3. Navigating back to the previous screen using [Navigator.pop].
  ///
  /// If an error occurs during the process, the [errorMessage] state variable
  /// is updated with the error message.
  Future<void> _addCreditCard() async {
    errorMessage = '';
    final creditCard = _createCreditCard();
    try {
      await CreditCardDatabase.instance.createCreditCard(creditCard);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().split(': ').last;
      });
    }
  }

  /// Creates a new [CreditCard] object with the current form data.
  ///
  /// Returns a [CreditCard] object representing the new credit card.
  CreditCard _createCreditCard() {
    return CreditCard(
      cardNumber: cardNumber,
      cardType: cardType,
      expiredDate: expiryDate,
      cvv: cvvCode,
      cardHolder: cardHolderName,
      issuingCountry: issuingCountry,
    );
  }

  /// Fetches the BIN details for the given [bin].
  ///
  /// Returns a [BinResponse] object containing the BIN details if the fetch
  /// is successful. If an error occurs during the API call, it updates the
  /// [errorMessage] state variable with the error message and returns `null`.
  Future<BinResponse?> _fetchBinDetails(String bin) async {
    try {
      return await widget.binApi.getBinDetails(bin);
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    }
    return null;
  }

  /// Validates the credit card form and adds the credit card to the database.
  ///
  /// This method performs the following steps:
  /// 1. Validates the form using the [formKey].
  /// 2. Fetches the BIN details using the [_fetchBinDetails]method.
  /// 3. Checks if the country is banned using the [_isCountryBanned] method.
  /// 4. Adds the credit card to the database using the [_addCreditCard] method.
  void _onValidate() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final bin = cardNumber.replaceAll(' ', '').substring(0, 6);
    final binResponse = await _fetchBinDetails(bin);

    if (_isCountryBanned(binResponse)) {
      setState(() {
        errorMessage = "The country ${binResponse!.country!.name!} is banned.";
      });
      return;
    }

    await _addCreditCard();
  }

  /// Checks if the country associated with the given [binResponse] is banned.
  ///
  /// Returns `true` if the country is banned, `false` otherwise.
  bool _isCountryBanned(BinResponse? binResponse) {
    return binResponse?.country?.name != null &&
        BannedCountries.isCountryBanned(binResponse!.country!.name!);
  }

  /// Called when the credit card model changes.
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName.isEmpty
          ? 'Mpho C Nkuna'
          : creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
