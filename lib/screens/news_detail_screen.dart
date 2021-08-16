import 'package:flutter/material.dart';
import 'package:stock_trader/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:link_text/link_text.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/newsDetails';
  launchURLApp(headlineURl) async {
    print(1);
    final url = headlineURl;
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    final headline = Provider.of<NewsProvider>(context).getNewsByUrl(args[0], args[1]);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: deviceSize.height * 0.4,
              child: Image.network(
                headline!.urlToImage,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headline.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headline.content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: deviceSize.height * 0.075,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "For complete story, follow the below link",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LinkText(
              headline.url,
              linkStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
              // You can optionally handle link tap event by yourself
              onLinkTap: (url) => launchURLApp(headline.url),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              headline.sourceName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            )
          ],
        ),
      ),
    );
  }
}
