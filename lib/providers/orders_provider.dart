import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/foods_provider.dart';

class OrderItem {
  final String id;
  final int orderNumber;
  final int amount;
  final DateTime date;
  final List<CartItem> products;
  OrderItem({
    required this.id,
    required this.orderNumber,
    required this.amount,
    required this.date,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  // final String authToken;

  // Orders(this.authToken, this.userID, this._orders);
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int countItems(OrderItem order) {
    return order.products.length;
  }

  Future<void> fetchOrders() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    print(userID);
    final data = await FirebaseFirestore.instance
        .collection('orders/$userID/userOrders')
        .get();
    data.docs.forEach((document) {
      print(document.id);
      print(document['amount']);
      print(document['dateTime']);
      // print(document.get('products'));
    });

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
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    String authToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders/$userID.json?auth=$authToken');
    int orderNumber = 0;
    _orders.forEach((element) {
      if (element.orderNumber > orderNumber) {
        orderNumber = element.orderNumber;
      }
    });
    final time = DateTime.now();

    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'orderNumber': orderNumber + 1,
          'dateTime': time.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'quantity': e.quantity,
                    'foodTitle': e.food.name,
                    'foodCategory': e.food.category,
                    'foodImageUrl': e.food.image,
                    'foodPrice': e.food.price,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: jsonDecode(response.body)['name'],
        orderNumber: orderNumber + 1,
        amount: total,
        date: time,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  OrderItem findOrderById(String id) {
    return _orders.firstWhere((element) => element.id == id);
  }
}
