import 'package:provider/provider.dart';
import 'package:stock_trader/providers/auth.dart';
import 'package:stock_trader/providers/balance_provider.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:stock_trader/providers/news_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/screens/auth_screen.dart';
import 'package:stock_trader/screens/new_user_guide_screen.dart';
import 'package:stock_trader/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:stock_trader/screens/search_screen.dart';
import 'package:stock_trader/screens/tabs_screen.dart';
import 'package:stock_trader/screens/title_screen.dart';
import 'package:stock_trader/screens/stock_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

// int ?initScreen;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   initScreen = await prefs.getInt("initScreen");
//   await prefs.setInt("initScreen", 1);
//   print('initScreen ${initScreen}');
//   runApp(MyApp());
// }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth,StockProvider>(
          create: (ctx) => StockProvider('authtoken', 'user-id',{},0,0),
          update: (ctx,auth,prevStockProviderData)=>StockProvider(
             auth.tokenData,//token
             auth.userId, //userid 
             prevStockProviderData!.watchListStocks,
             prevStockProviderData.totalProfit,
             prevStockProviderData.totalLoss,
          ),
        ),
        // ChangeNotifierProvider(create: (ctx)=>StockProvider(),),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BalanceProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (c, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.white, //Color(0xFF17242D),
            // accentColor: Color(0xFF17242D),
            fontFamily: 'Raleway',
            // scaffoldBackgroundColor: Color(0xFF151A1A),
            scaffoldBackgroundColor: Colors.black87,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.red,
            ),
          ),
          // initialRoute: initScreen == 0 || initScreen == null ? NewsDetailScreen.routeName : "/",
          home:
              auth.isAuth?TabsScreen():AuthScreen(), //show diff screens on the basis whether user is authenticated or not
          routes: {
            // StockDetailScreen.routeName :(ctx) => StockDetailScreen(),
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
            // TabsScreen.routeName: (ctx) => TabsScreen(),
            StockDetailScreen.routeName: (ctx) => StockDetailScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            // NewsDetailScreen.routeName:(ctx)=>NewUserScreen()
          },
        ),
      ),
    );
  }
}
