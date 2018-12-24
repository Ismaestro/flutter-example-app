import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example_app/tabs/first.dart';
import 'package:flutter_example_app/tabs/second.dart';
import 'package:flutter_example_app/tabs/third.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

// flutter pub get
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/main.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/main.dart lib/l10n/intl_*.arb
import 'l10n/messages_all.dart';

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) => DemoLocalizations.load(locale);

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

void main() {
  runApp(new MaterialApp(
      title: "Using Tabs",
      home: new MyHome(),
      onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ]));
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
        title: Text(DemoLocalizations.of(context).title),
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
