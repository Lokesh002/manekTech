import 'package:flutter/material.dart';
import 'package:manektech_project/Components/reusableUserCard.dart';
import 'package:manektech_project/Screens/MobileDetailsScreen.dart';
import 'package:manektech_project/backEnd/bloc/cart_items_bloc.dart';
import 'package:manektech_project/backEnd/mobile.dart';

import '../sizeConfig.dart';

class Checkout extends StatelessWidget {
  SizeConfig screenSize;

  int getTotal(List<dynamic> lms) {
    int total = 0;
    for (int i = 0; i < lms.length; i++) {
      total += lms[i].price;
    }
    return total;
  }

  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.allItems,
        builder: (context, snapshot) {
          return snapshot.data['cart items'].length > 0
              ? Column(
                  children: <Widget>[
                    /// The [checkoutListBuilder] has to be fixed
                    /// in an expanded widget to ensure it
                    /// doesn't occupy the whole screen and leaves
                    /// room for the the RaisedButton
                    Expanded(child: checkoutListBuilder(snapshot)),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qty:',
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.5,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data['cart items'].length.toString(),
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.2,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rs. ' +
                                getTotal(snapshot.data['cart items'])
                                    .toString(),
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 2.5,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                )
              : Center(child: Text("You haven't taken any item yet"));
        },
      ),
    );
  }

  Widget checkoutListBuilder(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data["cart items"].length,
      padding: EdgeInsets.only(top: screenSize.screenHeight * 2),
      itemBuilder: (BuildContext context, index) {
        final cartList = snapshot.data["cart items"];
        return ReusableMobileCard(
          title: snapshot.data['cart items'][index].title,
          image: snapshot.data['cart items'][index].imageURL,
          bookmarked: true,
          id: snapshot.data['cart items'][index].id,
          price: snapshot.data['cart items'][index].price,
          status: snapshot.data['cart items'][index].status,
          onAddToCartTap: () {
            bloc.removeFromCart(cartList[index]);
          },
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MobileDetailsScreen(
                        snapshot.data['cart items'][index])));
          },
        );
      },
    );
  }
}
