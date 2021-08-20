import 'package:flutter/material.dart';
import './text_row.dart';
import 'package:provider/provider.dart';
import '../providers/detail_screen_provider.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detailDataProvider = Provider.of<DetailProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // margin: EdgeInsets.all(deviceHeight * 0.02),
        // padding: EdgeInsets.all(deviceHeight * 0.02),
        height: deviceSize.height * 0.35,
        width: double.infinity,
        // color: blackgrey,
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextRow(
                  dataType: 'OPEN',
                  value: detailDataProvider.openPrice.toString(),
                ),
                Spacer(),
                TextRow(
                  dataType: 'PREV CLOSE',
                  value: detailDataProvider.closePrice.toString(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //yet to be done
                TextRow(
                  dataType: 'HIGH',
                  value: detailDataProvider.todaysHigh.toString(),
                ),
                Spacer(),
                TextRow(
                  dataType: 'LOW',
                  value: detailDataProvider.todaysLow.toString(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextRow(
                  dataType: '52 WK HIGH',
                  value: detailDataProvider.weekHigh,
                ),
                Spacer(),
                TextRow(
                  dataType: '52 WK LOW',
                  value: detailDataProvider.weekLow,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextRow(
                  dataType: 'MKT CAP',
                  value: detailDataProvider.marketCap,
                ),
                Spacer(),
                TextRow(
                  dataType: 'CUR',
                  value: detailDataProvider.currency,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
