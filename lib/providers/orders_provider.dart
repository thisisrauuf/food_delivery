import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final int amount;
  final DateTime date;
  final List<CartItem> products;
  OrderItem({
    required this.id,
    required this.amount,
    required this.date,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // int counter = 00000;
  // String putID() {
  //   counter++;
  //   return counter.toString();
  // }

  int countItems(OrderItem order) {
    return order.products.length;
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders.json');
    final time = DateTime.now();
    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'dateTime': time.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'quantity': e.quantity,
                    'food': {
                      'title': e.food.name,
                      'category': e.food.category,
                      'imageUrl': e.food.image,
                      'price': e.food.price,
                    },
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: jsonDecode(response.body)['name'],
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
