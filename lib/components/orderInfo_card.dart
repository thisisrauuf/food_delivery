import 'package:flutter/material.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class OrderInfoCard extends StatelessWidget {
  final CartItem product;
  const OrderInfoCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 17.w),
      width: double.infinity,
      height: 102.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            width: 70.w,
            height: 70.w,
            child: Image.network(
              product.food.image,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.food.name,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '${product.food.price} \$',
                          style: TextStyle(
                            color: kOrangeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'x ${product.quantity}',
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
