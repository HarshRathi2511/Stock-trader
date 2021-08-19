import 'package:flutter/material.dart';
import 'package:stock_trader/providers/stock.dart';
import '../constants.dart';

class PortfolioCard extends StatelessWidget {
  late final String symbol;
  late final String title;
  late final double stockPriceAtTheMoment;
  late final int quantity;
  late final double priceChange;
  late final bool didPriceIncrease;

  PortfolioCard({
    required this.title,
    required this.symbol,
    required this.quantity,
    required this.priceChange,
    required this.stockPriceAtTheMoment,
    required this.didPriceIncrease,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            // margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kBlackGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            width: deviceSize.width / 6.5,
            height: deviceSize.width / 6.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                // margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kBlackGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: deviceSize.width / 7.5,
                height: deviceSize.width / 7.5,
                child: Container(
                  child: Image.network(
                    "https://logo.clearbit.com/$title.com",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      symbol,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceSize.width / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'x $quantity',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 25,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: deviceSize.width / 25,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(
              right: 5,
            ),
            child: Column(
              children: [
                Text(
                  stockPriceAtTheMoment.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width / 18.18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${didPriceIncrease ? '+' : '-'}$priceChange',
                  style: TextStyle(
                    color: didPriceIncrease ? kGreen : kRed,
                    fontWeight: FontWeight.bold,
                    fontSize: deviceSize.width / 22.22,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
