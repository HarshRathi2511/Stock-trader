import 'package:flutter/material.dart';
import '../screens/stock_detail_screen.dart';

class SearchCard extends StatelessWidget {
  late final String symbol;
  late final String title;

  SearchCard({
    required this.title,
    required this.symbol,
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
              width: 15,
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
                  LimitedBox(
                    maxWidth: deviceSize.width*0.75,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
