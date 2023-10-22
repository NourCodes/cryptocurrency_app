import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currencyOptions = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoSelection = [
  'BTC',
  'ETH',
  'LTC',
];

class Coin {
  String apikey = dotenv.env['API_KEY']!;

  Future getData(String selectedCurrency) async {
    // Create a map to store cryptocurrency prices=> LTC:2000
    Map<String, String> coinPrices = {};

    // Loop through the list of cryptocurrencies and fetch exchange rates
    for (var coin in cryptoSelection) {
      final res = await https.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=$apikey'));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        // Extract the exchange rate and store it in the map
        var ratePrice = data["rate"];
        coinPrices[coin] = ratePrice.toStringAsFixed(0);
      } else {
        throw "An Unexpected Error Occurred";
      }
    }
    return coinPrices;
  }
}
