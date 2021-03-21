import 'dart:convert' as convert;
import 'dart:developer';

import 'package:manektech_project/backEnd/sharedPref.dart';

//List<Restaurant> bookedRestaurantLists = [];

class Mobile {
  bool bookmarked;
  String slug;
  String title;
  String desc;
  int price;
  String imageURL;
  String status;
  int id;
}

class MobileDataList {
  //var decData;
  MobileDataList();

  Future<List<Mobile>> getMobiles(decData) async {
    List<Mobile> mobileList = [];
    if (decData['data'] != null || decData['data'] != [])
      for (int i = 0; i < decData['data'].length; i++) {
        Mobile mobile = Mobile();
        mobile.id = decData['data'][i]['id'];
        mobile.slug = decData['data'][i]['slug'];
        mobile.desc = decData['data'][i]['description'];
        mobile.price = decData['data'][i]['price'];
        mobile.imageURL = decData['data'][i]['featured_image'];
        mobile.status = decData['data'][i]['status'];
        mobile.title = decData['data'][i]['title'];
        mobile.bookmarked = false;
        mobileList.add(mobile);
      }

    return mobileList;
  }
}

// class BookMarked {
//   BookMarked();
//   SavedData savedData = SavedData();
//   Future<List<Restaurant>> getBookedUsers() async {
//     List<String> data = List<String>();
//     data = await savedData.getBookedUsers();
//     bookedRestaurantLists = [];
//     if (data != null) {
//       for (int i = 0; i < data.length; i++) {
//         var d = convert.jsonDecode(data[i]);
//
//         Restaurant user = Restaurant();
//         user.username = d['username'].toString();
//         user.photoUrl = d['photoUrl'].toString();
//         user.id = int.parse(d['userId']);
//         user.bookmarked = d['bookmarked'] == 'true' ? true : false;
//         bookedRestaurantLists.add(user);
//       }
//     } else {
//       bookedRestaurantLists = [];
//     }
//     return bookedRestaurantLists;
//   }
//
//   Future<List<Restaurant>> addBookedUsers(Restaurant user) async {
//     bookedRestaurantLists.add(user);
//     await saveBookedUsers();
//     return bookedRestaurantLists;
//   }
//
//   Future<List<Restaurant>> removeBookedUsers(Restaurant user) async {
//     for (int i = 0; i < bookedRestaurantLists.length; i++) {
//       print(bookedRestaurantLists[i].username);
//       if (bookedRestaurantLists[i].id == user.id) {
//         bookedRestaurantLists.remove(bookedRestaurantLists[i]);
//       }
//     }
//     print(user.username);
//     await saveBookedUsers();
//     return bookedRestaurantLists;
//   }
//
//   Future<void> saveBookedUsers() async {
//     List<String> data = List<String>();
//     for (int i = 0; i < bookedRestaurantLists.length; i++) {
//       Map<String, String> userMap = Map<String, String>();
//       userMap.addAll({
//         'username': bookedRestaurantLists[i].username,
//         'photoUrl': bookedRestaurantLists[i].photoUrl,
//         'userId': bookedRestaurantLists[i].id.toString(),
//         'bookmarked': bookedRestaurantLists[i].bookmarked.toString()
//       });
//
//       data.add(convert.jsonEncode(userMap));
//     }
//     savedData.setBookedUsers(data);
//   }
// }
