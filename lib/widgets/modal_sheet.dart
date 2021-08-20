import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_provider.dart';
import '../constants.dart';
import '../providers/stock.dart';

class ModalSheet extends StatefulWidget {
  late final String stockSymbol;
  ModalSheet({required this.stockSymbol});
  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  Widget build(BuildContext context) {
    final detailDataProvider = Provider.of<DetailProvider>(context);
    final stocksData = Provider.of<StockProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    final quantityController = TextEditingController();
    late final int quantityOfStocks;
    return SingleChildScrollView(
      child: Container(
        // height: deviceSize.height * 0.5,
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.stockSymbol,
                    style: TextStyle(
                      fontSize: deviceSize.height * 0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Text(' ')),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: deviceSize.height * 0.03, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Quantity', style: kmodalSheet),
                  Text('Current Price', style: kmodalSheet),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: deviceSize.height * 0.001,
                horizontal: deviceSize.width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: deviceSize.height * 0.05,
                    width: deviceSize.width * 0.25,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                    )),
                    child: TextField(
                      cursorColor: Colors.black87,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '    quantity',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // enabledBorder: InputBorder.,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,

                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceSize.width / 26,
                        ),
                      ),
                      onSubmitted: (_) {
                        setState(() {
                          quantityOfStocks = int.parse(quantityController.text);
                        });
                      },
                    ),
                  ),
                  Chip(
                    label: Text(
                      '\$' + detailDataProvider.currentPrice.toString(),
                      style: TextStyle(
                          fontSize: deviceSize.height * 0.03,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    shadowColor: Colors.green[200],
                    elevation: 7,
                    padding: EdgeInsets.all(8),
                    backgroundColor: Colors.blueGrey[900],
                  ),
                ],
              ),
            ),

            //Find a null safe package to implement slide to buy and slide to sell feature

            ElevatedButton(
              onPressed: () {
                stocksData.addNewTransaction(
                  detailDataProvider.name,
                  widget.stockSymbol,
                  detailDataProvider.currentPrice,
                  DateTime.now(),
                  quantityOfStocks,
                  TransactionType.bought,
                );
                stocksData.addPortfolioStock(
                  detailDataProvider.name,
                  widget.stockSymbol,
                  detailDataProvider.currentPrice,
                  quantityOfStocks,
                  true,
                  3.2,
                  TransactionType.bought,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Stocks bought',
                    ),
                    duration: Duration(
                      milliseconds: 800,
                    ),
                  ),
                );
              },
              child: Text(
                'BUY',
                style: profilePageDataStyle,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                stocksData.addNewTransaction(
                  detailDataProvider.name,
                  widget.stockSymbol,
                  detailDataProvider.currentPrice,
                  DateTime.now(),
                  quantityOfStocks,
                  TransactionType.sold,
                );
                stocksData.addPortfolioStock(
                  detailDataProvider.name,
                  widget.stockSymbol,
                  detailDataProvider.currentPrice,
                  quantityOfStocks,
                  true,
                  3.2,
                  TransactionType.sold,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Stocks sold',
                    ),
                    duration: Duration(
                      milliseconds: 800,
                    ),
                  ),
                );
              },
              child: Text(
                'SELL',
                style: profilePageDataStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
