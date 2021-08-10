import 'package:provider/provider.dart';
import 'package:stock_trader/providers/stocks.dart';
import 'package:stock_trader/screens/stock_detail_screen.dart';
import 'package:stock_trader/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
       ChangeNotifierProvider(
         create: (ctx)=>Stocks(),
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
          home: TabsScreen(),
          routes: {
            StockDetailScreen.routeName :(ctx) => StockDetailScreen(),
          },
          ),
    );
  }
}
