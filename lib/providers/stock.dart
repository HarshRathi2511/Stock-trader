import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TransactionType { sold, bought }
enum StockType { transacted, portfolio, watchlist }

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
  double stockPriceWhenBought;
  Icon stockIcon;
  DateTime dateOfransaction;
  int quantityOfStocks;
  TransactionType transactionType;
  double? stockPriceWhenSold;

  TransactedStock({
    required this.title,
    required this.symbol,
    required this.stockPriceWhenBought,
    required this.stockIcon,
    required this.dateOfransaction,
    required this.quantityOfStocks,
    required this.transactionType,
    this.stockPriceWhenSold,
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
        size: 40,
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
        size: 40,
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
        size: 40,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    ),
    't4': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2.09,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 35,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    ),
    't5': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2.89,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 35,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    ),
    't6': Stock(
      title: 'Apple Inc',
      didPriceIncrease: true,
      priceChange: 2,
      stockIcon: Icon(
        Icons.access_alarm_outlined,
        color: Colors.white,
        size: 35,
      ),
      stockPrice: 3244,
      symbol: 'AAPL',
    )
  };
  Map<String, TransactedStock> _transactedListStocks = {};
  Map<String, TransactedStock> _transactionsWithProfit = {};
  Map<String, TransactedStock> _transactionsWithLoss = {};
  // Map<String, Stock> _orderedStocks = {};
  double _totalProfit = 0;
  double _totalLoss = 0;

  Map<String, PortfolioStock> get portfolioStocks {
    return _portfolioStocks;
  }

  Map<String, Stock> get watchListStocks {
    return {..._watchListStocks};
  }

  Map<String, TransactedStock> get transactedListStocks {
    return {..._transactedListStocks};
  }

  Map<String, TransactedStock> get getTransactionsWithProfit {
    return {..._transactionsWithProfit};
  }

  Map<String, TransactedStock> get getTransactionsWithLoss {
    return {..._transactionsWithLoss};
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

  double get totalProfit {
    return _totalProfit;
  }

  double get totalLoss {
    return _totalLoss;
  }

  // int get ordersListStockCount {
  //   return _orderedStocks.length;
  // }

  void transactionsWithProfit() {
    _transactedListStocks.forEach((key, value) {
      if (value.transactionType == TransactionType.sold) {
        if (value.stockPriceWhenBought - value.stockPriceWhenSold! < 0) {
          _transactionsWithProfit.putIfAbsent(
            value.dateOfransaction.toString(),
            () => TransactedStock(
              title: value.title,
              symbol: value.symbol,
              stockPriceWhenBought: value.stockPriceWhenBought,
              stockIcon: value.stockIcon,
              dateOfransaction: value.dateOfransaction,
              quantityOfStocks: value.quantityOfStocks,
              transactionType: value.transactionType,
            ),
          );
        }
      }
    });
    notifyListeners();
  }

  void transactionsWithLoss() {
    _transactedListStocks.forEach((key, value) {
      if (value.transactionType == TransactionType.sold) {
        if (value.stockPriceWhenBought - value.stockPriceWhenSold! > 0) {
          _transactionsWithLoss.putIfAbsent(
            value.dateOfransaction.toString(),
            () => TransactedStock(
              title: value.title,
              symbol: value.symbol,
              stockPriceWhenBought: value.stockPriceWhenBought,
              stockIcon: value.stockIcon,
              dateOfransaction: value.dateOfransaction,
              quantityOfStocks: value.quantityOfStocks,
              transactionType: value.transactionType,
            ),
          );
        }
      }
    });
    notifyListeners();
  }

  void addNewStock(stock, type) {
    if (type == StockType.transacted) {
      _transactedListStocks.putIfAbsent(
          stock.dateOfransaction.toString(),
          () => TransactedStock(
                title: stock.title,
                symbol: stock.symbol,
                stockPriceWhenBought: stock.stockPriceWhenBought,
                stockIcon: stock.stockIcon,
                dateOfransaction: stock.dateOfransaction,
                quantityOfStocks: stock.quantityOfStocks,
                transactionType: stock.transactionType,
              ));
    } else if (type == StockType.portfolio) {
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

    notifyListeners();
  }

  void calculatetotalProfit() {
    _totalProfit = 0;
    _transactionsWithProfit.forEach((key, value) {
      _totalProfit += value.quantityOfStocks *
          (value.stockPriceWhenSold! - value.stockPriceWhenBought);
    });
    notifyListeners();
  }

  void calculatetotalLoss() {
    _totalLoss = 0;
    _transactionsWithProfit.forEach((key, value) {
      _totalLoss += value.quantityOfStocks *
          (value.stockPriceWhenBought - value.stockPriceWhenSold!);
    });
    notifyListeners();
  }

  Future<void> newUserData() async {
    var url = Uri.parse(
        "https://stock-trader-3e6f6-default-rtdb.firebaseio.com/admin.json");
    var res = await http.post(url,
        body: json.encode({
          watchListStocks: _watchListStocks,
          portfolioStocks: _portfolioStocks,
          transactedListStocks: _transactedListStocks,
        }));
    print(res);
  }

  Future<void> updateUserData(type) async {
    if (type == StockType.watchlist) {
      var url = Uri.parse(
          "https://stock-trader-3e6f6-default-rtdb.firebaseio.com/admin.json");
      var res = await http.patch(url,
          body: json.encode({
            watchListStocks: _watchListStocks,
          }));
      print(json.decode(res.body));
    } else if (type == StockType.portfolio) {
      var url = Uri.parse(
          "https://stock-trader-3e6f6-default-rtdb.firebaseio.com/admin.json");
      var res = await http.patch(url,
          body: json.encode({
            portfolioStocks: _portfolioStocks,
          }));
      print(json.decode(res.body));
    } else {
      var url = Uri.parse(
          "https://stock-trader-3e6f6-default-rtdb.firebaseio.com/admin.json");
      var res = await http.patch(url,
          body: json.encode({
            transactedListStocks: _transactedListStocks,
          }));
      print(json.decode(res.body));
    }
  }

  Future<void> getUserData() async {
    var url = Uri.parse(
        "https://stock-trader-3e6f6-default-rtdb.firebaseio.com/admin.json");
    var res = await http.get(url);
    print(json.decode(res.body));
    notifyListeners();
  }
}