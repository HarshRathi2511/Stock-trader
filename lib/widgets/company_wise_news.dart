import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/providers/news_provider.dart';
import 'package:stock_trader/widgets/news_card.dart';

class CompanyNews extends StatefulWidget {
  final String loadedStocktitle;

  CompanyNews(this.loadedStocktitle);

  @override
  _CompanyNewsState createState() => _CompanyNewsState();
}

class _CompanyNewsState extends State<CompanyNews> {
  var isLoading = true;

  @override
  void initState() {
    Future<void> newsData() async {
      await Provider.of<NewsProvider>(context, listen: false)
          .getStockNewsByQuery(widget.loadedStocktitle);
      setState(() {
        isLoading = false;
      });
    }

    newsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Column(
      children: newsProvider.companyWiseNews
          .map(
            (e) => NewsCard(
              title: e.title,
              description: e.description,
              urlToImage: e.urlToImage,
              url: e.url,
              use: 'companyWise',
            ),
          )
          .toList(),
    );
  }
}
