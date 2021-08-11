// import 'package:flutter/material.dart';
// import 'package:stock_trader/constants.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_trader/providers/stock.dart';

// class StockDetailScreen extends StatelessWidget {
//   const StockDetailScreen({Key? key}) : super(key: key);

//   static const routeName = '/stock-detail';

  


//   @override
//   Widget build(BuildContext context) {
//     final deviceSize =MediaQuery.of(context).size;
//     final stockProvider = Provider.of<StockProvider>(context, listen: false);
//     final quantityController = TextEditingController();
//      String quantity;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loadedStock.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(loadedStock.price,style: profilePageStyle,),
//             SizedBox(height: deviceSize.height*0.1,),
//             Container(
//               height: deviceSize.height*0.5,
//               child: Column(
//                 children: [
//                   Text(loadedStock.symbol,style: profilePageDataStyle,),
               
//                   TextField(
//                       cursorColor: Colors.white,
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       controller: quantityController,
                      
//                       // keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         hintText: 'Select quantity of stocks',                 
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: deviceSize.width / 26,
//                         ),
//                       ),
//                       onChanged: (value) {
//                         quantity=value;
//                         print(quantity);
//                       },
//                       onSubmitted: (_) {},
//                     ),
//                   Text('Current Price ${loadedStock.price}',style: profilePageDataStyle,),
//                   ElevatedButton(onPressed: (){
                    
//                   }, child: Text('BUY',style: profilePageDataStyle,)),
//                   ElevatedButton(onPressed: (){}, child: Text('SELL',style: profilePageDataStyle,)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
