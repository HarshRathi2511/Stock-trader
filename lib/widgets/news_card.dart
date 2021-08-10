import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

class NewsCard extends StatelessWidget {
  late final String title;
  late final String description;
  late final String urlToImage;

  NewsCard({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  @override
  Widget build(BuildContext context) {
    print("News Card");
    return ListTile(
      title: Text(
        title,
        style: profilePageStyle,
      ),
      tileColor: kBlackGrey,
    );
  }
}
