import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/widgets/profile_screen_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
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
            child: GridView(
              padding: EdgeInsets.all(2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: deviceSize.width * 3 / deviceSize.height,
                crossAxisSpacing: 0,
                mainAxisSpacing: 5,
              ),
              children: [
                ProfileScreenCard(
                  message: Text(
                    'Total Net Profit',
                    style: profilePageStyle,
                  ),
                  otherMessage: Text(
                    '32.99 \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Total Net Loss',
                    style: profilePageStyle,
                  ),
                  otherMessage: Text(
                    '22.99 \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Positive Transactions',
                    style: profilePageStyle,
                    textAlign: TextAlign.center,
                  ),
                  otherMessage: Text(
                    '5',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Negative Transactions',
                    style: profilePageStyle,
                    textAlign: TextAlign.center,
                  ),
                  otherMessage: Text(
                    '2',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Privacy Policy',
                    style: profilePageStyle,
                  ),
                  otherMessage: Icon(
                    Icons.notes,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'About us',
                    style: profilePageStyle,
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
