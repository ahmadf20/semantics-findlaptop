import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Laptop',
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NunitoSans',
      ),
      home: HomePage(),
    );
  }
}
