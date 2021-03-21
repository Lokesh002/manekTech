import 'package:flutter/material.dart';
import 'package:manektech_project/backEnd/bloc/cart_items_bloc.dart';
import 'package:manektech_project/backEnd/mobile.dart';
import 'package:manektech_project/backEnd/sizeConfig.dart';

class MobileDetailsScreen extends StatefulWidget {
  Mobile mobile;
  MobileDetailsScreen(this.mobile);
  @override
  _MobileDetailsScreenState createState() => _MobileDetailsScreenState();
}

class _MobileDetailsScreenState extends State<MobileDetailsScreen> {
  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Container(
            width: screenSize.screenWidth * 80,
            child: Text(
              widget.mobile.title,
              style: TextStyle(
                  color: Colors.white, fontSize: screenSize.screenHeight * 2.5),
              overflow: TextOverflow.ellipsis,
            )),
      ),
      body: ListView(
        children: [
          Container(
              width: screenSize.screenWidth * 100,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenSize.screenHeight * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.screenHeight * 35,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: screenSize.screenHeight * 35,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.screenHeight * 3),
                              child: (widget.mobile.imageURL != null)
                                  ? FadeInImage.assetNetwork(
                                      placeholder: 'icons/img.png',
                                      image: widget.mobile.imageURL,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset('icons/img.png'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.screenWidth * 5,
                                  vertical: screenSize.screenHeight * 3),
                              child: Container(
                                  height: screenSize.screenHeight * 7,
                                  width: screenSize.screenWidth * 15,
                                  child: FloatingActionButton(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    // height: screenSize.screenHeight * 7,
                                    // minWidth: screenSize.screenWidth * 70,
                                    elevation: 3,
                                    child: Icon(
                                      widget.mobile.bookmarked
                                          ? Icons.remove_shopping_cart
                                          : Icons.add_shopping_cart_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (widget.mobile.bookmarked) {
                                        widget.mobile.bookmarked = false;
                                        bloc.removeFromCart(widget.mobile);
                                        setState(() {});
                                      } else {
                                        widget.mobile.bookmarked = true;
                                        bloc.addToCart(widget.mobile);
                                        setState(() {});
                                      }
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            widget.mobile.title,
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5,
                          vertical: screenSize.screenHeight * 1),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            'Rs. ${widget.mobile.price}',
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.7,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5,
                          vertical: screenSize.screenHeight * 2),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.5,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            widget.mobile.desc,
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.3,
                                fontWeight: FontWeight.normal),
                          ))),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
