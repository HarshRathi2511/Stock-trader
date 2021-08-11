import 'package:flutter/material.dart';

class Stock {
  String symbol;
  String title;
  double stockPrice;
  double priceChange;
  bool didPriceIncrease;
  Icon stockIcon;

  Stock({
    required this.title,
    required this.symbol,
    required this.priceChange,
    required this.didPriceIncrease,
    required this.stockPrice,
    required this.stockIcon,
  });
}

class TransactedStock {
  String symbol;
  String title;
  double stockPrice;
  Icon stockIcon;
  DateTime dateOfransaction;
  int quantityOfStocks;
  bool didProfitOccur;

  TransactedStock({
    required this.title,
    required this.symbol,
    required this.stockPrice,
    required this.stockIcon,
    required this.dateOfransaction,
    required this.quantityOfStocks,
    required this.didProfitOccur,
  });
}

class PortfolioStock {
  String symbol;
  String title;
  double stockPrice;
  Icon stockIcon;
  int quantity;
  double priceChange;
  bool didPriceIncrease;

  PortfolioStock({
    required this.title,
    required this.symbol,
    required this.quantity,
    required this.priceChange,
    required this.stockPrice,
    required this.stockIcon,
    required this.didPriceIncrease,
  });
}

class StockProvider with ChangeNotifier {
  //id will be the symbol
  Map<String, PortfolioStock> _portfolioStocks = {};
  Map<String, Stock> _watchListStocks = {
    't1': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2.09,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 30,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    ),
    't2': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2.89,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 30,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    ),
    't3': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 30,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    )
  };
  Map<String, TransactedStock> _transactedListStocks = {};
  Map<String, TransactedStock> _transactionsWithProfit = {};
  Map<String, TransactedStock> _transactionsWithLoss = {};
  // Map<String, Stock> _orderedStocks = {};

  Map<String, PortfolioStock> get portfolioStocks {
    return _portfolioStocks;
  }

  Map<String, Stock> get watchListStocks {
    return {..._watchListStocks};
  }

  Map<String, TransactedStock> get transactedListStocks {
    return {..._transactedListStocks};
  }

  // Map<String, Stock> get orderedStocks {
  //   return {..._orderedStocks};
  // }

  int get watchListStockCount {
    return _watchListStocks.length;
  }

  int get portfolioStockCount {
    return _portfolioStocks.length;
  }

  int get transactedListStockCount {
    return _transactedListStocks.length;
  }

  // int get ordersListStockCount {
  //   return _orderedStocks.length;
  // }

  void transactionsWithProfit() {
    _transactedListStocks.forEach((key, value) {
      if (value.didProfitOccur) {
        _transactionsWithProfit.putIfAbsent(
          value.dateOfransaction.toString(),
          () => TransactedStock(
            title: value.title,
            symbol: value.symbol,
            stockPrice: value.stockPrice,
            stockIcon: value.stockIcon,
            dateOfransaction: value.dateOfransaction,
            quantityOfStocks: value.quantityOfStocks,
            didProfitOccur: value.didProfitOccur,
          ),
        );
      }
    });
    notifyListeners();
  }

  void transactionsWithLoss() {
    _transactedListStocks.forEach((key, value) {
      if (!value.didProfitOccur) {
        _transactionsWithLoss.putIfAbsent(
          value.dateOfransaction.toString(),
          () => TransactedStock(
            title: value.title,
            symbol: value.symbol,
            stockPrice: value.stockPrice,
            stockIcon: value.stockIcon,
            dateOfransaction: value.dateOfransaction,
            quantityOfStocks: value.quantityOfStocks,
            didProfitOccur: value.didProfitOccur,
          ),
        );
      }
    });
    notifyListeners();
  }

  void addNewTransaction(stock, type) {
    if (type == 'TransactedStock') {
      _transactedListStocks.putIfAbsent(
          stock.dateOfransaction.toString(),
          () => TransactedStock(
              title: stock.title,
              symbol: stock.symbol,
              stockPrice: stock.stockPrice,
              stockIcon: stock.stockIcon,
              dateOfransaction: stock.dateOfransaction,
              quantityOfStocks: stock.quantityOfStocks,
              didProfitOccur: stock.didProfitOccur));
    } else if (type == 'PortfolioStock') {
      _portfolioStocks.putIfAbsent(
          stock.dateOfransaction.toString(),
          () => PortfolioStock(
                title: stock.title,
                symbol: stock.symbol,
                stockPrice: stock.stockPrice,
                stockIcon: stock.stockIcon,
                quantity: stock.quantityOfStocks,
                didPriceIncrease: stock.didPriceIncrease,
                priceChange: stock.priceChange,
              ));
    } else {
      _watchListStocks.putIfAbsent(
          stock.dateOfransaction.toString(),
          () => Stock(
                title: stock.title,
                symbol: stock.symbol,
                stockPrice: stock.stockPrice,
                stockIcon: stock.stockIcon,
                didPriceIncrease: stock.didPriceIncrease,
                priceChange: stock.priceChange,
              ));
    }
  }
}
