import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/widgets/company_wise_news.dart';
import 'package:stock_trader/widgets/detail_screen_chart_widget.dart';
import 'package:stock_trader/widgets/pie_chart_detail.dart';
import 'package:stock_trader/widgets/text_row.dart';

class StockDetailScreen extends StatefulWidget {
  static const routeName = '/stock-detail';

  @override
  _StockDetailScreenState createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  var isLoading = true;

  @override
  void didChangeDependencies() async {
    
      await Provider.of<DetailProvider>(context, listen: false)
          .getCompanyOverviewData('AMZN');
      await Provider.of<DetailProvider>(context, listen: false)
          .getCurrentCompanyPrice('AMZN');
      setState(() {
        isLoading = false;
      });
    // } catch (_) {
    //   print(_);
    //   showDialog(
    //       context: context,
    //       builder: (_) {
    //         return AlertDialog(
    //           title: Text('An error occurred!'),
    //           content: Text('Try again later'),
    //           actions: [
    //             TextButton(
    //               onPressed: () => Navigator.pop(context, 'OK'),
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         );
    //       });
      // setState(() {
      //   isLoading = false;
      // });
  // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final stocksData = Provider.of<StockProvider>(context, listen: false);
    final quantityController = TextEditingController();
    final detailDataProvider = Provider.of<DetailProvider>(context);

    late final int quantityOfStocks;
    final marketSentimentMap = {'Market Sentiment': 78.8, '': 100 - 78.8};

    final List<Color> colorList = [
      Colors.green,
      blackgrey,
    ];

    // final ordersData = Provider.of<Orders>(context, listen: false);

    final route = ModalRoute.of(context);
    // This will NEVER fail
    if (route == null) return SizedBox.shrink();
    final String loadedStockSymbol = route.settings.arguments as String;

    final loadedStock = stocksData.stocks
        .firstWhere((share) => share.symbol == loadedStockSymbol);

    print(loadedStock.symbol);

    final title = loadedStock.title;
    final symbol = loadedStock.symbol;
    final stockPrice = loadedStock.stockPrice;

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
                              quantityOfStocks =
                                  int.parse(quantityController.text);
                            });
                          },
                        ),
                      ),
                      Chip(
                        label: Text(
                          '\$' + loadedStock.stockPrice.toString(),
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
                      title,
                      symbol,
                      stockPrice,
                      DateTime.now(),
                      quantityOfStocks,
                      TransactionType.bought,
                    );
                    stocksData.addPortfolioStock(
                      title,
                      symbol,
                      stockPrice,
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
                      title,
                      symbol,
                      stockPrice,
                      DateTime.now(),
                      quantityOfStocks,
                      TransactionType.sold,
                    );
                    stocksData.addPortfolioStock(
                      title,
                      symbol,
                      stockPrice,
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
        ),
      );
    }

    return Scaffold(
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                _showModalSheet(context);
              },
              label: const Text(
                'Trade',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.compare_arrows_rounded,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kBlackGrey,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  loadedStock.symbol,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  loadedStock.title,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: deviceSize.width / 22.22,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.05,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        // margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kBlackGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: deviceSize.width / 6,
                        height: deviceSize.width / 6,
                        child: Container(
                          child: Image.network(
                            "https://logo.clearbit.com/${loadedStock.title}.com",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.05,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          '${detailDataProvider.change}',
                          style: TextStyle(
                            color: kGreen,
                            fontSize: deviceSize.width / 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          '${detailDataProvider.currentPrice}',
                          style: profilePageDataStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          detailDataProvider.description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: deviceSize.width / 22.22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    ChartWidgetDetail(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // margin: EdgeInsets.all(deviceHeight * 0.02),
                        // padding: EdgeInsets.all(deviceHeight * 0.02),
                        height: deviceSize.height * 0.3,
                        width: double.infinity,
                        // color: blackgrey,
                        child: Column(
                          children: [
                            Text(
                              'Stats',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextRow(
                                    dataType: 'OPEN',
                                    value: detailDataProvider.openPrice
                                        .toString()),
                                TextRow(
                                  dataType: 'PREV CLOSE',
                                  value:
                                      detailDataProvider.closePrice.toString(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //yet to be done
                                TextRow(
                                  dataType: 'HIGH',
                                  value:
                                      detailDataProvider.todaysHigh.toString(),
                                ),
                                TextRow(
                                  dataType: 'LOW',
                                  value:
                                      detailDataProvider.todaysLow.toString(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextRow(
                                  dataType: '52 WK HIGH',
                                  value: detailDataProvider.weekHigh,
                                ),
                                TextRow(
                                  dataType: '52 WK LOW',
                                  value: detailDataProvider.weekLow,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextRow(
                                  dataType: 'MKT CAP',
                                  value: detailDataProvider.marketCap,
                                ),
                                TextRow(
                                  dataType: 'CUR',
                                  value: detailDataProvider.currency,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextRow(
                                  dataType: 'P/E',
                                  value: detailDataProvider.PEratio,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    PieChartDetail(colorList, marketSentimentMap),
                    Text(
                      'Latest News',
                      style: profilePageStyle,
                    ),
                    CompanyNews(loadedStock.title),
                  ],
                ),
              ),
            ),
    );
  }
}
