import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:rxdart/transformers.dart';

//trying to make a on boarding screen for new users 

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);

  static const routeName = 'onboarding-screen';

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    int _slideIndex = 0;

    final List<String> images = [];
    final List<String> textUp = [];
    final List<String> textDown = [];

    return Scaffold(
      backgroundColor: blackgrey,
      body: Text('jhcvjcv'),
    );
  }
}
