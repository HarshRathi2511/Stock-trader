import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:stock_trader/constants.dart';
class PieChartDetail extends StatelessWidget {
  // const PieChartDetail({ Key? key }) : super(key: key);

  final List<Color> colorList;
    final Map<String,double>  marketSentimentMap ;

    PieChartDetail(this.colorList, this.marketSentimentMap);

  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = deviceSize.height;

    
    
    return ClipRRect(
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
              );
  }
}