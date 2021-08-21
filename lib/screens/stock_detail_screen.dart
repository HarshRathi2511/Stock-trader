import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/providers/balance_provider.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/widgets/company_wise_news.dart';
import 'package:stock_trader/widgets/stats_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StockDetailScreen extends StatefulWidget {
  static const routeName = '/stock-detail';

  @override
  _StockDetailScreenState createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  var isLoading = true;
  var stockSymbol;

  @override
  void didChangeDependencies() async {
    stockSymbol = ModalRoute.of(context)!.settings.arguments as String;
    await Provider.of<DetailProvider>(context, listen: false)
        .getCompanyOverviewData(stockSymbol);
    await Provider.of<DetailProvider>(context, listen: false)
        .getCurrentCompanyPrice(stockSymbol);
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final stocksData = Provider.of<StockProvider>(context, listen: false);
    final detailDataProvider = Provider.of<DetailProvider>(context);
    final quantityController = TextEditingController();
    final balanceProvider = Provider.of<BalanceProvider>(context);
    late final int quantityOfStocks;

    void _showModalSheet(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (bctx) => SingleChildScrollView(
          child: Container(
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
                        stockSymbol,
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
                              quantityOfStocks =
                                  int.parse(quantityController.text);
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
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          'Are you sure ?',
                        ),
                        content: Text(
                          'Do you want to proceed and buy $quantityOfStocks stocks?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (balanceProvider.isBuyingPossible(
                                detailDataProvider.currentPrice,
                                quantityOfStocks,
                              )) {
                                stocksData.addNewTransaction(
                                  detailDataProvider.name,
                                  stockSymbol,
                                  detailDataProvider.currentPrice,
                                  DateTime.now(),
                                  quantityOfStocks,
                                  TransactionType.bought,
                                );
                                stocksData.addPortfolioStock(
                                  detailDataProvider.name,
                                  stockSymbol,
                                  detailDataProvider.currentPrice,
                                  quantityOfStocks,
                                  true,
                                  3.2,
                                  TransactionType.bought,
                                );
                                Navigator.of(context).pop();
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
                              } else {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Transaction failed'),
                                    content: Text(
                                      "You don't have enough balance",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Yes',
                              textAlign: TextAlign.end,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
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
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          'Are you sure ?',
                        ),
                        content: Text(
                          'Do you want to proceed and sell $quantityOfStocks stocks?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (stocksData.isSellingPossible(
                                  stockSymbol, quantityOfStocks)) {
                                stocksData.addNewTransaction(
                                  detailDataProvider.name,
                                  stockSymbol,
                                  detailDataProvider.currentPrice,
                                  DateTime.now(),
                                  quantityOfStocks,
                                  TransactionType.sold,
                                );
                                stocksData.addPortfolioStock(
                                  detailDataProvider.name,
                                  stockSymbol,
                                  detailDataProvider.currentPrice,
                                  quantityOfStocks,
                                  true,
                                  3.2,
                                  TransactionType.sold,
                                );
                                Navigator.of(context).pop();
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
                              }else{
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Transaction failed'),
                                    content: Text(
                                      "You don't have $quantityOfStocks available for selling",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
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
                                  stockSymbol,
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
                                  detailDataProvider.name,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: deviceSize.width / 6,
                        height: deviceSize.width / 6,
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: detailDataProvider.logoUrl,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/stock_icon.png',
                              fit: BoxFit.fill,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/stock_icon.png',
                              fit: BoxFit.fill,
                            ),
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
                          '${detailDataProvider.change.toString()[0] == '-' ? detailDataProvider.change : '+${detailDataProvider.change}'}',
                          style: TextStyle(
                            color:
                                detailDataProvider.change.toString()[0] == "-"
                                    ? kRed
                                    : kGreen,
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
                    ElevatedButton(
                      onPressed: () {
                        stocksData.addWatchListStock(
                          detailDataProvider.name,
                          stockSymbol,
                          detailDataProvider.currentPrice,
                          detailDataProvider.logoUrl,
                          detailDataProvider.change.toString()[0] == '-'
                              ? false
                              : true,
                          detailDataProvider.change,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added to Watchlist',
                            ),
                            duration: Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Add to WatchList',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceSize.width / 22.22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // ChartWidgetDetail(),
                    SizedBox(
                      height: 20,
                    ),
                    // PieChartDetail(colorList, marketSentimentMap),
                    StatsCard(),
                    Text(
                      'Latest News',
                      style: profilePageStyle,
                    ),
                    CompanyNews(detailDataProvider.name),
                  ],
                ),
              ),
            ),
    );
  }
}
