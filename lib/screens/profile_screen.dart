import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/providers/balance_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/widgets/profile_screen_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: deviceSize.width / 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: deviceSize.height * 0.025,
          ),
          Container(
            height: 90.0,
            width: 90.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/default profile.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: deviceSize.height * 0.02,
          ),
          Text(
            'Admin',
            style: TextStyle(
                color: Colors.white, fontSize: deviceSize.height * 0.035),
          ),
          SizedBox(
            height: deviceSize.height * 0.03,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(2),
              children: [
                ProfileScreenCard(
                  message: Text(
                    'Balance',
                    style: profilePageTextStyle,
                  ),
                  otherMessage: Text(
                    '${balanceProvider.balance} \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Total Net Profit',
                    style: profilePageTextStyle,
                  ),
                  otherMessage: Text(
                    '${stockProvider.totalProfit} \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Total Net Loss',
                    style: profilePageTextStyle,
                  ),
                  otherMessage: Text(
                    '${stockProvider.totalLoss} \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Positive Transactions',
                    style: profilePageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  otherMessage: Text(
                    stockProvider.getTransactionsWithProfit.length.toString(),
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Negative Transactions',
                    style: profilePageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  otherMessage: Text(
                    stockProvider.getTransactionsWithLoss.length.toString(),
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Privacy Policy',
                    style: profilePageTextStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'About us',
                    style: profilePageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
