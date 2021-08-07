import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference favouriteData =
        FirebaseFirestore.instance.collection('favourite');
    await favouriteData.doc(userId).set({'1': 1});
    CollectionReference favourite = FirebaseFirestore.instance
        .collection('favourite/$userId/userFavourite');
    try {
      await favourite.doc(id).set({
        'isFavourite': isfavourite,
      });
    } on PlatformException catch (e) {
      print(e.message);
      isfavourite = oldStatus;
    } catch (error) {
      print(error);
      isfavourite = oldStatus;
    }

    // final oldStatus = isfavourite;
    // isfavourite = !isfavourite;
    // final url = Uri.parse(
    //     'https://food-delivery-d3817-default-rtdb.firebaseio.com/userFavourites/$userID/$id.json?auth=$token');
    // try {
    //   final response = await http.put(
    //     url,
    //     body: jsonEncode(
    //       isfavourite,
    //     ),
    //   );
    //   if (response.statusCode >= 400) {
    //     isfavourite = oldStatus;
    //   }
    // } catch (e) {
    //   isfavourite = oldStatus;
    // }
  }
}

class Foods extends ChangeNotifier {
  List<Food> _foods = [];

  Future<void> fetchData() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    List<Food> loadedFoods = [];
    Map<String, bool> loadedFavourits = {};
    try {
      var data = await FirebaseFirestore.instance.collection('foods').get();
      var favouriteData = await FirebaseFirestore.instance
          .collection('favourite/$userID/userFavourite')
          .get();
      if (favouriteData.docs.length > 0) {
        favouriteData.docs.forEach((element) {
          loadedFavourits.putIfAbsent(element.id, () => element['isFavourite']);
        });
      }
      data.docs.forEach((element) {
        loadedFoods.add(Food(
          id: element.id,
          name: element['title'],
          image: element['imageUrl'],
          price: element['price'],
          category: element['category'],
          isfavourite: loadedFavourits.containsKey(element.id)
              ? loadedFavourits[element.id]!
              : false,
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

  List<Food> searchFood(String searchInput) {
    return _foods
        .where((element) =>
            element.name.toLowerCase().contains(searchInput.toLowerCase()))
        .toList();
  }
}
