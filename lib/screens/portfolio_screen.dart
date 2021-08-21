import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/widgets/portfolio_card.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
Map<String,double> ?dataMap;
  @override
  void initState() {
   Provider.of<StockProvider>(context,listen:false).fetchAndSetPortfolioStocks();
   Map<String,double> dataMap =Provider.of<StockProvider>(context).pData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    // Map<String, double> dataMap = {
    //   "Reliance": 5,
    //   "Amazon": 3,
    //   "Siemens": 2,
    //   "Blue Origin": 2,
    // };
    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];

    var deviceSize;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'My portfolio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceWidth / 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceHeight * 0.22,
                  width: deviceWidth * 0.9,
                  color: blackgrey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Invested Amount',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: deviceHeight * 0.02),
                              ),
                              Text(
                                '\$ 24.265',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceHeight * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Current Value',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: deviceHeight * 0.02),
                              ),
                              Text(
                                '\$ 24.265',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceHeight * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.035,
                      ),
                      //show chip depending on profit/loss
                      Chip(
                        label: Text(
                          '+  \$ 5.65',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                      //  Chip(label: Text('-  \$ 5.65',style: TextStyle(fontSize: 25),),backgroundColor: Colors.red ,)
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceHeight * 0.3,
                  width: deviceWidth * 0.9,
                  color: blackgrey,
                  child: PieChart(
                    dataMap: dataMap!,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 32,
                    centerText: "HYBRID",
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceHeight * 0.5,
                  width: deviceWidth * 0.9,
                  color: blackgrey,
                  child: LineGraph(
                    features: [
                      Feature(
                          data: [0.3, 0.6, 0.8, 0.9, 1.2],
                          color: Colors.lightGreen,
                          title: 'Portfolio wealth'),
                    ],
                    size: Size(deviceWidth * 0.7, deviceHeight * 0.4),
                    labelX: ['MON', 'TUE', 'WED', 'TH', 'FRI'],
                    labelY: [
                      '\$3456',
                      '\$4456',
                      '\$5456',
                      '\$1456',
                      '\$8456',
                    ],
                    showDescription: true,
                    graphColor: Colors.white,
                  ),
                ),
              ),
              Text(
                'Stocks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceWidth / 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              stockProvider.portfolioStockCount == 0
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
                  : Column(
                      children: stockProvider.portfolioStocks.values
                          .toList()
                          .map((e) => PortfolioCard(
                                title: e.title,
                                symbol: e.symbol,
                                quantity: e.quantity,
                                priceChange: e.priceChange,
                                stockPriceAtTheMoment: e.stockPriceAtTheMoment,
                                didPriceIncrease: e.didPriceIncrease,
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
