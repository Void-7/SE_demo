import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage() {
    print('HomePage()');
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Tech Shore'),
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
            body: assDisplay(),
            floatingActionButton: FloatingActionButton(
                onPressed: getNews,
                backgroundColor: Colors.white,
                child: Icon(Icons.edit, size: 30, color: Colors.deepPurple))));
  }
}

//百万/十万/万以上的单独显示单位，以下的直接显示
String cov2w(num x) {
  if (x > 1e9) return 'B+';
  return x > 1e4
      ? x > 1e5
          ? x > 1e6
              ? (x ~/ 1e6).toString() + 'M+'
              : (x ~/ 1e3).toString() + 'K+'
          : (x ~/ 1e3).toString() + 'K+'
      : x.toString();
}

final _news = [];

class assDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 3),
        Container(
            margin: EdgeInsets.all(3),
            height: 160,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('images/rec.png'), fit: BoxFit.cover)),
            child: Center(
              child: Text('Recommend',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )),
        // Dynamic(),
        SizedBox(height: 4),
      ],
    );
  }
}

getNews() async {
  final res = await http.get(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=e66f80f120db4635ac604c5fbbfff67c');
  if (res.statusCode == 200) {
    print(res.body);
    // Map json = convert.jsonDecode(res.body);
    // json.
    // var news = News.fromJson(json);
    // print(news);
  } else {
    print('oops');
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
        date = json['publishAt'];

  News({this.author, this.title, this.content, this.date});
  @override
  String toString() {
    return 'author:${this.author} title:${this.title} date:${this.date} content:${this.content}';
  }
}

class Dynamic extends StatelessWidget {
  final String author;
  final String title;
  final String content;
  final String date;
  Dynamic({this.author, this.title, this.content, this.date});

  @override
  Widget build(BuildContext context) {
    var text = Text(this.date, style: TextStyle(color: Colors.black54));
    return Container(
        margin: EdgeInsets.all(3),
        height: 205,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromRGBO(245, 245, 245, 0.9)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment(0, 0),
                        heightFactor: 1.4,
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: AssetImage('images/cat.jpg'),
                        ))
                  ],
                )),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                        child: Text(this.author,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                    Container(child: text),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                        child: Container(
                      child: Text(
                        this.content,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )),
                    Container(
                        child: Row(children: [
                      Expanded(
                          child: Row(
                        children: [
                          IconButton(
                              iconSize: 28,
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {}),
                          Expanded(
                              child: Text(cov2w(Random().nextInt(1e6.toInt())),
                                  style: TextStyle(fontSize: 17)))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: [
                          IconButton(
                              iconSize: 26,
                              icon: Icon(Icons.chat_bubble_outline),
                              onPressed: () {}),
                          Expanded(
                              child: Text(cov2w(Random().nextInt(1e6.toInt())),
                                  style: TextStyle(fontSize: 17)))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: [
                          IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.star_border),
                              onPressed: () {}),
                          Expanded(
                              child: Text(cov2w(Random().nextInt(1e6.toInt())),
                                  style: TextStyle(fontSize: 17)))
                        ],
                      ))
                    ]))
                  ],
                )),
          ],
        ));
  }
}
