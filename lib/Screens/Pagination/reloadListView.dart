import 'package:flutter/material.dart';
import 'package:manektech_project/Components/reusableUserCard.dart';
import 'package:manektech_project/Screens/MobileDetailsScreen.dart';
import 'package:manektech_project/Screens/Pagination/notifier.dart';
import 'package:manektech_project/backEnd/bloc/cart_items_bloc.dart';
import 'package:manektech_project/backEnd/mobile.dart';
import 'package:manektech_project/backEnd/sizeConfig.dart';

class ReloadListView extends StatefulWidget {
  const ReloadListView({Key key}) : super(key: key);

  @override
  _ReloadListViewState createState() => _ReloadListViewState();
}

class _ReloadListViewState extends State<ReloadListView> {
  MobileNotifier notifier;
  SizeConfig screenSize;
  @override
  void initState() {
    super.initState();
    notifier = MobileNotifier();
    notifier.getMore();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return ValueListenableBuilder<List<Mobile>>(
        valueListenable: notifier,
        builder: (BuildContext context, List<Mobile> value, Widget child) {
          if (value != null && value.isNotEmpty) {
            print(value.length);
            bloc.allItems.addAll({'shop items': value});
          }
          return value != null
              ? value.isEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return const Center(child: Text('No Mobile!'));
                      })
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification &&
                            scrollInfo.metrics.extentAfter == 0) {
                          notifier.getMore();
                          return true;
                        }
                        return false;
                      },
                      child: StreamBuilder(
                        initialData:
                            bloc.allItems, // The bloc was already instantiated.
                        stream:
                            bloc.getStream, // The stream we'll be listing to
                        builder: (context, snapshot) {
                          // snapshot contains the data of the bloc
                          return snapshot != null
                              ? shopItemsListBuilder(snapshot)
                              : Center(
                                  child: Text(
                                      "All items in shop have been taken"));
                        },
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ));
        });
  }

  Widget shopItemsListBuilder(snapshot) {
    return Column(
      children: [
        Container(
          height: screenSize.screenHeight * 88,
          child: ListView.builder(
              itemCount: snapshot.data["shop items"].length,
              physics: const AlwaysScrollableScrollPhysics(),
              cacheExtent: 5,
              padding: EdgeInsets.only(top: 20),
              itemBuilder: (BuildContext context, index) {
                final List<Mobile> shopList = snapshot.data["shop items"];
                return ReusableMobileCard(
                  title: snapshot.data['shop items'][index].title,
                  image: snapshot.data['shop items'][index].imageURL,
                  bookmarked: snapshot.data['shop items'][index].bookmarked,
                  id: snapshot.data['shop items'][index].id,
                  price: snapshot.data['shop items'][index].price,
                  status: snapshot.data['shop items'][index].status,
                  onAddToCartTap: () {
                    if (snapshot.data['shop items'][index].bookmarked) {
                      snapshot.data['shop items'][index].bookmarked = false;
                      bloc.removeFromCart(shopList[index]);
                    } else {
                      snapshot.data['shop items'][index].bookmarked = true;
                      bloc.addToCart(shopList[index]);
                    }
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MobileDetailsScreen(
                                snapshot.data['shop items'][index])));
                  },
                );
              }),
        ),
      ],
    );
  }
}
