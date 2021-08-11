import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

class ChartWidgetDetail extends StatelessWidget {
  const ChartWidgetDetail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = deviceSize.height;
    return   ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Container(
                  margin: EdgeInsets.all(deviceHeight * 0.02),
                  padding: EdgeInsets.all(deviceHeight * 0.02),
                  height: deviceSize.height * 0.6,
                  width: double.infinity,
                  color: blackgrey,
                  child: Text('chart here', style: profilePageStyle),
                ),
              );
  }
}