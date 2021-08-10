//class defining a single share
import 'package:flutter/cupertino.dart';

class Share with ChangeNotifier {
  final String title;
  final String id;
  final String price;
  final String symbol;
  bool isWatchlist;

  Share(
      {required this.title,
      required this.id,
      required this.price,
      required this.symbol,
      this.isWatchlist = false});

   void toggleWatchlist(String shareId) {

     
     if(isWatchlist==true) {
       isWatchlist=false;
     }
     else {
       isWatchlist=true;
     }

     notifyListeners();

   }   
}
