import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manektech_project/backEnd/sizeConfig.dart';
import 'package:manektech_project/Components/card.dart';
import 'package:provider/provider.dart';

class ReusableMobileCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String image;
  final Function onAddToCartTap;

  final String status;
  final int price;
  final int id;

  final bool bookmarked;
  ReusableMobileCard(
      {this.title,
      this.onTap,
      this.image,
      this.status,
      this.onAddToCartTap,
      this.price,
      this.id,
      this.bookmarked});

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: screenSize.screenWidth * 3,
              right: screenSize.screenWidth * 3),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: onTap,
                child: ReusableCard(
                  color: Colors.white,
                  width: screenSize.screenWidth * 94,
                  // height: screenSize.screenHeight * 10,
                  cardChild: Row(
                    children: <Widget>[
                      SizedBox(
                        width: screenSize.screenWidth * 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.screenHeight * 2),
                        child: SizedBox(
                          width: screenSize.screenWidth * 15,
                          height: screenSize.screenWidth * 25,
                          child: SizedBox(
                            child: (image != null)
                                ? FadeInImage.assetNetwork(
                                    placeholder: 'icons/img.png',
                                    image: this.image)
                                : Image.asset('icons/img.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.screenWidth * 3,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.screenHeight * 1,
                          ),
                          Container(
                            width: screenSize.screenWidth * 65,
                            height: screenSize.screenHeight * 3,
                            child: Text(
                              '$title',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.screenHeight * 2,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.screenHeight * 1,
                          ),
                          Row(
                            children: [
                              Container(
                                width: screenSize.screenWidth * 45,
                                height: screenSize.screenHeight * 3,
                                child: Text(
                                  'Rs. $price',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: screenSize.screenHeight * 2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              MaterialButton(
                                onPressed: onAddToCartTap,
                                color: Theme.of(context).primaryColor,
                                height: screenSize.screenHeight * 5,
                                minWidth: screenSize.screenWidth * 10,
                                child: Icon(
                                  bookmarked
                                      ? Icons.remove_shopping_cart
                                      : Icons.add_shopping_cart_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenSize.screenHeight * 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.screenHeight * 2,
              )
            ],
          ),
        ),
      ],
    );
  }
}
