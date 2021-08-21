import 'package:flutter/material.dart';
import 'package:stock_trader/providers/stock.dart';

class BalanceProvider with ChangeNotifier {
  double _balance = 50000;

  double get balance {
    return _balance;
  }

  bool isBuyingPossible(double price, int quantity) {
    if (_balance - price * quantity >= 0) {
      updateBalance(
        price * quantity,
        TransactionType.bought,
      );
      return true;
    }
    return false;
  }

  void updateBalance(double amount, TransactionType type) {
    if (type == TransactionType.bought) {
      _balance -= amount;
    } else {
      _balance += amount;
    }
    notifyListeners();
  }
}
