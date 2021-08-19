import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:stock_trader/widgets/stock_card.dart';
import 'package:stock_trader/providers/stock.dart';
import './search_screen.dart';

class WatchlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final stockProvider = Provider.of<StockProvider>(context);
    final detailedDataProvider = Provider.of<DetailProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: Text(
                'Watchlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceSize.width / 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kBlackGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  size: deviceSize.width / 20,
                  color: Colors.white54,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(context, SearchScreen.routeName);
                      },
                    child: TextField(
                      // focusNode: FocusNode(),
                      // enableInteractiveSelection: false,
                      enabled: false,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search Stock',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceSize.width / 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          stockProvider.watchListStockCount == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceSize.height * 0.1,
                    ),
                    Text(
                      "Your watchlist is empty!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 26,
                      ),
                    ),
                    Text(
                      "Add stocks to track them here.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 26,
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView(
                    children: stockProvider.watchListStocks.values
                        .toList()
                        .map(
                          (e) => StockCard(
                            title: e.title,
                            symbol: e.symbol,
                            priceChange: e.priceChange,
                            didPriceIncrease: e.didPriceIncrease,
                            stockPrice: e.stockPrice,
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
