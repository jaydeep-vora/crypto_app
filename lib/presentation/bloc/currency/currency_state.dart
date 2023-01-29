import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_app/data/model/candle_stick.dart';
import 'package:crypto_app/data/model/currency.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialCurrencyState extends CurrencyState {}

class LoadingCurrencyState extends CurrencyState {
  final DateTime timestamp;

  LoadingCurrencyState(this.timestamp);
}

class CurrencyReceivedState extends CurrencyState {
  final List<Currency> currencies;

  CurrencyReceivedState(this.currencies);
}

class CandleStickDataReceivedState extends CurrencyState {
  final List<CandleStick> candleSticks;
  final int timestamp;

  CandleStickDataReceivedState(this.candleSticks, this.timestamp);

  @override
  List<Object?> get props => [candleSticks, timestamp];
}

class CurrenciesNotAvailableState extends CurrencyState {}