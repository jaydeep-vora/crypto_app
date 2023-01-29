import 'package:crypto_app/data/model/candle_stick.dart';

import '../../data/model/currency.dart';

abstract class CurrencyUseCase {

  Future<List<Currency>> getAllCurrency();

  Future<List<CandleStick>> getCandleStickData(String symbol, String interval);

}