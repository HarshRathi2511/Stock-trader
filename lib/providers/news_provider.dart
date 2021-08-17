import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News {
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  String sourceName;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  });
}

class NewsProvider with ChangeNotifier {
  // API KEY: 9417487a30c2456e90da08fd903d5487
  List<News> _latestHeadlines = [];
  List<News> _companyWiseNews = [];
  int _length = 0;

  List<News> get latestHeadlines {
    return _latestHeadlines;
  }

  List<News> get companyWiseNews {
    return _companyWiseNews;
  }

  int get length {
    return _length;
  }

  //general market news
  Future<void> getData() async {
    final link = Uri.parse(
        "https://finnhub.io/api/v1/news?category=general&token=c4dlgpqad3icnt8rkag0");

    final response = await http.get(link);
    final res = json.decode(response.body);

    // print(res);

    for (var news in res) {
      if (news['headline'] != null &&
          news['related'] != null &&
          news['url'] != null &&
          news['image'] != null &&
          news['datetime'] != null &&
          news['summary'] != null &&
          news['source'] != null) {
        _length++;
        _latestHeadlines.add(
          News(
            title: news['headline'],
            description: news['related'],
            url: news['url'],
            urlToImage: news['image'],
            publishedAt: news['datetime'],
            content: news['summary'],
            sourceName: news['source'],
          ),
        );
      }
    }
  }

  //https://finnhub.io/api/v1/company-news?symbol=AMZN&from=2021-03-01&to=2021-03-09&token=c4dlgpqad3icnt8rkag0
  Future<void> getStockNewsByQuery(query) async {
    //query will contain the symbol of the company
    final link = Uri.parse(
        "https://finnhub.io/api/v1/company-news?symbol=AMZN&from=2021-03-01&to=2021-03-09&token=c4dlgpqad3icnt8rkag0");

   //format and put the current date and previous date in the url using intl package    
   final currentDate = DateFormat.yMd(DateTime.now());
   final someDaysBehind = DateFormat.yMd(DateTime.now().subtract(Duration(days: 2)));
    final response = await http.get(link);
    final res = json.decode(response.body);
    print(res);

    for (var news in res) {
      if ( news['headline'] != null &&
          news['related'] != null &&
          news['url'] != null &&
          news['image'] != null &&
          news['datetime'] != null &&
          news['summary'] != null &&
          news['source'] != null) {

        _companyWiseNews.add(News(
          title: news['headline'],
          description: news['related'],
          url: news['url'],
          urlToImage: news['image'],
          publishedAt: news['datetime'],
          content: news['summary'],
          sourceName: news['source'],
        )
        );
        print('.........................................');
        print(news['headline'].toString());
      }
    }
  }

  News? getNewsByUrl(url, type) {
    if (type == 'everything') {
      for (var news in _latestHeadlines) {
        if (news.url == url) {
          return news;
        }
      }
    } else {
      for (var news in _companyWiseNews) {
        if (news.url == url) {
          return news;
        }
      }
    }
  }
}

//https://finnhub.io/api/v1/news?category=general&token=c4dlgpqad3icnt8rkag0
//api key finhub -   c4dlgpqad3icnt8rkag0


//old functions 
//in overview news
// for (var news in res["articles"]) {
//   if (news["title"] != null &&
//       news["description"] != null &&
//       news["url"] != null &&
//       news["urlToImage"] != null &&
//       news["publishedAt"] != null &&
//       news["content"] != null &&
//       news["source"]["name"] != null) {
//     _length++;
//     _latestHeadlines.add(
//       News(
//         title: news["title"],
//         description: news["description"],
//         url: news["url"],
//         urlToImage: news["urlToImage"],
//         publishedAt: news["publishedAt"],
//         content: news["content"],
//         sourceName: news["source"]["name"],
//       ),
//     );
//   }
// }

//comapany wise news
// Future<void> getStockNewsByQuery(query) async {
//   final link = Uri.parse(
//       "https://newsapi.org/v2/everything?q={query}&sortBy=popularity&apiKey=9417487a30c2456e90da08fd903d5487");

//   final response = await http.get(link);
//   final res = json.decode(response.body);

//   for (var news in res["articles"]) {
//     if (news["title"] != null &&
//         news["description"] != null &&
//         news["url"] != null &&
//         news["urlToImage"] != null &&
//         news["publishedAt"] != null &&
//         news["content"] != null &&
//         news["source"]["name"] != null) {
//       _length++;
//       _latestHeadlines.add(
//         News(
//           title: news["title"],
//           description: news["description"],
//           url: news["url"],
//           urlToImage: news["urlToImage"],
//           publishedAt: news["publishedAt"],
//           content: news["content"],
//           sourceName: news["source"]["name"],
//         ),
//       );
//     }
//   }
// }
