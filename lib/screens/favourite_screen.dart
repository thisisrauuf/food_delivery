import 'package:flutter/material.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:provider/provider.dart';
import '/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/components/slidable_card.dart';
import 'food_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  static String routeName = '/favourite-screen';
  @override
  Widget build(BuildContext context) {
    final foodData = Provider.of<Foods>(context);
    final favouriteFoods = foodData.favouriteFoods;

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Favourites',
        actions: Container(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 31.w,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swipe_outlined),
                SizedBox(width: 5),
                Text('swipe on an item to delete'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              itemCount: favouriteFoods.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(FoodDetailScreen.routeName,
                      arguments: favouriteFoods[index].id);
                },
                child: SlidableFavouriteCard(food: favouriteFoods[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
