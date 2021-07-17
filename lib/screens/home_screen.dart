import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '/constants.dart';
import '/components/search_bar.dart';
import '/components/appBar.dart';
import 'food_details_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: '',
        actions: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: kIconButtonColor,
            size: 31.w,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('images/icons/icon_list.png'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: Text(
                  'Delicious \nfood for you',
                  style: TextStyle(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SearchBar(),
              SizedBox(height: 40.h),
              FoodsCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodsCarousel extends StatefulWidget {
  @override
  _FoodsCarouselState createState() => _FoodsCarouselState();
}

class _FoodsCarouselState extends State<FoodsCarousel> {
  int selectedIndex = 0;
  // bool _isInit = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => {
          Provider.of<Foods>(context, listen: false).fetchData(),
        });
    super.initState();
  }
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     Provider.of<Foods>(context).fetchData();
  //     print('reloded');
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final foodsData = Provider.of<Foods>(context);
    String selectedCategory = category[selectedIndex];
    List<Food> foods = foodsData.findByCategory(selectedCategory);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.w),
          child: Container(
              height: 41.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              category[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? kOrangeColor
                                    : kIconButtonColor,
                                fontSize: 17.sp,
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : null,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 45.w,
                              child: Divider(
                                thickness: 3.0.h,
                                color: selectedIndex == index
                                    ? kOrangeColor
                                    : kBackgroundColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Container(
            width: double.infinity,
            height: 350.h,
            child: PageView.builder(
              // onPageChanged: (value) {},
              controller: PageController(
                initialPage: 0,
                viewportFraction: 0.8,
              ),
              itemCount: foods.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(FoodDetailScreen.routeName,
                      arguments: foods[index].id);
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 30.h, top: 150.h),
                      margin: EdgeInsets.only(top: 51.h, right: 40.w),
                      height: 300.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            foods[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            '${foods[index].price} \$',
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
                      margin: EdgeInsets.only(right: 40.w),
                      child: Hero(
                        tag: foods[index].id,
                        child: Image.network(
                          foods[index].image,
                          height: 165.h,
                          width: 200.w,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}