import 'package:flutter/material.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/widgets/stock_card.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    // Widget _buildStockListTile() {
    //   return ListTile(
    //     leading: Text(
    //       'icon here',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     title:
    //         Text('AAPL', style: TextStyle(fontSize: 15, color: Colors.white)),
    //     isThreeLine: true,
    //     subtitle: Text(
    //       'Apple Inc.',
    //       style: TextStyle(
    //         color: Colors.grey[400],
    //         fontSize: 15,
    //       ),
    //     ),
    //     trailing: Text('+ \$31.87',
    //         style: TextStyle(fontSize: 15, color: Colors.white)),
    //   );
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Transactions',
            style: TextStyle(
              color: Colors.white,
              fontSize: deviceWidth / 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
                  child: ListView(
                    children: stockProvider.watchListStocks.values.toList()
                        .map(
                          (e) => StockCard(
                              title: e.title,
                              symbol: e.symbol,
                              priceChange: e.priceChange,
                              didPriceIncrease: e.didPriceIncrease,
                              stockPrice: e.stockPrice,
                              stockIcon: e.stockIcon),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
