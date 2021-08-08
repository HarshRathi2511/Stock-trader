import 'package:stock_trader/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
            primaryColor: Colors.white, //Color(0xFF17242D),
            // accentColor: Color(0xFF17242D),
            fontFamily: 'Lato',
            // scaffoldBackgroundColor: Color(0xFF17242D),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.red,
            )),
      home: TabsScreen()
      
    );
  }
}


