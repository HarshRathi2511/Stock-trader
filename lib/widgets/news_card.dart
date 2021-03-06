import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';
import 'package:stock_trader/screens/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  late final String title;
  late final String description;
  late final String urlToImage;
  late final String url;
  late final String use;

  NewsCard({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.use,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NewsDetailScreen.routeName,
              arguments: [url, use]);
        },
        child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            width: double.infinity,
            height: deviceSize.height * 0.15,
            decoration: BoxDecoration(
              color: kBlackGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.zero,
                  ),
                  child: Container(
                    width: deviceSize.width * 0.35,
                    height: deviceSize.height * 0.2,
                    child: Image.network(
                      urlToImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LimitedBox(
                        maxWidth: deviceSize.width * 0.50,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: deviceSize.width / 25,

                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
