import 'package:crypto_app/data/model/candle_stick.dart';
import 'package:crypto_app/data/model/currency.dart';
import 'package:crypto_app/domain/repository/currency_repository.dart';
import 'package:crypto_app/helper/common/print_function.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'currency_event.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {

  late List<Currency> currencies = [];

  late List<CandleStick> latestCandleSticks = [];

  CurrencyBloc() : super(InitialCurrencyState()) {
    on<LoadingCurrencyEvent>(
        (event, emit) => emit(LoadingCurrencyState(DateTime.now())));

    on<GetAllCurrencyEvent>(
        (event, emit) => _handleGetAllCurrencyEvent(event, emit));

    on<GetCandleStickDataEvent>((event, emit) => _handleGetCandleStickDataEvent(event, emit));
  }

  _handleGetAllCurrencyEvent(
      GetAllCurrencyEvent event, Emitter<CurrencyState> emit) async {

    emit(LoadingCurrencyState(DateTime.now()));
    var currencies = await CurrencyRepository().getAllCurrency();

    if (currencies.isEmpty) {
      emit(CurrenciesNotAvailableState());
      return;
    }
    this.currencies = currencies;
    emit(CurrencyReceivedState(currencies));
  }

  _handleGetCandleStickDataEvent(GetCandleStickDataEvent event, Emitter<CurrencyState> emit) async {
    var candleSticks = await CurrencyRepository().getCandleStickData(event.symbol, event.interval);

    if (candleSticks.isEmpty) {
      emit(CurrenciesNotAvailableState());
      return;
    }

    latestCandleSticks = candleSticks;
    printLog(candleSticks.length);
    printLog(DateTime.now());
    emit(CandleStickDataReceivedState(candleSticks, DateTime.now().millisecondsSinceEpoch));
    return;
  }
  
}
