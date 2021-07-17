import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Food extends ChangeNotifier {
  String id;
  String name;
  String image;
  String category;
  int price;
  bool isfavourite;

  Food(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.category,
      this.isfavourite = false});

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isfavourite;
    isfavourite = !isfavourite;
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/foods/$id.json');
    try {
      await http.patch(
        url,
        body: jsonEncode({
          'isFavourite': isfavourite,
        }),
      );
    } catch (e) {
      isfavourite = oldStatus;
    }
  }
}

class Foods extends ChangeNotifier {
  List<Food> _foods = [];

  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/foods.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      List<Food> loadedFoods = [];
      extractedData.forEach((foodID, foodData) {
        loadedFoods.add(
          Food(
              id: foodID,
              name: foodData['title'],
              image: foodData['imageUrl'],
              price: foodData['price'],
              category: foodData['category'],
              isfavourite: foodData['isFavourite']),
        );
      });
      _foods = loadedFoods;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  UnmodifiableListView<Food> get foods => UnmodifiableListView(_foods);

  void updateFavourite(Food food) {
    food.toggleFavouriteStatus();
    notifyListeners();
  }

  List<Food> get favouriteFoods {
    return _foods.where((element) => element.isfavourite == true).toList();
  }

  Food findById(String id) {
    return _foods.firstWhere((element) => element.id == id);
  }

  List<Food> findByCategory(String category) {
    return _foods.where((element) => element.category == category).toList();
  }
}
