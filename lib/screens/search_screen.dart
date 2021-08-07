import 'package:flutter/material.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:food_delivery/screens/food_details_screen.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  static String routName = 'search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var searchResult = ModalRoute.of(context)!.settings.arguments as String;
    final List<Food> foodsResult =
        Provider.of<Foods>(context, listen: false).searchFood(searchResult);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 31.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: searchResult),
                      onSubmitted: (value) {
                        setState(() {
                          searchResult = value;
                        });
                      }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.centerRight, child: Container()),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 37.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffF9F9F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 35.h, left: 34.w, right: 34.w),
              child: Text(
                'Found ${foodsResult.length} results',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 45.h),
            Expanded(
              child: SingleChildScrollView(
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  crossAxisCount: 2,
                  itemCount: foodsResult.length,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 17.h,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, FoodDetailScreen.routeName,
                          arguments: foodsResult[index].id);
                    },
                    child: SearchResultItem(foodsResult: foodsResult[index]),
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultItem extends StatelessWidget {
  SearchResultItem({required this.foodsResult});

  final Food foodsResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            width: double.infinity,
            margin: EdgeInsets.only(top: 40.h),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  foodsResult.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  '${foodsResult.price}',
                  style: TextStyle(
                    color: kOrangeColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Hero(
              tag: foodsResult.id,
              child: Image.network(
                foodsResult.image,
                height: 110.h,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
