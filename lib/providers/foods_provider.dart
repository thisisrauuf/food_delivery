import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<Food> _foods = [];

  Future<void> fetchData() async {
    try {
      var data = await FirebaseFirestore.instance.collection('foods').get();
      List<Food> loadedFoods = [];
      data.docs.forEach((element) {
        loadedFoods.add(Food(
          id: element.id,
          name: element['title'],
          image: element['imageUrl'],
          price: element['price'],
          category: element['category'],
        ));
      });
      _foods = loadedFoods;
      notifyListeners();
    } on PlatformException catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
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
