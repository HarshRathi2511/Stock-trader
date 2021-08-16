// import 'package:flutter/material.dart';
// import 'package:stock_trader/constants.dart';
// import 'package:stock_trader/providers/stock.dart';
// import 'package:stock_trader/screens/tabs_screen.dart';
// import 'package:provider/provider.dart';

// class TitleScreen extends StatefulWidget {
//   @override
//   _TitleScreenState createState() => _TitleScreenState();
// }

// class _TitleScreenState extends State<TitleScreen> {
//   @override
//   void didChangeDependencies() {
//     Future<void> data() async {
//       final stockProvider = Provider.of<StockProvider>(context);
//       await stockProvider.getUserData();
//       setState(() {
//         firstTimeLoading = false;
//         Navigator.pushNamed(context, TabsScreen.routeName);
//       });
//     }

//     data();
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Column(
//         children: [
//           SizedBox(
//             height: deviceSize.height * 0.2,
//           ),
//           Text(
//             'Stock Trader',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 36,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'One place for all your stock market needs',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child:
//                   firstTimeLoading ? CircularProgressIndicator() : TabsScreen(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
