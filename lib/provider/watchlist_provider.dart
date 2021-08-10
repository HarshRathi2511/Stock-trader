import 'package:flutter/material.dart';

class WatchListStock {
  String symbol;
  String title;
  double stockPrice;
  double percentageChange;
  bool didPriceIncrease;
  Icon stockIcon;

  WatchListStock({
    required this.title,
    required this.symbol,
    required this.percentageChange,
    required this.didPriceIncrease,
    required this.stockPrice,
    required this.stockIcon,
  });
}

class WatchListProvider with ChangeNotifier {
  List<Map<String, WatchListStock>> _watchList = [
    {
      't1': WatchListStock(
          didPriceIncrease: true,
          percentageChange: 3,
          stockIcon: Icon(
            Icons.apps_outlined,
            color: Colors.white,
          ),
          stockPrice: 34.46,
          symbol: 'AAPL',
          title: 'Apple Inc.')
    },
    {
      't2': WatchListStock(
          didPriceIncrease: true,
          percentageChange: 3,
          stockIcon: Icon(
            Icons.apps_outlined,
            color: Colors.white,
          ),
          stockPrice: 34.46,
          symbol: 'AAPL',
          title: 'Apple Inc.')
    },
    {
      't3': WatchListStock(
          didPriceIncrease: true,
          percentageChange: 3,
          stockIcon: Icon(
            Icons.apps_outlined,
            color: Colors.white,
          ),
          stockPrice: 34.46,
          symbol: 'AAPL',
          title: 'Apple Inc.')
    },
    {
      't4': WatchListStock(
          didPriceIncrease: true,
          percentageChange: 3,
          stockIcon: Icon(
            Icons.apps_outlined,
            color: Colors.white,
          ),
          stockPrice: 34.46,
          symbol: 'AAPL',
          title: 'Apple Inc.')
    }
  ];

  List<Map<String, WatchListStock>> get watchList {
    return [..._watchList];
  }

  int get numOfStocks {
    return _watchList.length;
  }
}
