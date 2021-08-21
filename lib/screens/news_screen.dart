import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/providers/news_provider.dart';
import 'package:stock_trader/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void didChangeDependencies() async {
    final newsProvider = Provider.of<NewsProvider>(context);
    try {
      await newsProvider.getData();
      setState(() {
        isNewsLoading = false;
      });
    } catch (_) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('An error occurred!'),
              content: Text('Try again later'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
      setState(() {
        isNewsLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: isNewsLoading
            ? Container(
                height: deviceSize.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: kBlackGrey,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Latest News',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceSize.width / 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    ...newsProvider.latestHeadlines
                        .map(
                          (e) => NewsCard(
                            title: e.title,
                            description: e.description,
                            urlToImage: e.urlToImage,
                            url: e.url,
                            use: 'everything',
                          ),
                        )
                        .toList()
                  ],
                ),
              ));
  }
}
