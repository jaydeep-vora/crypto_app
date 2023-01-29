import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_app/data/model/candle_stick.dart';
import 'package:crypto_app/data/model/currency.dart';
import 'package:crypto_app/domain/usecase/currency_usecase.dart';
import 'package:crypto_app/helper/common/print_function.dart';
import 'package:crypto_app/helper/network/network_helper.dart';

class CurrencyRepository extends CurrencyUseCase {

  final NetworkHelper _helper  = NetworkHelper();

  @override
  Future<List<Currency>> getAllCurrency() async {

    final response = await _helper.get("tickers/24hr");

    printLog(response);
    
    List<Currency> currencies = [];
    if (response != null && response is List) {
      for (var item in response) {
        currencies.add(Currency.fromJson(item));
      }
    }
    return currencies;
  }

  @override
  Future<List<CandleStick>> getCandleStickData(String symbol, String interval) async {

    final response = await _helper.get("klines", parameter: {"symbol" : symbol, "interval": interval}, );

    printLog(response);
    
    List<CandleStick> candleSticks = [];
    if (response != null && response is List) {
      for (var item in response) {
        candleSticks.add(CandleStick.fromJson(item));
      }
    }
    return candleSticks;
  }
}