import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  int _length = 0;

  List<News> get latestHeadlines {
    return _latestHeadlines;
  }

  int get length {
    return _length;
  }

  Future<void> getData() async {
    final link = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=9417487a30c2456e90da08fd903d5487");

    final response = await http.get(link);
    final res = json.decode(response.body);

    print("Desc ${res["articles"][0]["description"]}");

    for (var news in res["articles"]) {
      if (news["title"] != null &&
          news["description"] != null &&
          news["url"] != null &&
          news["urlToImage"] != null &&
          news["publishedAt"] != null &&
          news["content"] != null &&
          news["source"]["name"] != null) {
        _length++;
        _latestHeadlines.add(
          News(
            title: news["title"],
            description: news["description"],
            url: news["url"],
            urlToImage: news["urlToImage"],
            publishedAt: news["publishedAt"],
            content: news["content"],
            sourceName: news["source"]["name"],
          ),
        );
      }
    }
  }

  Future<void> getStockNewsByQuery(query) async {
    final link = Uri.parse(
        "https://newsapi.org/v2/everything?q={query}&sortBy=popularity&apiKey=9417487a30c2456e90da08fd903d5487");

    final response = await http.get(link);
    final res = json.decode(response.body);

    print("Desc ${res["articles"][0]["description"]}");

    for (var news in res["articles"]) {
      if (news["title"] != null &&
          news["description"] != null &&
          news["url"] != null &&
          news["urlToImage"] != null &&
          news["publishedAt"] != null &&
          news["content"] != null &&
          news["source"]["name"] != null) {
        if (_length >= 20) {
          break;
        }
        _length++;
        _latestHeadlines.add(
          News(
            title: news["title"],
            description: news["description"],
            url: news["url"],
            urlToImage: news["urlToImage"],
            publishedAt: news["publishedAt"],
            content: news["content"],
            sourceName: news["source"]["name"],
          ),
        );
      }
    }
  }
}
