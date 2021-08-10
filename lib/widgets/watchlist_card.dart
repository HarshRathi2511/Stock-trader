import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

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
        height: 80,
        margin: EdgeInsets.all(10),
        color: kBlackGrey,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: [
                stockIcon,
                Center(
                  child: Column(children: [
                    Text(
                      symbol,
                      style: profilePageStyle,
                    ),
                    Text(
                      title,
                      style: profilePageStyle,
                    ),
                  ]),
                ),
              ]),
            ),
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
