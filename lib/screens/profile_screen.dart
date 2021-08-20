import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/providers/auth.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                    color: Colors.white, fontSize: deviceSize.height * 0.035),
              ),
              //will add button in a better place later
              RaisedButton(
                  onPressed: () async {
                    bool isLogOut = await showDialog(
                        context: context,
                        builder: (bctx) => AlertDialog(
                              content: Text('Do you want to log out ?'),
                              actions: [
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('YES',style: TextStyle(color: Colors.white),),
                                  color: blackgrey,
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('NO',style: TextStyle(color: Colors.white),),
                                  color: blackgrey,
                                ),
                              ],
                            ));
                    isLogOut
                        ? Provider.of<Auth>(context, listen: false).logout()
                        : print('harsh');
                  },
                  child: Text('LOG OUT',style: profilePageStyle,),
                  color: blackgrey,
                  elevation: 8,
                  ),
            ],
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
                    '${stockProvider.totalProfit} \$',
                    style: profilePageDataStyle,
                  ),
                ),
                ProfileScreenCard(
                  message: Text(
                    'Total Net Loss',
                    style: profilePageStyle,
                  ),
                  otherMessage: Text(
                    '${stockProvider.totalLoss} \$',
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
                    stockProvider.getTransactionsWithProfit.length.toString(),
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
                    stockProvider.getTransactionsWithLoss.length.toString(),
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
