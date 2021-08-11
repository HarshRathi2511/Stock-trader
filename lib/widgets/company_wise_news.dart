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

 var isLoading =true;

  @override
  void initState() {
    print(widget.loadedStocktitle);
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<NewsProvider>(context, listen: false)
            .getStockNewsByQuery(widget.loadedStocktitle).then((_){
              setState(() {
                isLoading=false;
                print(widget.loadedStocktitle);
              });
            }));
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceHeight = deviceSize.height;

    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Container(
        margin: EdgeInsets.all(deviceHeight * 0.02),
        padding: EdgeInsets.all(deviceHeight * 0.02),
        height: deviceSize.height * 0.9,
        width: double.infinity,
        color: blackgrey,
        child: Column(
          children: [
            Text(
              widget.loadedStocktitle,
              style: profilePageStyle,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: newsProvider.companyWiseNews.length,
            //     itemBuilder: (_, index) {
            //       return NewsCard(
            //         title: newsProvider.companyWiseNews[index].title,
            //         description: newsProvider.companyWiseNews[index].description,
            //         urlToImage: newsProvider.companyWiseNews[index].urlToImage,
            //         index: index,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
