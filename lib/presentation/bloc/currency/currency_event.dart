import 'package:equatable/equatable.dart';

abstract class CurrencyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadingCurrencyEvent extends CurrencyEvent {
  final DateTime timestamp;

  LoadingCurrencyEvent(this.timestamp);
}


class GetAllCurrencyEvent extends CurrencyEvent {
  final DateTime timestamp;

  GetAllCurrencyEvent(this.timestamp);
}

class GetCandleStickDataEvent extends CurrencyEvent {
  final String symbol;
  final String interval;

  GetCandleStickDataEvent(this.symbol, this.interval);
}