import 'package:stock_trader/screens/news_screen.dart';
import 'package:stock_trader/screens/portfolio_screen.dart';
import 'package:stock_trader/screens/profile_screen.dart';
import 'package:stock_trader/screens/transactions_screen.dart';
import 'package:stock_trader/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabsScreen extends StatefulWidget {
  // const TabsScreen({ Key? key }) : super(key: key);      

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var changeTabScreen = [
    WatchlistScreen(),
    // MoversScreen(),
    PortfolioScreen(),
    TransactionScreen(),
    ProfileScreen(),
  ];

  var _page = 0; //shows current page number

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var changeTabScreen = [
      WatchlistScreen(),
      PortfolioScreen(),
      NewsScreen(),
      TransactionScreen(),
      ProfileScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          height: deviceSize.height * 0.09,
          child: GNav(
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            activeColor: Colors.white,
            color: Colors.white, // tab button border
            duration: Duration(milliseconds: 400), // tab animation duration
            gap: 1, // the tab button gap between icon and text
            iconSize: deviceSize.width / 20, // tab button icon size
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ), // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.access_time_filled,
                // text: 'WatchList',
                textStyle: TextStyle(
                  fontSize: deviceSize.width / 26.5,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.pie_chart,
                // text: 'Portfolio',
                textStyle: TextStyle(
                  fontSize: deviceSize.width / 26,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.analytics,
                // text: 'News',
                textStyle: TextStyle(
                  fontSize: deviceSize.width / 26,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.compare_arrows_rounded,
                // text: 'Trades',
                textStyle: TextStyle(
                  fontSize: deviceSize.width / 26,
                  color: Colors.white,
                ),
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                // text: 'Profile',
                textStyle: TextStyle(
                  fontSize: deviceSize.width / 26,
                  color: Colors.white,
                ),
              ),
            ],
            onTabChange: (value) {
              setState(() {

                _page= value;
              });
              


            },
          ),
        ),
        body: changeTabScreen[_page],
      ),
    );
  }
}
