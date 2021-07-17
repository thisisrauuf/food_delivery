import 'package:flutter/material.dart';
import 'package:food_delivery/components/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/components/radio_form.dart';
import 'package:food_delivery/components/rounded_button.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '/components/userInfoCard.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = 'checkout-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Checkout',
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
          buttonText: 'Order now',
          buttonPress: () {
            orderData.addOrder(cartItems.values.toList(), cart.totalAmount);
            cart.clearCart();
            Navigator.pop(context);
          }),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery',
              style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w600),
            ),
            UserInfoCard(),
            RadioInputForm(),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(
                      '${cart.totalAmount} \$',
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
