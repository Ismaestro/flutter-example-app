import 'package:flutter/material.dart';
import 'package:flutter_example_app/tabs/first.dart';
import 'package:flutter_example_app/tabs/second.dart';
import 'package:flutter_example_app/tabs/third.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localizations.dart';

void main() {
  runApp(new MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale("en"),
        Locale("es")
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).title,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(AppLocalizations.of(context).title),
        backgroundColor: Color(0xFF3f51b5),
      ),
      body: new TabBarView(
        children: <Widget>[new FirstTab(), new SecondTab(), new ThirdTab()],
        controller: controller,
      ),
      bottomNavigationBar: new Material(
        color: new Color(0xFF3f51b5),
        child: new TabBar(
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.search),
              ),
              new Tab(
                icon: new Icon(Icons.favorite),
              ),
              new Tab(
                icon: new Icon(Icons.view_list),
              ),
            ],
            controller: controller,
            indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 0)),
            labelPadding: EdgeInsets.only(bottom: 16.0)),
      ),
    );
  }
}
