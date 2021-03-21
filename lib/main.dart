import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'index/index.dart';

void main() {
  debugPaintSizeEnabled = false;

  if (Platform.isAndroid) {
    // 这一步设置状态栏颜色为透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    print('MyApp()');
  }

  @override
  Widget build(BuildContext context) {
    print('MyApp build()');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '导航栏demo',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: index());
  }
}
