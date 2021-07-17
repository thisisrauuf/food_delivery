import 'package:flutter/material.dart';
import 'package:food_delivery/providers/cart_provider.dart';

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

  int counter = 00000;
  String putID() {
    counter++;
    return counter.toString();
  }

  int countItems(OrderItem order) {
    return order.products.length;
  }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
      0,
      OrderItem(
          id: putID(),
          amount: total,
          date: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }

  OrderItem findOrderById(String id) {
    return _orders.firstWhere((element) => element.id == id);
  }
}
