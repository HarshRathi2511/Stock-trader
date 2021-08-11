import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

class WatchListStockCard extends StatelessWidget {
  late final String symbol;
  late final String title;
  late final double stockPrice;
  late final double priceChange;
  late final bool didPriceIncrease;
  late final Icon stockIcon;

  WatchListStockCard({
    required this.title,
    required this.symbol,
    required this.priceChange,
    required this.didPriceIncrease,
    required this.stockPrice,
    required this.stockIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        15,
      ),
      child: GestureDetector(
        child: Container(
          height: 80,
          margin: EdgeInsets.all(10),
          color: kBlackGrey,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
      ),
    );
  }
}
