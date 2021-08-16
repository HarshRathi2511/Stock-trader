import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/screens/stock_detail_screen.dart';

class StockCard extends StatelessWidget {
  late final String symbol;
  late final String title;
  late final double stockPrice;
  late final double priceChange;
  late final bool didPriceIncrease;
  late final Icon stockIcon;

  StockCard({
    required this.title,
    required this.symbol,
    required this.priceChange,
    required this.didPriceIncrease,
    required this.stockPrice,
    required this.stockIcon,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, StockDetailScreen.routeName,
            arguments: 'AMZN');
      },
      child: Container(
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
              child: stockIcon,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    stockPrice.toString(),
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
      ),
    );
  }
}
