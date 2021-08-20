//api key ---   E4X553Q21SLS8GVG

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailProvider with ChangeNotifier {
  String _name = '';
  String _exchangePlatform = '';
  String _currency = '';
  String _weekHigh = ''; //52 wk high
  String _weekLow = ''; //52 wk low
  String _marketCap = '';
  String _description = '';
  String _assetType = '';
  String _logoURL = '';
  double _currentPrice = 0.0;
  double _change = 0.0;
  double _percentageChange = 0.0;
  double _todaysHigh = 0.0;
  double _todaysLow = 0.0;
  double _openPrice = 0.0;
  double _closePrice = 0.0;
  var inputController = TextEditingController();
  var _searchResults = [];
  var _searchResultsCount = 0;

  String get exchangePlatform {
    return _exchangePlatform;
  }

  String get name {
    return _name;
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

  String get description {
    return _description;
  }

  String get logoUrl {
    return _logoURL;
  }

  double get currentPrice {
    return _currentPrice;
  }

  double get change {
    return _change;
  }

  double get todaysHigh {
    return _todaysHigh;
  }

  double get todaysLow {
    return _todaysLow;
  }

  double get openPrice {
    return _openPrice;
  }

  double get closePrice {
    return _closePrice;
  }

  double get percentageChange {
    return _percentageChange;
  }

  int get searchResultsCount {
    return _searchResultsCount;
  }

  List get searchResults {
    return _searchResults;
  }

  Future<void> getSearchSuggestions(keyword) async {
    final url = Uri.parse(
        'https://finnhub.io/api/v1/search?q=$keyword&token=c4d3br2ad3icnt8r8g9g');
    var response = await http.get(url);
    final result = json.decode(response.body);
    _searchResults = [];
    for (var res in result["result"]) {
      if (res["symbol"].indexOf('.') == -1) {
        _searchResults
            .add({'symbol': res["symbol"], 'name': res["description"]});
        print(_searchResults[0].values.toList());
      }
    }
    _searchResultsCount = _searchResults.length;
    notifyListeners();
  }

  Future<void> getCurrentCompanyPrice(symbol) async {
    final url = Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=$symbol&token=c4d3br2ad3icnt8r8g9g');
    final response = await http.get(url);
    Map<String, dynamic> data = new Map<String, dynamic>.from(
      json.decode(response.body),
    );

    final profileUrl = Uri.parse(
        'https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=c4d3br2ad3icnt8r8g9g');
    final profileResponse = await http.get(profileUrl);

    final details = json.decode(profileResponse.body);

    print("Change ${data["d"]}");

    _logoURL = details["logo"];
    _exchangePlatform = details['exchange'];
    _currency = details['currency'];
    _marketCap = details['marketCapitalization'].toString();
    _name = details["name"];
    _currentPrice = double.parse(data["c"].toString());
    _change = double.parse(data["d"].toString());
    _todaysHigh = double.parse(data["h"].toString());
    _todaysLow = double.parse(data["l"].toString());
    _openPrice = double.parse(data["o"].toString());
    _closePrice = double.parse(data["pc"].toString());

    notifyListeners();
  }

  Future<void> getCompanyOverviewData(String companySymbol) async {
    //https://www.alphavantage.co/query?function=OVERVIEW&symbol=AMZN&apikey=E4X553Q21SLS8GVG

    final url = Uri.parse(
        'https://finnhub.io/api/v1/stock/metric?symbol=$companySymbol&metric=all&token=c4d3br2ad3icnt8r8g9g');
    final response = await http.get(url);
    // print(response.body);
    final detailData = json.decode(response.body);
    print("detailed data $detailData");
    _weekLow = detailData["metric"]['52WeekLow'].toString();
    _weekHigh = detailData["metric"]['52WeekHigh'].toString();

    notifyListeners();
  }
}
