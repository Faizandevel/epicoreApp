import 'dart:io';

// import 'package:baq/BAQScreen.dart';
import 'package:flutter/material.dart';
import 'package:testproject/BAQScreen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAQ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonsHomeScreen(),
    );
  }
}

class ButtonsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BAQ",
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Center(
        child: FlatButton(
          child: Text("Show BAQ"),
          color: Colors.blue[200],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BAQScreen();
            }));
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
