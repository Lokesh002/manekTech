import 'package:flutter/material.dart';
import 'package:manektech_project/backEnd/sizeConfig.dart';

class ReusableCard extends StatelessWidget {
  final Widget cardChild;
  final Color color;
  final double height;
  final double width;
  ReusableCard({this.cardChild, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Container(
      height: height,
      width: width,
      child: Center(
        child: Material(
          color: this.color,
          elevation: 3.0,
          borderRadius: BorderRadius.all(
            Radius.circular(screenSize.screenHeight * 1),
          ),
          child: cardChild,
        ),
      ),
    );
  }
}
