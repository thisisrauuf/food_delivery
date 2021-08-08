import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/providers/foods_provider.dart';

class SlidableCard extends StatelessWidget {
  final String productId;
  final String id;
  final int quantity;
  final Food food;
  SlidableCard({
    required this.productId,
    required this.id,
    required this.quantity,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Slidable(
        key: ValueKey(productId),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.18,
        secondaryActions: [
          // Consumer<Foods>(
          //   builder: (context, foods, child) => Center(
          //     child: CircleAvatar(
          //       radius: 22,
          //       backgroundColor: kOrangeColor,
          //       child: IconButton(
          //         onPressed: () {
          //           String id = food.id;
          //           foods.updateFavourite(foods.findById(id));
          //           foods.updateFavourite(food);
          //         },
          //         icon: Icon(
          //           food.isfavourite
          //               ? Icons.favorite
          //               : Icons.favorite_border_outlined,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Center(
            child: CircleAvatar(
              radius: 22,
              backgroundColor: kOrangeColor,
              child: IconButton(
                onPressed: () {
                  cartData.removeItem(productId);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 17.w),
          width: double.infinity,
          height: 102.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      width: 70.w,
                      height: 70.w,
                      child: Image.network(
                        food.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              food.name,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${food.price} \$',
                                    style: TextStyle(
                                      color: kOrangeColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    width: 70.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cartData.quantityMinus(productId);
                            },
                            child: Icon(
                              Icons.remove,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cartData.quantityPlus(productId);
                            },
                            child: Icon(
                              Icons.add,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class SlidableFavouriteCard extends StatelessWidget {
  final Food food;
  SlidableFavouriteCard({required this.food});

  @override
  Widget build(BuildContext context) {
    final foodData = Provider.of<Foods>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Slidable(
        key: ValueKey(food.id),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.18,
        secondaryActions: [
          Consumer<Cart>(
            builder: (context, cartData, child) => Center(
              child: CircleAvatar(
                radius: 22,
                backgroundColor: kOrangeColor,
                child: IconButton(
                  onPressed: () {
                    cartData.addItem(food.id, food);
                  },
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 22,
              backgroundColor: kOrangeColor,
              child: IconButton(
                onPressed: () {
                  foodData.updateFavourite(food);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        child: Container(
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
                  food.image,
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
                          food.name,
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
                        child: Text(
                          '${food.price} £',
                          style: TextStyle(
                            color: kOrangeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
