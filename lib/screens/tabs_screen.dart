import 'package:stock_trader/screens/movers_screen.dart';
import 'package:stock_trader/screens/portfolio_screen.dart';
import 'package:stock_trader/screens/profile_screen.dart';
import 'package:stock_trader/screens/transactions_screen.dart';
import 'package:stock_trader/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabsScreen extends StatefulWidget {
  // const TabsScreen({ Key? key }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var changeTabScreen = [
    WatchlistScreen(),
    MoversScreen(),
    PortfolioScreen(),
    TransactionScreen(),
    ProfileScreen(),
  ];

  var _page = 0; //shows current page number

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(
            bottom: deviceSize.height * 0.01,
            left: deviceSize.width * 0.02,
            right: deviceSize.width * 0.02,
          ),
          child: GNav(
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(
                color: Colors.black,
                width: 1.5,
              ), // tab button border
              tabBorder: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              activeColor: Colors.red,
              color: Colors.red, // tab button border
              duration: Duration(milliseconds: 400), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              iconSize: 24, // tab button icon size
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                GButton(
                  icon: Icons.favorite_outline,
                  text: 'Likes',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                GButton(
                  icon: Icons.add_moderator_sharp,
                  text: 'Profile',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              ]),
        ),
        body: changeTabScreen[_page],
      ),
    );
  }
}
