import 'package:flutter/material.dart';
import 'package:stock_trader/providers/stock.dart';
import '../constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TransactionCard extends StatelessWidget {
  late final String title;
  late final String symbol;
  late final TransactionType type;
  late final int quantity;

  TransactionCard({
    required this.symbol,
    required this.title,
    required this.type,
    required this.quantity,
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
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                '${type == TransactionType.sold ? 'SOLD' : 'BOUGHT'}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width / 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'x $quantity',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: deviceSize.width / 25,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
