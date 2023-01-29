class CandleStick {
  
  final DateTime date;

  /// The highet price during this candle lifetime
  /// It if always more than low, open and close
  final num high;

  /// The lowest price during this candle lifetime
  /// It if always less than high, open and close
  final num low;

  /// Price at the beginnig of the period
  final num open;

  /// Price at the end of the period
  final num close;

  /// Volume is the number of shares of a
  /// security traded during a given period of time.
  final num volume;

  bool get isBull => open <= close;

  CandleStick({
    required this.date,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
  });

  CandleStick.fromJson(dynamic json)
      : date = DateTime.fromMillisecondsSinceEpoch(json[0]),
        high = json[2],
        low = json[3],
        open = json[1],
        close = json[4],
        volume = json[5];
}
