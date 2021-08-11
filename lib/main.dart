import 'package:provider/provider.dart';
import 'package:stock_trader/providers/news_provider.dart';
import 'package:stock_trader/providers/stock.dart';
import 'package:stock_trader/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:stock_trader/screens/tabs_screen.dart';
import 'package:stock_trader/screens/title_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => StockProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
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
        home: TitleScreen(),
        routes: {
          // StockDetailScreen.routeName :(ctx) => StockDetailScreen(),
          NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          StockDetailScreen.routeName :(ctx) => StockDetailScreen(),
        },
      ),
    );
  }
}