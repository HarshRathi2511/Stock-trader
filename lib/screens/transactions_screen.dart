import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Transactions',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceHeight * 0.03),
              )),
          _buildStockListTile(),
          _buildStockListTile(),
          _buildStockListTile(),
          _buildStockListTile(),
          _buildStockListTile(),


        ],
      ),
    );
  }
}
