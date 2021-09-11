import 'package:flutter/material.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
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
        leading: Container(),
      ),
      body: favouriteFoods.length == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  color: kIconButtonColor,
                  size: 140.sp,
                ),
                SizedBox(height: 38.h),
                Text(
                  'Empty',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
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
                        Navigator.of(context).pushNamed(
                            FoodDetailScreen.routeName,
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
