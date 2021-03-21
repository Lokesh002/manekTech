import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manektech_project/Screens/cart.dart';
import 'package:manektech_project/backEnd/bloc/checkout..dart';

import 'package:manektech_project/backEnd/sizeConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Pagination/reloadListView.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  SizeConfig screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.only(left: screenSize.screenWidth * 5),
                child: Center(
                  child: Text("Mobile List",
                      style: TextStyle(
                          color: Colors.white,
                          textBaseline: TextBaseline.ideographic,
                          fontSize: screenSize.screenHeight * 2.5)),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 5,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: screenSize.screenWidth * 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Checkout()));
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            body: ReloadListView()));
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press back again to exit!");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
