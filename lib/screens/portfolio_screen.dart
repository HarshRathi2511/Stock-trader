import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
// import 'package:pie_chart/pie_chart.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    Map<String, double> pieChartDataMap = {
      "Reliance": 5,
      "Amazon": 3,
      "Siemens": 2,
      "Blue Origin": 2,
    };

    Widget _buildStockListTile() {
      return ListTile(
        leading: Text(
          'icon here',
          style: TextStyle(color: Colors.white),
        ),
        title:
            Text('AAPL', style: TextStyle(fontSize: 15, color: Colors.white)),
        isThreeLine: true,
        subtitle: Text(
          'Apple Inc.',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
        ),
        trailing: Text('+ \$31.87',
            style: TextStyle(fontSize: 15, color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'My portfolio',
                    style: TextStyle(
                        color: Colors.white, fontSize: deviceHeight * 0.03),
                  )),
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
                                    fontSize: deviceHeight * 0.04),
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
                                    fontSize: deviceHeight * 0.04),
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
                          style: TextStyle(fontSize: 25),
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
                  // child: PieChart(
                  //   dataMap: dataMap,
                  //   animationDuration: Duration(milliseconds: 800),
                  //   chartLegendSpacing: 32,
                  //   chartRadius: MediaQuery.of(context).size.width / 3.2,
                  //   colorList: colorList,
                  //   initialAngleInDegree: 0,
                  //   chartType: ChartType.ring,
                  //   ringStrokeWidth: 32,
                  //   centerText: "HYBRID",
                  //   legendOptions: LegendOptions(
                  //     showLegendsInRow: false,
                  //     legendPosition: LegendPosition.right,
                  //     showLegends: true,
                  //     legendShape: _BoxShape.circle,
                  //     legendTextStyle: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   chartValuesOptions: ChartValuesOptions(
                  //     showChartValueBackground: true,
                  //     showChartValues: true,
                  //     showChartValuesInPercentage: false,
                  //     showChartValuesOutside: false,
                  //     decimalPlaces: 1,
                  //   ),
                  // ),
                  child: Center(
                      child: Text('pie chart here ',
                          style: TextStyle(color: Colors.white))),
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
                  child: Center(
                      child: Text('line graph here of portfolio wealth vs time',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
              Text('Stocks',
                  style: TextStyle(
                      color: Colors.white, fontSize: deviceHeight * 0.03),
                  textAlign: TextAlign.left),

              _buildStockListTile(),
              _buildStockListTile(),
              _buildStockListTile(),

            ],
          ),
        ),
      ),
    );
  }
}
