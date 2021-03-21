import 'dart:async';
import 'dart:developer';
import 'package:manektech_project/Components/reusableUserCard.dart';
import 'package:manektech_project/backEnd/stackPageNavigator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:manektech_project/backEnd/networking.dart';
import 'package:manektech_project/backEnd/mobile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;
import 'package:manektech_project/backEnd/sizeConfig.dart';
import 'package:manektech_project/Components/reusableUserCard.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  SizeConfig screenSize;
  var _formKey = new GlobalKey<FormState>();
  String query = '';
  StackPage<int> firstpageStack = StackPage<int>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //BookMarked bookedUsers = BookMarked();
  bool isReady = false;

  Widget getScreen() {
    if (!isReady) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenSize.screenHeight * 5),
            child: SpinKitWanderingCubes(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              size: 100.0,
            ),
          ),
        ],
      );
    } else {
      return (mobileList.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenSize.screenHeight * 10,
                ),
                Container(
                    height: screenSize.screenHeight * 20,
                    child: Image.asset('icons/img.png')),
                SizedBox(
                  height: screenSize.screenHeight * 5,
                ),
                Text(
                  "Nothing inside cart!!",
                ),
                SizedBox(
                  height: screenSize.screenHeight * 10,
                ),
              ],
            )
          : Container(
              height: screenSize.screenHeight * 90,
              width: screenSize.screenWidth * 100,
              child: ListView.builder(
                  itemBuilder: (BuildContext cntxt, int index) {
                    return ReusableMobileCard(
                      title: mobileList[index].title,
                      image: mobileList[index].imageURL,
                      bookmarked: mobileList[index].bookmarked,
                      id: mobileList[index].id,
                      price: mobileList[index].price,
                      status: mobileList[index].status,
                      onTap: () async {
                        // if (mobileList[index].bookmarked == false) {
                        //   mobileList[index].bookmarked = true;
                        //   await bookedUsers.addBookedUsers(mobileList[index]);
                        // } else {
                        //   mobileList[index].bookmarked = false;
                        //   await bookedUsers.removeBookedUsers(mobileList[index]);
                        // }

                        setState(() {});
                      },
                    );
                  },
                  itemCount: mobileList.length,
                  padding: EdgeInsets.fromLTRB(0, screenSize.screenHeight * 2.5,
                      0, screenSize.screenHeight * 7)),
            ));
    }
  }

  List<Mobile> mobileList = [];
  String previousListUrl;
  int lastUserId;
  int firstUserId;
  int pageFirstUserId;
  int pageLastUserId;

  String nextListUrl;
  void getAllUserData() async {
    // var a = bookedRestaurantLists;
    //
    // if (a != null) {
    //   mobileList = a;
    // } else {
    //   mobileList = [];
    // }

    isReady = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUserData();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    print('hey');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ShoppingCart',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:
            Container(width: screenSize.screenWidth * 100, child: getScreen()),
      ),
    );
  }
}
