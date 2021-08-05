// import 'package:flutter/material.dart';
// import 'package:food_delivery/providers/foods_provider.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// // import 'package:flutter_layout_grid/flutter_layout_grid.dart';


// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final foodsData = Provider.of<Foods>(context);
//     final foods = foodsData.foods;
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             foodsData.fetchData();
//             // var url = Uri.parse(
//             //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/foods.json');
//             // foods.forEach((element) {
//             //   http.post(
//             //     url,
//             //     body: json.encode({
//             //       'title': element.name,
//             //       'imageUrl': element.image,
//             //       'isFavourite': false,
//             //       'price': element.price,
//             //       'category': element.category,
//             //     }),
//             //   );
//             // });
//           },
//           child: Text('Click'),
//         ),
//       ),
//     );
//   }
// }

// class Terbaj extends StatelessWidget {
//   int index = 0;

//   Color randomColor() {
//     this.index++;
//     return index % 2 == 0 ? Colors.red : Colors.yellow;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutGrid(
//       columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
//       rowSizes: [1.fr, 1.fr, 1.fr, 1.fr],
//       children: [
//         GridPlacement(
//           columnStart: 0,
//           columnSpan: 2,
//           rowStart: 1,
//           rowSpan: 1,
//           child: Container(
//             color: Color.fromRGBO(250, 74, 12, 1),
//           ),
//         ),
//         GridPlacement(
//           columnStart: 1,
//           columnSpan: 2,
//           rowStart: 1,
//           rowSpan: 2,
//           child: Container(
//             color: Color.fromRGBO(150, 90, 30, 0.7),
//           ),
//         ),
//       ],
//     );
//   }
// }

// ------------------------------------------------------


// ------------------------------------------------------

    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDBj8qd47FhNb8-DZgbe3R2pV7Gj8PlElw');
    // try {
    //   final response = await http.post(
    //     url,
    //     body: jsonEncode(
    //       {
    //         'email': email,
    //         'password': password,
    //         'returnSecureToken': true,
    //       },
    //     ),
    //   );
    //   final responseData = jsonDecode(response.body);
    //   if (responseData['error'] != null) {
    //     throw HttpException(responseData['error']['message']);
    //   }
    //   _token = responseData['idToken'];
    //   _userId = responseData['localId'];
    //   _expiryDate = DateTime.now()
    //       .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    //   notifyListeners();
    // } catch (e) {
    //   throw e;
    // }

// ------------------------------------------------------

// final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDBj8qd47FhNb8-DZgbe3R2pV7Gj8PlElw');
    // try {
    //   final response = await http.post(
    //     url,
    //     body: jsonEncode(
    //       {
    //         'email': email,
    //         'password': password,
    //         'returnSecureToken': true,
    //       },
    //     ),
    //   );
    //   final responseData = jsonDecode(response.body);
    //   if (responseData['error'] != null) {
    //     throw HttpException(responseData['error']['message']);
    //   }
    //   _token = responseData['idToken'];
    //   _userId = responseData['localId'];
    //   // _expiryDate = DateTime.now()
    //   //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    //   notifyListeners();
    // } catch (e) {
    //   throw e;
    // }

// ------------------------------------------------------

// Fetch Orders 

// String authToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    // String userID = FirebaseAuth.instance.currentUser!.uid;
    // final url = Uri.parse(
    //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders/$userID.json?auth=$authToken');
    // final response = await http.get(url);
    // List<OrderItem> loadedOrders = [];
    // dynamic jsonBody = jsonDecode(response.body);
    // if (jsonBody == null) {
    //   return;
    // }
    // final extractedData = jsonBody as Map<String, dynamic>;
    // extractedData.forEach((key, value) {
    //   loadedOrders.insert(
    //     0,
    //     OrderItem(
    //       id: key,
    //       orderNumber: value['orderNumber'],
    //       amount: value['amount'],
    //       date: DateTime.parse(value['dateTime']),
    //       products: (value['products'] as List<dynamic>)
    //           .map((item) => CartItem(
    //                 food: Food(
    //                     id: item['id'],
    //                     name: item['foodTitle'],
    //                     image: item['foodImageUrl'],
    //                     price: item['foodPrice'],
    //                     category: item['foodCategory']),
    //                 id: item['id'],
    //                 quantity: item['quantity'],
    //               ))
    //           .toList(),
    //     ),
    //   );
    // });
    // _orders = loadedOrders;
    // notifyListeners();    

// ------------------------------------------------------

// add order

// String authToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    // String userID = FirebaseAuth.instance.currentUser!.uid;
    // final url = Uri.parse(
    //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders/$userID.json?auth=$authToken');
    // int orderNumber = 0;
    // _orders.forEach((element) {
    //   if (element.orderNumber > orderNumber) {
    //     orderNumber = element.orderNumber;
    //   }
    // });
    // final time = DateTime.now();

    // final response = await http.post(url,
    //     body: jsonEncode({
    //       'amount': total,
    //       'orderNumber': orderNumber + 1,
    //       'dateTime': time.toIso8601String(),
    //       'products': cartProducts
    //           .map((e) => {
    //                 'id': e.id,
    //                 'quantity': e.quantity,
    //                 'foodTitle': e.food.name,
    //                 'foodCategory': e.food.category,
    //                 'foodImageUrl': e.food.image,
    //                 'foodPrice': e.food.price,
    //               })
    //           .toList(),
    //     }));
    // _orders.insert(
    //   0,
    //   OrderItem(
    //     id: jsonDecode(response.body)['name'],
    //     orderNumber: orderNumber + 1,
    //     amount: total,
    //     date: time,
    //     products: cartProducts,
    //   ),
    // );
    // notifyListeners();

