/// The [dart:async] is necessary for using streams
import 'dart:async';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;
  bool loading = false;

  /// The [allItems] Map would hold all the data this bloc provides
  final Map allItems = {'shop items': [], 'cart items': []};

  /// [addToCart] adds items from the shop to the cart
  void addToCart(item) {
    allItems['cart items'].add(item);
    print('added' + item.toString());
    cartStreamController.sink.add(allItems);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    item.bookmarked = false;
    //allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc(); // add to the end of the file
