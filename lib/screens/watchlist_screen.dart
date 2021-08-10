import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/widgets/watchlist_card.dart';
import './stock_detail_screen.dart';
import '../providers/stock.dart';


class WatchlistScreen extends StatelessWidget {

  final inputStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final stockProvider = Provider.of<StockProvider>(context);
    var _watchList = [];
    // watchListProvider.watchList.

    for (int i = 0; i < stockProvider.watchListStockCount; i++) {
      _watchList.add(stockProvider.watchListStocks[i].values.toList()[0]);
    }
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
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: inputStockController,
                    onSubmitted: (_) {},
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your watchlist',
            style: TextStyle(
              color: Colors.white,
              fontSize: deviceSize.width * 0.05,
            ),
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
                    children: _watchList
                        .map(
                          (e) => WatchListStockCard(
                              title: e.title,
                              symbol: e.symbol,
                              percentageChange: e.percentageChange,
                              didPriceIncrease: e.didPriceIncrease,
                              stockPrice: e.stockPrice,
                              stockIcon: e.stockIcon),
                        )
                        .toList(),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceSize.height * 0.1,
              ),
              // Text(
              //   "Your watchlist is empty!",
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: deviceSize.width / 26,
              //   ),
              // ),
              // Text(
              //   "Add stocks to track them here.",
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: deviceSize.width / 26,
              //   ),
              // ),
              
            ],
          ),
          // Container(
          //   height: deviceSize.height*0.5,
          //   child: ListView.builder(
          //     itemCount: stocksData.stocks.length,
          //     itemBuilder: (c,i){
          //       return ListTile(
          //         title: Text(stocksData.stocks[i].title,style:profilePageStyle),
          //         trailing: Text(stocksData.stocks[i].price,style:profilePageStyle),
          //         onTap: (){
          //           Navigator.of(context).pushNamed(StockDetailScreen.routeName,arguments:stocksData.stocks[i].id);
          //         },
 
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
