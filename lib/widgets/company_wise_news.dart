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

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(20),
    //   child: Container(
    //     // margin: EdgeInsets.all(deviceHeight * 0.02),
    //     // padding: EdgeInsets.all(deviceHeight * 0.02),
    //     height: deviceSize.height * 0.9,
    //     width: double.infinity,
    //     // color: blackgrey,
    //     child: Expanded(
    //       child: ListView.builder(
    //         itemCount: newsProvider.companyWiseNews.length,
    //         itemBuilder: (_, index) {
    //           return NewsCard(
    //             title: newsProvider.companyWiseNews[index].title,
    //             description:
    //                 newsProvider.companyWiseNews[index].description,
    //             urlToImage: newsProvider.companyWiseNews[index].urlToImage,
    //             index: index,
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
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
