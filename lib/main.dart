import 'package:flutter/material.dart';
import 'package:insta_poc/presentation/shop_widget.dart';
import 'package:insta_poc/presentation/web_view.dart';
import 'package:insta_poc/presentation/web_view2.dart';

import 'api/media_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta PoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<InstagramMediaModel> media = [
    InstagramMediaModel(
      id: '1',
      type: '2',
      url:
          'https://scontent.cdninstagram.com/v/t51.2885-15/69241797_2476643462372018_2503523337326421119_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=58wy2ln-uUkAX-DPspd&_nc_ht=scontent.cdninstagram.com&edm=ANQ71j8EAAAA&oh=00_AfDwAV_c4uvcc7TGXPJMEEewNhhvKWOSGjCEkr3snVf3eQ&oe=63C6351D',
      username: 'username',
      timestamp: 'timestamp',
      caption: 'Some text Some text Some text Some text',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // ShopSelectionPage(medias: media, onPressedConfirmation: () {})
          // InstagramAPIWebView(),
          WebView2(),
    );
  }
}
