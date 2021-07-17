import 'package:flutter/material.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/screens/checkout_screen.dart';
import 'package:provider/provider.dart';
import '/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/components/rounded_button.dart';
import '/components/slidable_card.dart';
import 'food_details_screen.dart';

class CartScreen extends StatelessWidget {
  static final routeName = 'cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Cart',
        actions: Container(),
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
          buttonPress: () {
            Navigator.pushReplacementNamed(context, CheckoutScreen.routeName);
          },
          buttonText: 'Complete order'),
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
              itemCount: cart.itemsCount,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(FoodDetailScreen.routeName,
                      arguments: cartItems.keys.toList()[index]);
                },
                child: SlidableCard(
                  productId: cartItems.keys.toList()[index],
                  id: cartItems.values.toList()[index].id,
                  quantity: cartItems.values.toList()[index].quantity,
                  food: cartItems.values.toList()[index].food,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 17.sp),
                ),
                Text(
                  '${cart.totalAmount} \$',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
