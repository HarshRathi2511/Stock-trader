import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/providers/orders.dart';
import 'package:stock_trader/providers/stocks.dart';
import 'package:stock_trader/screens/stock_detail_screen.dart';
import 'package:stock_trader/providers/share.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/stock-detail';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final stocksData = Provider.of<Stocks>(context, listen: false);
    final quantityController = TextEditingController();
    String quantity = '0';

    final ordersData = Provider.of<Orders>(context, listen: false);

    final route = ModalRoute.of(context);
    // This will NEVER fail
    if (route == null) return SizedBox.shrink();
    final String routeArgId = route.settings.arguments as String;

    final loadedStock =
        stocksData.stocks.firstWhere((share) => share.id == routeArgId);

    void _showModalSheet(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (bctx) => SingleChildScrollView(
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
                  color: Colors.greenAccent[400],
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(right: deviceSize.width * 0.7, top: 20,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loadedStock.symbol,
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.04,
                            color: Colors.black),
                      ),
                      // Icon(Icons.signal_cellular_0_bar_rounded)
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
                      vertical: deviceSize.height * 0.007,
                      horizontal: deviceSize.width * 0.02),
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
                          // controller: quantityController,

                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Select quantity',
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
                          onChanged: (value) {
                            quantity = value;
                            print(quantity);
                          },
                          onSubmitted: (_) {},
                        ),
                      ),
                      Chip(
                        label: Text(
                          '\$' + loadedStock.price.toString(),
                          style: TextStyle(fontSize: deviceSize.height * 0.03),
                        ),
                        shadowColor: Colors.green[200],
                        elevation: 7,
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ),

                //Find a null safe package to implement slide to buy and slide to sell feature

                ElevatedButton(
                    onPressed: () {
                      //buy order
                      ordersData.buyOrder(
                          id: loadedStock.id,
                          title: loadedStock.title,
                          totalAmount: (double.parse(loadedStock.price) *
                                  int.parse(quantity))
                              .toString(),
                          price: loadedStock.price,
                          quantity: quantity);

                      print((double.parse(loadedStock.price) *
                              int.parse(quantity))
                          .toString());

                      //implement changes in portfolio,net balance , and the transactions screen
                    },
                    child: Text(
                      'BUY',
                      style: profilePageDataStyle,
                    )),

                ElevatedButton(
                    onPressed: () {
                      //sell order
                      ordersData.sellOrder(
                          id: loadedStock.id,
                          title: loadedStock.title,
                          totalAmount: (double.parse(loadedStock.price) *
                                  int.parse(quantity))
                              .toString(),
                          price: loadedStock.price,
                          quantity: quantity);

                      print((double.parse(loadedStock.price) *
                              int.parse(quantity))
                          .toString());

                      //implement changes in portfolio,net balance , and the transactions screen
                    },
                    child: Text(
                      'SELL',
                      style: profilePageDataStyle,
                    )),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               Container(
              child: Center(
                child: Text(
                  loadedStock.title,
                  style: profilePageDataStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
              
              SizedBox(
                height: deviceSize.height * 0.1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: deviceSize.height * 0.1,
        width: deviceSize.width * 0.3,
        child: FloatingActionButton(
          onPressed: () {
            _showModalSheet(context);
          },
          child: Text('Trade'),
          elevation: 5,
          focusColor: Colors.lightGreenAccent,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
