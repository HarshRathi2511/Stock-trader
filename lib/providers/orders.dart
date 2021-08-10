import 'package:flutter/cupertino.dart';
class OrderItem {
  final String id;
  final String title;
  final String price;
  final String symbol;
  final String quantity;

  OrderItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.symbol,
      required this.quantity});
}
class Orders with ChangeNotifier {
  
  List<OrderItem> _orders =[];

  List <OrderItem> get orderHistory {
    return [..._orders];
  } 

    
}
