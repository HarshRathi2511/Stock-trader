import 'package:flutter/material.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:provider/provider.dart';
import '../widgets/transaction_card.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

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
                'Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceWidth / 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          stockProvider.transactedListStockCount == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                        Text(
                          "Your portfolio list is empty!",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: deviceWidth / 26,
                          ),
                        ),
                        Text(
                          "Buy stocks to track them here.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: deviceWidth / 26,
                          ),
                        ),
                      ],
                    )
                  :
          Expanded(
            child: ListView(
              children: stockProvider.transactedListStocks.values
                  .toList()
                  .map(
                    (e) => TransactionCard(
                      title: e.title,
                      symbol: e.symbol,
                      stockIcon: e.stockIcon,
                      type: e.transactionType,
                      quantity: e.quantityOfStocks,
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
