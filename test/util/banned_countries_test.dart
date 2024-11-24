import 'package:credit_card_number_validation/util/banned_countries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BannedCountries', () {
    test('isCountryBanned returns true for banned countries', () {
      expect(BannedCountries.isCountryBanned('North Korea'), isTrue);
      expect(BannedCountries.isCountryBanned('Iran'), isTrue);
      expect(BannedCountries.isCountryBanned('Syria'), isTrue);
      expect(BannedCountries.isCountryBanned('Cuba'), isTrue);
    });

    test('isCountryBanned returns false for non-banned countries', () {
      expect(BannedCountries.isCountryBanned('United States'), isFalse);
      expect(BannedCountries.isCountryBanned('Canada'), isFalse);
      expect(BannedCountries.isCountryBanned('Japan'), isFalse);
      expect(BannedCountries.isCountryBanned('Germany'), isFalse);
    });

    test('isCountryBanned returns false for empty country', () {
      expect(BannedCountries.isCountryBanned(''), isFalse);
    });

    test('isCountryBanned returns false for country with different casing', () {
      expect(BannedCountries.isCountryBanned('north korea'), isFalse);
    });
  });
}
