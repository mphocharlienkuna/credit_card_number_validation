import 'package:credit_card_number_validation/data/repository/bin_response.dart';
import 'package:dio/dio.dart';

/// A class for interacting with the Bin list.net API.
class BinApi {
  /// The Dio client used to make HTTP requests.
  final Dio _dio;

  ///Creates a new [BinApi] instance.
  BinApi(this._dio);

  /// Gets the details of a credit card based on its BIN (Bank Identification Number).
  ///
  /// [bin] The BIN of the credit card.
  ///
  /// Returns a [BinResponse] object containing the credit card details.
  Future<BinResponse> getBinDetails(String bin) async {
    final response = await _dio.get('https://lookup.binlist.net/$bin');
    return BinResponse.fromJson(response.data);
  }
}
