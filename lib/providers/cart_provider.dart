import 'package:flutter/material.dart';
import 'package:food_delivery/providers/foods_provider.dart';

class CartItem {
  final Food food;
  final String id;
  int quantity;
  CartItem({
    required this.food,
    required this.id,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {
    // 'f1': CartItem(
    //   food: Food(
    //       id: 'f1',
    //       name: 'Plat Escalop',
    //       image: 'images/foods/food1.png',
    //       price: 22,
    //       category: 'foods'),
    //   id: 'id',
    //   quantity: 1,
    // ),
  };

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.food.price * cartItem.quantity;
    });
    return total;
  }

  void quantityPlus(String productId) {
    _items.update(
        productId,
        (existingItem) => CartItem(
              food: existingItem.food,
              id: existingItem.id,
              quantity: existingItem.quantity + 1,
            ));
    notifyListeners();
  }

  void quantityMinus(String productId) {
    _items.update(
        productId,
        (existingItem) => CartItem(
              food: existingItem.food,
              id: existingItem.id,
              quantity: existingItem.quantity - 1,
            ));
    notifyListeners();
  }

  void addItem(String productId, Food food) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => CartItem(
                food: existingItem.food,
                id: existingItem.id,
                quantity: existingItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                food: food,
                id: DateTime.now().toString(),
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
