import 'package:flutter/material.dart';

class Stock {
  String symbol;
  String title;
  double stockPrice;
  double percentageChange;
  bool didPriceIncrease;
  Icon stockIcon;
  int? stockQuantityIfOrdered;

  Stock(
      {required this.title,
      required this.symbol,
      required this.percentageChange,
      required this.didPriceIncrease,
      required this.stockPrice,
      required this.stockIcon,
      this.stockQuantityIfOrdered});
}

class StockProvider with ChangeNotifier {
  //id will be the symbol
  List<Map<String, Stock>> _portfolioStocks = [];
  List<Map<String, Stock>> _watchListStocks = [];
  List<Map<String, Stock>> _transactedListStocks = [];
  List<Map<String, Stock>> _orderedStocks = [];

  List<Map<String, Stock>> get portfolioStocks {
    return [..._portfolioStocks];
  }

  List<Map<String, Stock>> get watchListStocks {
    return [..._watchListStocks];
  }

  List<Map<String, Stock>> get transactedListStocks {
    return [..._transactedListStocks];
  }

  List<Map<String, Stock>> get orderedStocks {
    return [..._orderedStocks];
  }

  int get watchListStockCount {
    return _watchListStocks.length;
  }

  int get portfolioStockCount {
    return _portfolioStocks.length;
  }

  int get transactedListStockCount {
    return _transactedListStocks.length;
  }

  int get ordersListStockCount {
    return _orderedStocks.length;
  }
}
