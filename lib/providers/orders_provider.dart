import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    dynamic jsonBody = jsonDecode(response.body);
    if (jsonBody == null) {
      return;
    }
    final extractedData = jsonBody as Map<String, dynamic>;
    extractedData.forEach((key, value) {
      loadedOrders.insert(
        0,
        OrderItem(
          id: key,
          orderNumber: value['orderNumber'],
          amount: value['amount'],
          date: DateTime.parse(value['dateTime']),
          products: (value['products'] as List<dynamic>)
              .map((item) => CartItem(
                    food: Food(
                        id: item['id'],
                        name: item['foodTitle'],
                        image: item['foodImageUrl'],
                        price: item['foodPrice'],
                        category: item['foodCategory']),
                    id: item['id'],
                    quantity: item['quantity'],
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/orders.json');
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
