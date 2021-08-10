import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
    final deviceHeight = deviceSize.height;
    final stocksData = Provider.of<Stocks>(context, listen: false);
    final quantityController = TextEditingController();
    String quantity = '0';
    final marketSentimentMap = {'Market Sentiment': 78.8, '': 100 - 78.8};
    final List<Color> colorList = [
      Colors.green,
      blackgrey,
    ];

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
                  // padding: EdgeInsets.only(
                  //     right: deviceSize.width * 0.4, top: 20, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loadedStock.symbol,
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.04,
                            color: Colors.black),
                      ),
                      Expanded(child: Text(' ')),
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
                      vertical: deviceSize.height * 0.001,
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

    Widget _buildTextRow(String dataType, String value) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              dataType,
              style: TextStyle(fontSize: 15, color: Colors.white60),
            ),
            SizedBox(
              width: deviceSize.width * 0.02,
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ],
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
                height: deviceSize.height * 0.03,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceSize.height * 0.6,
                  width: double.infinity,
                  color: blackgrey,
                  child: Text('chart here', style: profilePageStyle),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceSize.height * 0.3,
                  width: double.infinity,
                  color: blackgrey,
                  child: Column(
                    children: [
                      Text(
                        'Stats',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextRow('OPEN', '1323.05'),
                          _buildTextRow('PREV CLOSE', '1323.05'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextRow('HIGH', '1323.05'),
                          _buildTextRow('LOW', '1323.05'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextRow('52 WK HIGH', '1323.05'),
                          _buildTextRow('52 WK LOW', '1323.05'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextRow('MKT CAP', '1323.05'),
                          _buildTextRow('VOL', '1323.05'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTextRow('CAP TYPE', '1323.05'),
                          _buildTextRow('P/E', '1323.05'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceSize.height * 0.3,
                  width: double.infinity,
                  color: blackgrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Market Sentiment',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      Center(
                        child: PieChart(
                          dataMap: marketSentimentMap,
                          chartType: ChartType.ring,
                          chartRadius: deviceSize.width / 3.2,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      //display different text like bullish bearish depending on %
                      Text(
                        'Bullish',
                        style: TextStyle(
                            fontSize: deviceSize.height * 0.03,
                            color: Colors.lightBlue[200]),
                      )
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceSize.height * 0.9,
                  width: double.infinity,
                  color: blackgrey,
                  child: Text(
                    'company wise news api here',
                    style: profilePageStyle,
                  ),
                ),
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
