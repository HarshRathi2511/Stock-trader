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

  Stock({
    required this.title,
    required this.symbol,
    required this.priceChange,
    required this.didPriceIncrease,
    required this.stockPrice,
  });
}

class TransactedStock {
  String symbol;
  String title;
  double stockPriceWhenBought;
  DateTime dateOfransaction;
  int quantityOfStocks;
  TransactionType transactionType;
  double? stockPriceWhenSold;

  TransactedStock({
    required this.title,
    required this.symbol,
    required this.stockPriceWhenBought,
    required this.dateOfransaction,
    required this.quantityOfStocks,
    required this.transactionType,
    this.stockPriceWhenSold,
  });
}

class PortfolioStock {
  String symbol;
  String title;
  double stockPriceAtTheMoment;
  int quantity;
  double priceChange;
  bool didPriceIncrease;

  PortfolioStock({
    required this.title,
    required this.symbol,
    required this.quantity,
    required this.priceChange,
    required this.stockPriceAtTheMoment,
    required this.didPriceIncrease,
  });
}

class StockProvider with ChangeNotifier {
  //id will be the symbol

  final inputController = TextEditingController();

  List<Stock> _stocks = [
    // Stock(
    //   title: 'Amazon',
    //   didPriceIncrease: true,
    //   priceChange: 2.09,
    //   stockPrice: 3341.87,
    //   symbol: 'AMZN',
    // ),
    // Stock(
    //   title: 'Tesla',
    //   didPriceIncrease: true,
    //   priceChange: 2.89,
    //   stockPrice: 713.76,
    //   symbol: 'TSLA',
    // ),
    // Stock(
    //   title: 'Google',
    //   didPriceIncrease: true,
    //   priceChange: 2,
    //   stockPrice: 3244,
    //   symbol: 'GOOGL',
    // )
  ];

  Map<String, Stock> _watchListStocks = {
    // 't1': Stock(
    //   title: 'Apple',
    //   didPriceIncrease: true,
    //   priceChange: 2.09,
    //   stockPrice: 3244,
    //   symbol: 'AAPL',
    // ),
    // 't2': Stock(
    //   title: 'Apple',
    //   didPriceIncrease: true,
    //   priceChange: 2.89,
    //   stockPrice: 3244,
    //   symbol: 'AAPL',
    // ),
  };

  Map<String, PortfolioStock> _portfolioStocks = {};
  Map<String, TransactedStock> _transactedListStocks = {};
  Map<String, TransactedStock> _transactionsWithProfit = {};
  Map<String, TransactedStock> _transactionsWithLoss = {};
  // Map<String, Stock> _orderedStocks = {};
  double _totalProfit = 0;
  double _totalLoss = 0;

  List<Stock> get stocks {
    return [..._stocks];
  }

  Map<String, PortfolioStock> get portfolioStocks {
    return {..._portfolioStocks};
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

  bool isSellingPossible(String symbol, int quantity) {
    if (portfolioStocks.containsKey(symbol)) {
      final stocksCount = portfolioStocks[symbol]!.quantity;
      if (stocksCount-quantity >= 0) {
        portfolioStocks.update(
          symbol,
          (value) => PortfolioStock(
            title: value.title,
            symbol: value.symbol,
            quantity: value.quantity - quantity,
            priceChange: value.priceChange,
            stockPriceAtTheMoment: value.stockPriceAtTheMoment,
            didPriceIncrease: value.didPriceIncrease,
          ),
        );
        return true;
      }
    }
    return false;
  }

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

  void addNewTransaction(
    //post request
    title,
    symbol,
    price,
    dateOfTransaction,
    quantityOfStocks,
    transactionType,
  ) {
    _transactedListStocks.putIfAbsent(
      dateOfTransaction.toString(),
      () => TransactedStock(
        title: title,
        symbol: symbol,
        stockPriceWhenBought: price,
        dateOfransaction: dateOfTransaction,
        quantityOfStocks: quantityOfStocks,
        transactionType: transactionType,
      ),
    );
    notifyListeners();
  }

  void addPortfolioStock(
      String title,
      String symbol,
      double stockPriceAtTheMoment,
      int quantity,
      bool didPriceIncrease,
      double priceChange,
      TransactionType transactionType) {
    if (_portfolioStocks.containsKey(symbol)) {
      if (transactionType == TransactionType.bought) {
        _portfolioStocks.update(
          //  patch
          symbol,
          (value) => PortfolioStock(
            title: value.title,
            symbol: value.symbol,
            quantity: value.quantity + quantity,
            priceChange: value.priceChange,
            stockPriceAtTheMoment: value.stockPriceAtTheMoment,
            didPriceIncrease: value.didPriceIncrease,
          ),
        );
      } else {
        _portfolioStocks.update(
          //patch
          symbol,
          (value) => PortfolioStock(
            title: value.title,
            symbol: value.symbol,
            quantity: value.quantity - quantity,
            priceChange: value.priceChange,
            stockPriceAtTheMoment: value.stockPriceAtTheMoment,
            didPriceIncrease: value.didPriceIncrease,
          ),
        );
      }
    } else {
      _portfolioStocks.putIfAbsent(
        //post req
        symbol,
        () => PortfolioStock(
          title: title,
          symbol: symbol,
          stockPriceAtTheMoment: stockPriceAtTheMoment,
          quantity: quantity,
          didPriceIncrease: didPriceIncrease,
          priceChange: priceChange,
        ),
      );
    }

    print("portfolio $_portfolioStocks");
    notifyListeners();
  }

  void addWatchListStock(
    //post request
    title,
    symbol,
    price,
    icon,
    didPriceIncrease,
    priceChange,
  ) {
    _watchListStocks.putIfAbsent(
      symbol,
      () => Stock(
        title: title,
        symbol: symbol,
        stockPrice: price,
        didPriceIncrease: didPriceIncrease,
        priceChange: priceChange,
      ),
    );
    notifyListeners();
  }

  void calculatetotalProfit() {
    //put request
    _totalProfit = 0;
    _transactionsWithProfit.forEach((key, value) {
      _totalProfit += value.quantityOfStocks *
          (value.stockPriceWhenSold! - value.stockPriceWhenBought);
    });
    notifyListeners();
  }

  void calculatetotalLoss() {
    //put request
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
