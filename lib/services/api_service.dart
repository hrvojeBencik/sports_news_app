import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports_news/models/article.dart';

class ApiService {
  static const _api_key = "API-GOES-HERE";

  static const _base_url = "bing-news-search1.p.rapidapi.com";

  static const Map<String, String> _headers = {
    "x-rapidapi-host": _base_url,
    "x-rapidapi-key": _api_key,
    "x-bingapis-sdk": "true",
    "useQueryString": "true",
    "accept-language": "en-US,en;q=0.5",
  };

  Future<dynamic> _getRequest({
    @required String endpoint,
    @required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_base_url, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load json data');
    }
  }

  Future<Map> fetchNewsData(String category) async {
    ApiService apiService = ApiService();
    try {
      var result = await apiService._getRequest(
        endpoint: "/news",
        query: {
          "count": "20",
          "category": category,
          "cc": "US",
          "safeSearch": "Off",
          "textFormat": "Raw",
        },
      );
      if (result != null) {
        return result;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  List<Article> processNewsData(Map data) {
    List<Article> articles = [];
    List news = data['value'];
    news.forEach((element) {
      Article article = Article(
        name: element['name'],
        description: element['description'],
        date: element['datePublished'],
        imageUrl: element["image"] == null
            ? ''
            : element["image"]['thumbnail']['contentUrl'],
        url: element['url'],
      );
      articles.add(article);
    });

    return articles;
  }
}
