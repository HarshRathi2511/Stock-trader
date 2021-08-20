import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/widgets/company_wise_news.dart';
import 'package:stock_trader/widgets/stats..dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/modal_sheet.dart';

class StockDetailScreen extends StatefulWidget {
  static const routeName = '/stock-detail';

  @override
  _StockDetailScreenState createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  var isLoading = true;
  Future<void> getData() async {
    try {
      await Provider.of<DetailProvider>(context, listen: false)
          .getCompanyOverviewData('AMZN');
      await Provider.of<DetailProvider>(context, listen: false)
          .getCurrentCompanyPrice('AMZN');
      setState(() {
        isLoading = false;
      });
    } catch (_) {
      print(_);
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('An error occurred!'),
              content: Text('Try again later'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
    }
  }

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

    return Scaffold(
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (bctx) => ModalSheet(
                          stockSymbol: stockSymbol,
                        ));

                print('modal sheet ');
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
