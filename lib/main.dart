import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manektech_project/Screens/homeScreen.dart';
import 'package:manektech_project/Screens/cart.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return MaterialApp(
      title: 'Github Users',
      theme: ThemeData(
//          primaryColor: primaryColor,
//          accentColor: accentColor,
          primaryColor: Color(0xff27DD93),
          accentColor: Color(0xffffffff),
          backgroundColor: Colors.white),
      initialRoute: '/',
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
        '/bookmarked': (context) => ShoppingCart(),
      },
    );
  }
}
