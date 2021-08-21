import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/screens/stock_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StockCard extends StatelessWidget {
  late final String symbol;
  late final String title;
  late final double stockPrice;
  late final double priceChange;
  late final bool didPriceIncrease;

  StockCard({
    required this.title,
    required this.symbol,
    required this.priceChange,
    required this.didPriceIncrease,
    required this.stockPrice,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          StockDetailScreen.routeName,
          arguments: symbol,
        );
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                // margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: deviceSize.width / 7.5,
                height: deviceSize.width / 7.5,
                child: Container(
                  child: Image.asset(
                    'assets/images/stock_icon.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: deviceSize.width / 30,
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
