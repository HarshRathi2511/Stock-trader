import 'package:flutter/cupertino.dart';
import 'package:stock_trader/providers/share.dart';

class Stocks with ChangeNotifier {
  
  List <Share> _stocks =[
    Share(id: 's1',title: 'Amazon',symbol: 'AMZN',price: '3341.87'),
    Share(id: 's2',title: 'Tesla',symbol: 'TSLA',price: '713.76'),
    Share(id: 's3',title: 'Google',symbol: 'GOOGL',price: '2738.26'),
    Share(id: 's4',title: 'Intel',symbol: 'INTC',price: '54.05'),
  ];

  List <Share> get stocks {
    return [..._stocks];
  }

  List <Share> get watchlistedStocks {
    return _stocks.where((share) => share.isWatchlist==true).toList();
  }

  
}