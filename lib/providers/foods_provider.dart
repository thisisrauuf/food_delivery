import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future<void> toggleFavouriteStatus(String token, String userID) async {
    final oldStatus = isfavourite;
    isfavourite = !isfavourite;
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/userFavourites/$userID/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: jsonEncode(
          isfavourite,
        ),
      );
      if (response.statusCode >= 400) {
        isfavourite = oldStatus;
      }
    } catch (e) {
      isfavourite = oldStatus;
    }
  }
}

class Foods extends ChangeNotifier {
  String authToken;
  String userID;
  Foods(this.authToken, this.userID, this._foods);
  List<Food> _foods = [];

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/foods.json?auth=$authToken');
    final url2 = Uri.parse(
        'https://food-delivery-d3817-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final favouriteResponse = await http.get(url2);
      final favouriteData = jsonDecode(favouriteResponse.body);
      List<Food> loadedFoods = [];
      extractedData.forEach((foodID, foodData) {
        loadedFoods.add(
          Food(
            id: foodID,
            name: foodData['title'],
            image: foodData['imageUrl'],
            price: foodData['price'],
            category: foodData['category'],
            isfavourite:
                favouriteData == null ? false : favouriteData[foodID] ?? false,
          ),
        );
      });
      _foods = loadedFoods;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  UnmodifiableListView<Food> get foods => UnmodifiableListView(_foods);

  void updateFavourite(Food food, String token, String userID) {
    food.toggleFavouriteStatus(token, userID);
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