// ------------------------------------------------------

// fetch Foods

// String authToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    // String userID = FirebaseAuth.instance.currentUser!.uid;
    // final url = Uri.parse(
    //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/foods.json?auth=$authToken');
    // final url2 = Uri.parse(
    //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$authToken');
    // try {
    //   final response = await http.get(url);
    //   final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    //   final favouriteResponse = await http.get(url2);
    //   final favouriteData = jsonDecode(favouriteResponse.body);
    //   List<Food> loadedFoods = [];
    //   extractedData.forEach((foodID, foodData) {
    //     loadedFoods.add(
    //       Food(
    //         id: foodID,
    //         name: foodData['title'],
    //         image: foodData['imageUrl'],
    //         price: foodData['price'],
    //         category: foodData['category'],
    //         isfavourite:
    //             favouriteData == null ? false : favouriteData[foodID] ?? false,
    //       ),
    //     );
    //   });
    //   _foods = loadedFoods;
    //   notifyListeners();
    // } catch (e) {
    //   throw (e);
    // }
// ------------------------------------------------------

    // Food(
    //     id: 'f1',
    //     name: 'Steak plat',
    //     image: 'https://i.ibb.co/c1GZc8Z/plat1.png',
    //     price: 22,
    //     category: 'Plat',
    //     isfavourite: false),
    // Food(
    //     id: 'f3',
    //     name: 'Chicken plat',
    //     image: 'https://i.ibb.co/PjCpvx5/plat3.png',
    //     price: 49,
    //     category: 'Plat',
    //     isfavourite: false),
    // Food(
    //     id: 'f4',
    //     name: 'Salade',
    //     image: 'https://i.ibb.co/LnSqp35/plat4.png',
    //     price: 35,
    //     category: 'Plat',
    //     isfavourite: false),
    // Food(
    //     id: 'f5',
    //     name: 'Chicken Grilled',
    //     image: 'https://i.ibb.co/NC3xYN8/plat5.png',
    //     price: 12,
    //     category: 'Plat',
    //     isfavourite: false),
    // Food(
    //     id: 'f6',
    //     name: 'Steak Grilled',
    //     image: 'https://i.ibb.co/VTfgxbq/plat6.png',
    //     price: 12,
    //     category: 'Plat',
    //     isfavourite: false),
    // Food(
    //     id: 'f7',
    //     name: 'Margerit Pizza',
    //     image: 'https://i.ibb.co/BLtzSZ9/pizza1.png',
    //     price: 12,
    //     category: 'Pizza',
    //     isfavourite: false),
    // Food(
    //     id: 'f8',
    //     name: 'Merguez Pizza',
    //     image: 'https://i.ibb.co/WGbD8dg/pizza2.png',
    //     price: 12,
    //     category: 'Pizza',
    //     isfavourite: false),
    // Food(
    //     id: 'f9',
    //     name: 'Chicken Pizza',
    //     image: 'https://i.ibb.co/cvCWw90/pizza3.png',
    //     price: 12,
    //     category: 'Pizza',
    //     isfavourite: false),
    // Food(
    //     id: 'f11',
    //     name: 'Meat Pizza',
    //     image: 'https://i.ibb.co/dD5b1J0/pizza5.png',
    //     price: 12,
    //     category: 'Pizza',
    //     isfavourite: false),
    // Food(
    //     id: 'f12',
    //     name: 'Chawarma Sandwich',
    //     image: 'https://i.ibb.co/XpGMVb7/sandwich1.png',
    //     price: 12,
    //     category: 'Sandwich',
    //     isfavourite: false),
    // Food(
    //     id: 'f13',
    //     name: 'Chees Sandwich',
    //     image: 'https://i.ibb.co/gZPy5Lm/sandwich2.png',
    //     price: 12,
    //     category: 'Sandwich',
    //     isfavourite: false),
    // Food(
    //     id: 'f14',
    //     name: 'Mergeuz Sandwich',
    //     image: 'https://i.ibb.co/K6L6WQc/sandwich3.png',
    //     price: 12,
    //     category: 'Sandwich',
    //     isfavourite: false),
    // Food(
    //     id: 'f15',
    //     name: 'Orange Juice',
    //     image: 'https://i.ibb.co/p3Bmw6S/drink1.png',
    //     price: 12,
    //     category: 'Drink',
    //     isfavourite: false),
    // Food(
    //     id: 'f16',
    //     name: 'Grenadine Juice',
    //     image: 'https://i.ibb.co/h85w2yH/drink2.png',
    //     price: 12,
    //     category: 'Drink',
    //     isfavourite: false),
    // Food(
    //     id: 'f17',
    //     name: 'Pome Juice',
    //     image: 'https://i.ibb.co/LkC5wpK/drink3.png',
    //     price: 12,
    //     category: 'Drink',
    //     isfavourite: false),
    // Food(
    //     id: 'f18',
    //     name: 'Orange Juice',
    //     image: 'https://i.ibb.co/xXtjct7/drink4.png',
    //     price: 12,
    //     category: 'Drink',
    //     isfavourite: false),
