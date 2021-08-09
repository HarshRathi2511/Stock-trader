import 'package:flutter/material.dart';

class MoversScreen extends StatelessWidget {
  const MoversScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(child: Text('page 1',style:TextStyle(color: Colors.white))),
      
    );
  }
}