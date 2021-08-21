import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_provider.dart';
import './text_row.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final detailDataProvider = Provider.of<DetailProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // margin: EdgeInsets.all(deviceHeight * 0.02),
        // padding: EdgeInsets.all(deviceHeight * 0.02),
        height: deviceSize.height * 0.5,
        width: double.infinity,
        // color: blackgrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextRow(
              dataType: 'OPEN',
              value: detailDataProvider.openPrice.toString(),
            ),
            TextRow(
              dataType: 'PREV CLOSE',
              value: detailDataProvider.closePrice.toString(),
            ),
            TextRow(
              dataType: 'HIGH',
              value: detailDataProvider.todaysHigh.toString(),
            ),
            TextRow(
              dataType: 'LOW',
              value: detailDataProvider.todaysLow.toString(),
            ),
            TextRow(
              dataType: '52 WK HIGH',
              value: detailDataProvider.weekHigh,
            ),
            TextRow(
              dataType: '52 WK LOW',
              value: detailDataProvider.weekLow,
            ),
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
      ),
    );
  }
}
