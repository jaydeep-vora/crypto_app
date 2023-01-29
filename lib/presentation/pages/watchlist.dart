import 'package:crypto_app/data/model/currency.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_bloc.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_event.dart';
import 'package:crypto_app/presentation/bloc/currency/currency_state.dart';
import 'package:crypto_app/presentation/pages/asset_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  late CurrencyBloc currencybloc;

  @override
  void initState() {
    super.initState();
    currencybloc = CurrencyBloc();
    currencybloc.add(GetAllCurrencyEvent(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor, 
        body: _body());
  }

  Widget _body() {
    return BlocBuilder(
      builder: (context, state) {

        if (state is LoadingCurrencyState) {
          return const Center(
              child: CircularProgressIndicator());
        }

        if (currencybloc.currencies.isEmpty == true) {
          return Center(
              child: Text("No Currency Available",
                  style: Theme.of(context).textTheme.headline3));
        }

        return SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "My wishlist",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _currencyListWidget(currencybloc.currencies)),
              ],
            ),
          ),
        );
      },
      bloc: currencybloc,
    );
  }

  Widget _currencyListWidget(List<Currency> currencies) {
    return RefreshIndicator(
      onRefresh: () async {
        currencybloc.add(GetAllCurrencyEvent(DateTime.now()));
        return;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return _currencyListItemWidget(currencies[index]);
        },
      ),
    );
  }

  Widget _currencyListItemWidget(Currency currency) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AssetDetailPage(
                      currency: currency,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 62, 70, 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currency.baseAsset?.toUpperCase() ?? "-",
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 6),
                Text("Vol. ${currency.volume}",
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
            Text("₹ ${currency.lastPrice}",
                style: Theme.of(context).textTheme.headline3),
          ],
        ),
      ),
    );
  }
}
