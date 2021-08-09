import 'package:flutter/material.dart';

class WatchListStockCard extends StatelessWidget {
  late final String symbol;
  late final String title;
  late final double stockPrice;
  late final double percentageChange;
  late final bool didPriceIncrease;
  late final Icon stockIcon;

  WatchListStockCard({
    required this.title,
    required this.symbol,
    required this.percentageChange,
    required this.didPriceIncrease,
    required this.stockPrice,
    required this.stockIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: [
            stockIcon,
            Column(children: [
              Text(symbol),
              Text(title),
            ]),
            Text(
              stockPrice.toString(),
              style: TextStyle(
                color: didPriceIncrease ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
