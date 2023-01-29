class Currency {
  String? symbol;
  String? baseAsset;
  String? quoteAsset;
  String? openPrice;
  String? lowPrice;
  String? highPrice;
  String? lastPrice;
  String? volume;
  String? bidPrice;
  String? askPrice;
  int? at;

  Currency(
      {this.symbol,
      this.baseAsset,
      this.quoteAsset,
      this.openPrice,
      this.lowPrice,
      this.highPrice,
      this.lastPrice,
      this.volume,
      this.bidPrice,
      this.askPrice,
      this.at});

  Currency.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    baseAsset = json['baseAsset'];
    quoteAsset = json['quoteAsset'];
    openPrice = json['openPrice'];
    lowPrice = json['lowPrice'];
    highPrice = json['highPrice'];
    lastPrice = json['lastPrice'];
    volume = json['volume'];
    bidPrice = json['bidPrice'];
    askPrice = json['askPrice'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['baseAsset'] = baseAsset;
    data['quoteAsset'] = quoteAsset;
    data['openPrice'] = openPrice;
    data['lowPrice'] = lowPrice;
    data['highPrice'] = highPrice;
    data['lastPrice'] = lastPrice;
    data['volume'] = volume;
    data['bidPrice'] = bidPrice;
    data['askPrice'] = askPrice;
    data['at'] = at;
    return data;
  }
}