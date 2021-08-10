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
    final deviceSize = MediaQuery.of(context).size;
    print("News Card");
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            width: double.infinity,
            height: deviceSize.height * 0.125,
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
                  child: Image.network(
                    urlToImage,
                    fit: BoxFit.fill,
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
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      LimitedBox(
                        // flex: 4,
                        maxWidth: deviceSize.width * 0.55,
                        maxHeight: deviceSize.height * 0.125 * 0.9,
                        child: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
