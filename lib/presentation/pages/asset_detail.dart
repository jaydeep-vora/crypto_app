import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_app/data/model/candle_stick.dart';
import 'package:crypto_app/data/model/currency.dart';
import 'package:crypto_app/helper/common/print_function.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_bloc.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_event.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetDetailPage extends StatefulWidget {
  final Currency currency;

  const AssetDetailPage({super.key, required this.currency});

  @override
  State<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  late CurrencyBloc currencybloc;

  @override
  void initState() {
    super.initState();
    currencybloc = CurrencyBloc();
    currencybloc.add(GetCandleStickDataEvent(widget.currency.symbol!, "30m"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.currency.baseAsset?.toUpperCase() ?? "-",
                style: Theme.of(context).textTheme.headline2),
            backgroundColor: Colors.transparent,
            elevation: 0),
        backgroundColor: Theme.of(context).backgroundColor,
        body: _body());
  }

  Widget _body() {
    return BlocBuilder(bloc: currencybloc, builder: (context, state) {

      printLog(state);

      if (state is LoadingCurrencyState) {
        return Center(
            child: Text("Loading...",
                style: Theme.of(context).textTheme.headline3));
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Current Price",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 20),
                Text("₹ ${widget.currency.lastPrice}",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 40)),
                const SizedBox(height: 20),
                intervalsWidget(),
                const SizedBox(height: 20),
                candleStickChart(currencybloc.latestCandleSticks),
                dataRow("Opening Price", "₹ ${widget.currency.lastPrice}"),
                dataRow("Low Price", "₹ ${widget.currency.lowPrice}"),
                dataRow("High Price", "₹ ${widget.currency.highPrice}"),
                dataRow("Volume", "${widget.currency.volume}")
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget intervalsWidget() {
    var intervals = ["1m", "15m", "30m", "2h", "1d", "1w"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: intervals
          .map((e) => InkWell(
              onTap: () {
                currencybloc.add(GetCandleStickDataEvent(widget.currency.symbol!, e));
              },
            child: Container(            
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Center(
                  child: Text(
                    e,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context).backgroundColor
                    ),
                  ),
                )),
          ))
          .toList(),
    );
  }

  Widget candleStickChart(List<CandleStick> candleSticks) {

    var data = candleSticks.map((e) => Candle(
        date: e.date,
        high: e.high.toDouble(),
        low: e.low.toDouble(),
        open: e.open.toDouble(),
        close: e.close.toDouble(),
        volume: e.volume.toDouble())).toList();

    return SizedBox(height: 300, child: Center(child: Candlesticks(candles: data)));
  }

  Widget dataRow(String title, String value) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1.0, color: Colors.white.withOpacity(0.8)))),
      padding: const EdgeInsets.only(top: 30, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white.withOpacity(0.6)),
          )),
          Text(
            value,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
