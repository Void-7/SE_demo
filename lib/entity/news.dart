import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<News>> getNews() async {
  final res = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e66f80f120db4635ac604c5fbbfff67c'));

  if (res.statusCode == 200) {
    Map jsonMap = jsonDecode(res.body);
    var data = Data.fromJson(jsonMap);
    return data.articles;
  } 
}

class Data {
  String status;
  num totalResults;
  List<News> articles = [];

  Data({this.status, this.totalResults, this.articles});
  @override
  String toString() {
    return 'status:$status,\ntotalResults:$totalResults,\narticles:$articles';
  }

  Data.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        totalResults = json['totalResults'] {
    if (json['articles'] != null) {
      json['articles'].forEach((i) {
        if (i['author'] == null) i['author'] = 'null';
        if (i['content'] == null) i['content'] = 'Damn!There\'s no content!';
        articles.add(News.fromJson(i));
      });
    }
  }
}

class News {
  String author;
  String title;
  String content;
  String date;

  News.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        title = json['title'],
        content = json['content'],
        date = json['publishedAt'];

  News({this.author, this.title, this.content, this.date});
  @override
  String toString() {
    return 'author:$author title:$title date:$date content:$content';
  }
}
