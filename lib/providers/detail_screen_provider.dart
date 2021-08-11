//api key ---   E4X553Q21SLS8GVG

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailProvider with ChangeNotifier {
  
  late String _exchangePlatform;
  late String _currency;
  late String _weekHigh; //52 wk high
  late String _weekLow; //52 wk low
  late String _marketCap;
  late String _assetType;
  late String _PEratio;
  late String _description;

  String get exchangePlatform {
    return _exchangePlatform;
  }
  String get currency {
    return _currency;
  }
  String get weekHigh {
    return _weekHigh;
  }
  String get weekLow {
    return _weekLow;
  }
  String get marketCap {
    return _marketCap;
  }
  String get assetType {
    return _assetType;
  }
  String get PEratio {
    return _PEratio;
  }
  String get description{
    return _description;
  }

  Future<void> getCompanyOverviewData (String companySymbol) async {
    //https://www.alphavantage.co/query?function=OVERVIEW&symbol=AMZN&apikey=E4X553Q21SLS8GVG
    

     final url = Uri.parse('https://www.alphavantage.co/query?function=OVERVIEW&symbol=$companySymbol&apikey=E4X553Q21SLS8GVG');
    final response = await http.get(url);
    // print(response.body);
    final detailData = json.decode(response.body);

    _assetType= detailData['AssetType'] ;
    _exchangePlatform=detailData['Exchange'];
    _weekLow=detailData['52WeekLow'];
    _weekHigh=detailData['52WeekHigh'];
    _PEratio =detailData['PERatio'];
    _currency =detailData['Currency'];
    _marketCap =detailData['MarketCapitalization'];
    _description=detailData['Description'];

    print('$assetType ------ $exchangePlatform------ $weekLow --------$description');

    notifyListeners();
    
  }
}
