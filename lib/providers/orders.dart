import 'package:flutter/cupertino.dart';

class OrderItem {
  final String id;
  final String title;
  final String price;
  // final String symbol;
  final String quantity;
  final String totalAmount;

  OrderItem(
      {required this.id,
      required this.title,
      required this.price,
      // required this.symbol,
      required this.quantity,
      required this.totalAmount});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> _soldOrders = [];
  List<OrderItem> _boughtOrders = [];

  List<OrderItem> get soldOrders {
    return [..._soldOrders];
  }

  List<OrderItem> get boughtOrders {
    return [..._boughtOrders];
  }

  void sellOrder(
      {required String id,
      required String title,
      required String totalAmount,
      required String price,
      required String quantity}) {
    _soldOrders.add(OrderItem(
        id: id,
        title: title,
        totalAmount: totalAmount,
        price: price,
        quantity: quantity));

    notifyListeners();
  }

  void buyOrder(
      {required String id,
      required String title,
      required String totalAmount,
      required String price,
      required String quantity}) {
    _boughtOrders.add(OrderItem(
        id: id,
        title: title,
        totalAmount: totalAmount,
        price: price,
        quantity: quantity));

    notifyListeners();
  }
}
