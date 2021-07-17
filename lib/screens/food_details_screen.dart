import 'package:flutter/material.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/foods_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class FoodDetailScreen extends StatelessWidget {
  static String routeName = '/food-detail';

  @override
  Widget build(BuildContext context) {
    final foodId = ModalRoute.of(context)!.settings.arguments as String;
    final foodData = Provider.of<Foods>(context, listen: false);
    final selectedFood = foodData.findById(foodId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: '',
        actions: Consumer<Foods>(
          builder: (context, foodData, _) => IconButton(
            onPressed: () {
              foodData.updateFavourite(selectedFood);
            },
            icon: selectedFood.isfavourite
                ? Icon(Icons.favorite, color: Colors.red, size: 31.w)
                : Icon(Icons.favorite_border_outlined,
                    color: Colors.black, size: 31.w),
          ),
        ),
        leading: IconButton(
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
      bottomNavigationBar: RoundedButton2(
        buttonText: 'Add to cart',
        buttonPress: () {
          cart.addItem(selectedFood.id, selectedFood);
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20.h),
                height: 450.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: selectedFood.id,
                      child: Image.network(
                        selectedFood.image,
                        width: 240.w,
                        height: 240.h,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Text(
                      selectedFood.name,
                      style: TextStyle(
                          fontSize: 28.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${selectedFood.price} £',
                      style: TextStyle(
                        color: kOrangeColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery info',
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        'Delivered between monday aug and thursday 20 from 8pm to 91:32 pm',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 15.sp),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Return policy',
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        'All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
