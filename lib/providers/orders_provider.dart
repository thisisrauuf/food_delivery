import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/foods_provider.dart';

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
  final List<Food> foods;
  Orders(this.foods, this._orders);

  Food findByID(String id) {
    return foods.firstWhere((element) => element.id == id);
  }

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int countItems(OrderItem order) {
    return order.products.length;
  }

  Future<void> fetchOrders() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final data = await FirebaseFirestore.instance
        .collection('orders/$userID/userOrders')
        .orderBy('dateTime')
        .get();
    List<OrderItem> loadedOrders = [];
    try {
      data.docs.forEach((document) {
        Map<String, dynamic> products = document['products'];
        List<CartItem> myCartItems = [];
        products.forEach((key, value) {
          myCartItems.add(
            CartItem(food: findByID(key), id: '4', quantity: value),
          );
        });

        loadedOrders.insert(
          0,
          OrderItem(
              id: document.id,
              amount: document['amount'],
              date: DateTime.parse(document['dateTime']),
              products: myCartItems),
        );
      });
      _orders = loadedOrders;
      notifyListeners();
    } on PlatformException catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final time = DateTime.now();
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    try {
      orders.doc(userID).set({'1': 1});
      orders.doc(userID).collection('userOrders').add({
        'amount': total,
        'dateTime': time.toIso8601String(),
        'products': cartProducts.fold<dynamic>({}, (value, element) {
          return {
            ...value,
            element.food.id: element.quantity,
          };
        }),
      });
    } on PlatformException catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }
  }

  OrderItem findOrderById(String id) {
    return _orders.firstWhere((element) => element.id == id);
  }
}
